import os
from datetime import datetime, timedelta

from airflow import models # models needed to access models.Variable
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.contrib.operators.bigquery_check_operator import BigQueryCheckOperator
from py import slack_messages, op_gen # these are Paul_D py modules in py subfolder


dag_nm = 'dag_kiwi_daily_FlatRate' 
tgtProject = 'skytra-benchmark-uat' # this only takes effect in DevTest (see if gccProject block below), providing extra safety for Prod
DEBUG_MODE = False   # DEBUG_MODE always False in source, use DevOps scripts to change to True for DevTest
ds = 'kiwi.'
ds_no_dot = ds.replace('.','')


gcloud_auth = "gcloud auth activate-service-account cloud-composer@skytra-benchmark-devandtest.iam.gserviceaccount.com --key-file /home/airflow/gcs/data/keys/skytra-benchmark-devandtest-f7495a84e893.json && "

# detect current GCP/GCC Project from airflow vars
gccProject = models.Variable.get('gccProject')
bktMid = models.Variable.get('BucketEnvString')

if gccProject == 'skytra-benchmark-devandtest' and tgtProject == 'skytra-benchmark-uat':
    conn = 'bigquery_UAT' # This connection type seems more sa based than service based
    load_base = gcloud_auth + f'bq load --project_id={tgtProject} --location=EU '
    bktMid = '-uat-'
else:
    conn = 'bigquery_default'
    load_base = f'bq load --project_id={gccProject} --location=EU '

# this allows us to have less than complete Stats in non_Prod, dictionaries combined airflow vars (models.Variable...) are a very useful config mgt technique
dictX2PassValue = {'skytra-benchmark-devandtest': '24',
                   'skytra-benchmark-uat': '24',
                   'd-dat-digitalaircrafttransport': '24'}
passVal = dictX2PassValue[gccProject]


default_args = {
    'owner': 'BA Team',
    'start_date': datetime(2020, 1, 1), 
    'end_date': datetime(2020, 7, 11), 
    'retries': 1,  
    'retry_delay': timedelta(seconds = 30),
    'on_failure_callback': slack_messages.task_fail_slack_alert
}

