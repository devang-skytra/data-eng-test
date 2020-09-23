import os
from datetime import datetime, timedelta

from airflow import models # models needed to access models.Variable
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.contrib.operators.bigquery_check_operator import BigQueryCheckOperator
from airflow.operators.dummy_operator import DummyOperator
from py import slack_messages, op_gen # these are Paul_D py modules in py subfolder


dag_nm = 'dag_matching_TriggerTest' 

# detect current GCP/GCC Project from airflow vars
gccProject = models.Variable.get('gccProject')

ds = 'matching.'
ds_no_dot = ds.replace('.','')

# this allows us to cater for different config in our various GCP projects
prjDict = {
    'skytra-benchmark-devandtest':      
        {'DEBUG_MODE': False, 
            'afStartDate': datetime(2020, 7, 29), 'afEndDate': datetime(2020, 9, 30), 'cronSched': None,
            'catch': False, 'max_days': 2
        },
    'skytra-benchmark-uat':             
        {'DEBUG_MODE': False, 
            'afStartDate': datetime(2020, 7, 29), 'afEndDate': datetime(2020, 8, 4), 'cronSched': '0 7 * * *',
            'catch': False, 'max_days': 2
        },
    'd-dat-digitalaircrafttransport':   
        {'DEBUG_MODE': False, 
            'afStartDate': datetime(2020, 8, 19), 'afEndDate': None, 'cronSched': '0 5 * * *', 
            'catch': False, 'max_days': 35
        },
    'skytra-benchmark-prod':   
        {'DEBUG_MODE': True, 
            'afStartDate': datetime(2020, 8, 19), 'afEndDate': None, 'cronSched': '0 5 * * *', 
            'catch': False, 'max_days': 35
        }
}
DEBUG_MODE = prjDict[gccProject]['DEBUG_MODE']
afStartDate = prjDict[gccProject]['afStartDate']
afEndDate = prjDict[gccProject]['afEndDate']
cronSched = prjDict[gccProject]['cronSched']
catch = prjDict[gccProject]['catch']
max_days = prjDict[gccProject]['max_days']


conn = 'bigquery_default'

default_args = {
    'owner': 'BA Team',
    'start_date': afStartDate, 
    'end_date': afEndDate, 
    'retries': 1,  
    'retry_delay': timedelta(seconds = 10),
    'on_failure_callback': slack_messages.task_fail_slack_alert
}

sched = (None if DEBUG_MODE else cronSched)
with DAG(dag_nm, max_active_runs = 1, schedule_interval = sched, catchup = catch, default_args = default_args) as dag:
 
    tb = 'airflow.af_check_I2'
    # check kiwi have sent all 24 hrs data indicated at least by presence of their stats files on our GCS
    sqlCheckI2 = """
    select {{ ds_nodash }} ExecDate_INT,
    max(dt_of_issue) as dt_of_issue_max,
    count(*) as row_cnt,
    CURRENT_TIMESTAMP ts
    FROM iata.I2
    WHERE 
    dt_of_issue > DATE_SUB(CURRENT_DATE, INTERVAL 4 DAY) 
    AND FILE_SOURCE like CONCAT( '%', FORMAT_DATE( "%Y%m%d", DATE'{{ ds }}' ) ) 
    """
    I2CheckAppend = op_gen.mk_BQO('I2CheckAppend', sqlCheckI2, tb, 'CREATE_NEVER', 'WRITE_APPEND', 1, 1, False, None, None, conn)

    # Only False, 0, "" are what evaluate as False and fail Step
    I2CheckOp = BigQueryCheckOperator(
        task_id = 'I2CheckOp',
        sql = f"""
        select row_cnt >= 500000 
        from {tb} where ExecDate_INT = """ + '{{ ds_nodash }} and DATE(ts) = CURRENT_DATE() order by ts desc LIMIT 1', 
        bigquery_conn_id = conn,
        use_legacy_sql = False
	)

    # Need a Buffer between I2CheckOp and X6 so that loose 'all_done' trigger for X6 still Stops pipeline should I2CheckOp fail
    I2Buffer = DummyOperator(task_id = 'I2Buffer')


    tb = 'airflow.af_check_X5b'
    # check kiwi have sent all 24 hrs data indicated at least by presence of their stats files on our GCS
    sqlCheckX5b = """
    select {{ ds_nodash }} ExecDate_INT,
    max(search_date) as search_date_max,
    count(*) as row_cnt,
    CURRENT_TIMESTAMP ts
    FROM kiwi.X5b
    WHERE 
    search_date = DATE_SUB(DATE'{{ ds }}', INTERVAL 1 DAY)
    """
    X5bCheckAppend = op_gen.mk_BQO('X5bCheckAppend', sqlCheckX5b, tb, 'CREATE_NEVER', 'WRITE_APPEND', 1, 1, False, None, None, conn)

    # Only False, 0, "" are what evaluate as False and fail Step
    X5bCheckOp = BigQueryCheckOperator(
        task_id = 'X5bCheckOp',
        sql = f"""
        select row_cnt >= 1000000000
        from {tb} where ExecDate_INT = """ + '{{ ds_nodash }} and DATE(ts) = CURRENT_DATE() order by ts desc LIMIT 1', 
        bigquery_conn_id = conn,
        use_legacy_sql = False
	)


    X6 = op_gen.mk_bash_sql_query('X6', 'SELECT 1;"', DEBUG_MODE, 'all_done')


    # PRECEDENCE 
    I2CheckAppend  >> I2CheckOp >> I2Buffer 
    X5bCheckAppend >> X5bCheckOp
    [I2Buffer, X5bCheckOp] >> X6 