sched = (None if DEBUG_MODE else '@daily')
with DAG(dag_nm, max_active_runs = 1, schedule_interval = None, catchup = False, default_args = default_args) as dag:

    # get a TIMESTAMP to use to Log in BQ (dagStart) AND filter and log using BQ Jobs metadata (tasksLog)
    dagStartPy = PythonOperator(task_id = 'dagStartPy', python_callable = op_gen.getTS, xcom_push = True)

    # log dagStart to BQ
    sqlDAG = "SELECT {{ ds_nodash }} ExecDate_INT, '{{ dag.dag_id }}' dag_id, 'START' entry_type, TIMESTAMP'{{ ti.xcom_pull('dagStartPy')[1] }}' entry_time"
    dagStart = op_gen.mk_BQO('dagStart', sqlDAG, 'log.airflow_dag', 'CREATE_NEVER', 'WRITE_APPEND', 1, 1, DEBUG_MODE, None, None, conn)


    tb = 'airflow.af_check_X2'
    # check kiwi have sent all 24 hrs data indicated at least by presence of their stats files on our GCS
    sqlCheck = """
    select {{ ds_nodash }} ExecDate_INT,
    sum(if(metric_name='parsedKiwiItinerariesAcc', metric_value,0)) KiwiItinAcc,
    sum(if(metric_name='validAirbusItinerariesAcc', metric_value,0)) AirbusItinAcc,
    cast(count(*)/2 as int64) FileCount,
    CURRENT_TIMESTAMP ts
    from stat.kiwi_stats 
    where 
    metric_name in('parsedKiwiItinerariesAcc', 'validAirbusItinerariesAcc') AND 
    _FILE_NAME like '%stat/stats/{{ macros.ds_format(ds,'%Y-%m-%d','y=%Y/m=%m/d=%d') }}/hr%.csv'
    """
    X2CheckAppend = op_gen.mk_BQO('X2CheckAppend', sqlCheck, tb, 'CREATE_NEVER', 'WRITE_APPEND', 1, 1, False, None, None, conn)

    # Only False, 0, "" are what evaluate as False and fail Step
    X2CheckOp = BigQueryCheckOperator(
        task_id = 'X2CheckOp',
        sql = f'select FileCount = {passVal} from {tb} where ExecDate_INT = ' + '{{ ds_nodash }} and DATE(ts) = CURRENT_DATE()', 
        bigquery_conn_id = conn,
        use_legacy_sql = True
	)

    tb = 'X2'
    # {{ }} are jinja2 templates and/or macros evaluated at runtime - they should be kept separate from strings using f'{}' or {}.format which mess jinja2 up
    LoadX2 = op_gen.mk_bash_generic('LoadX2', 
        load_base + f'--replace --source_format=PARQUET kiwi.X2 "gs://ext-kiwi-excl{bktMid}data/data/' + '{{ macros.ds_format(ds,"%Y-%m-%d","y=%Y/m=%m/d=%d") }}/*.gz.parquet"'
    , DEBUG_MODE)

    tb = 'X4'
    # Here we TRUNCATE AND APPEND direct to a single partition in a single step rather than using 2-step process (see old bash truncate step above)
    X4PartReplace = op_gen.mk_BQO(f'{tb}PartReplace', f'./sq/{tb}.sql', f'{ds}{tb}$' + '{{ ds_nodash }}', 'CREATE_NEVER', 'WRITE_TRUNCATE', 1, 5, DEBUG_MODE, 'search_date', None, conn)

    tb = 'X5a'
    X5aPartReplace = op_gen.mk_BQO(f'{tb}PartReplace', f'./sq/{tb}.sql', f'{ds}{tb}$' + '{{ ds_nodash }}', 'CREATE_NEVER', 'WRITE_TRUNCATE', 1, 5, DEBUG_MODE, 'search_date', None, conn)

    tb = 'X5b'
    X5bPartReplace = op_gen.mk_BQO(f'{tb}PartReplace', f'./sq/{tb}.sql', f'{ds}{tb}$' + '{{ ds_nodash }}', 'CREATE_NEVER', 'WRITE_TRUNCATE', 1, 5, DEBUG_MODE, 'search_date', None, conn)


	# our new standard method of logging very useful BQ job meta-info including rows_written
    #  NB: cannot combine jinja templating and params, so cannot pass xcom_pull time so pass in dag_id to help filter sql instead
    tasksLog = op_gen.mk_BQO('tasksLog', './sq/airflow_tasks_log.sql', 'log.airflow_load', 'CREATE_NEVER', 'WRITE_APPEND', 1, 1, DEBUG_MODE, None, 
            dict( dataset_id = f'{ds_no_dot}%', table_id = 'X%', dag_id = dag_nm ), conn
        )

    # log dagEndto BQ
    sqlDAG = "SELECT {{ ds_nodash }} ExecDate_INT, '{{ dag.dag_id }}' dag_id, 'END' entry_type, CURRENT_TIMESTAMP entry_time"
    dagEnd = op_gen.mk_BQO('dagEnd', sqlDAG, 'log.airflow_dag', 'CREATE_NEVER', 'WRITE_APPEND', 1, 1, DEBUG_MODE, None, None, conn)

    # send notf to slack channel
    FinalTaskSendSuccess = op_gen.mk_bash_callback( 'SendSuccess', 'echo "Send Success"', DEBUG_MODE, slack_messages.DAG_success_slack_alert )


    # PRECEDENCE 
    dagStartPy >> dagStart >> X2CheckAppend >> X2CheckOp >> LoadX2 >> X4PartReplace >> X5aPartReplace >> X5bPartReplace >> tasksLog >> dagEnd >> FinalTaskSendSuccess
    