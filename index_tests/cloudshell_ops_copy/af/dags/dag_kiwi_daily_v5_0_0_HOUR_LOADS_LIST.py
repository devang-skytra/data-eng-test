import os
from datetime import datetime, timedelta

from airflow import models # models needed to access models.Variable
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.contrib.operators.bigquery_check_operator import BigQueryCheckOperator
from py import slack_messages, op_gen # these are Paul_D py modules in py subfolder
from airflow.operators.dummy_operator import DummyOperator
from airflow.utils.trigger_rule import TriggerRule
from airflow.operators.bash_operator import BashOperator

dag_nm = 'dag_kiwi_daily_v5_0_0_HOUR_LOADS_LIST' 

# detect current GCP/GCC Project from airflow vars
gccProject = models.Variable.get('gccProject')
bktMid = models.Variable.get('BucketEnvString')
load_base = f'bq load --project_id={gccProject} --location=EU '

ds = 'kiwi.'
ds_no_dot = ds.replace('.','')

X2_list = []

# this allows us to cater for different config in our various GCP projects
# Cannot backfill > 1 day if schedule_interval = None, so where one-off backfill is the predominate purpose of DAG, set future start_date (2099) and a schedule_interval
prjDict = {
    'skytra-benchmark-devandtest':      
        {'DEBUG_MODE': False,   
            #'afStartDate': datetime(2020, 8, 28), 'afEndDate': datetime(2020, 8, 29), 'cronSched': '0 12 * * *', # “At 12:00.”
            'afStartDate': datetime(2020, 12, 18), 'afEndDate': datetime(2020, 12, 19), 'cronSched': '0 12 * * *', # “At 12:00.”
            'catch': False,
            'dictX2PassValue': 24
        },
    'skytra-benchmark-uat':             
        {'DEBUG_MODE': False, 
            'afStartDate': datetime(2020, 12, 18), 'afEndDate': None, 'cronSched': None,
            'catch': False,
            'dictX2PassValue': 24
        },
    # START removing references to'd-dat-digitalaircrafttransport':   
    'skytra-benchmark-prod':    
        {'DEBUG_MODE': False, 
            'afStartDate': datetime(2020, 1, 1), 'afEndDate': None, 'cronSched': '0 12 * * *',
            'catch': False,
            'dictX2PassValue': 24
        }
}

DEBUG_MODE  = prjDict[gccProject]['DEBUG_MODE']
afStartDate = prjDict[gccProject]['afStartDate']
afEndDate   = prjDict[gccProject]['afEndDate']
cronSched   = prjDict[gccProject]['cronSched']
catch       = prjDict[gccProject]['catch']
# this allows us to have less than complete Stats in non_Prod, dictionaries combined airflow vars (models.Variable...) are a very useful config mgt technique
dictX2PassValue = prjDict[gccProject]['dictX2PassValue']


conn = 'bigquery_default'

default_args = {
    'owner': 'BA Team',
    'start_date': afStartDate, 
    'end_date': afEndDate, 
    #'retries': 1,  
    #'retry_delay': timedelta(seconds = 10),
    'on_failure_callback': slack_messages.task_fail_slack_alert, 
    'task_concurrency': 12
}

sched = (None if DEBUG_MODE else cronSched)
with DAG(dag_nm, max_active_runs = 3, schedule_interval = sched, catchup = catch, default_args = default_args
    , is_paused_upon_creation = True
    ) as dag:


    
    X2DummyNeatener = DummyOperator(task_id = 'X2DummyNeatener')
    X2DummyNeatener.doc_md = """\
    
        Below we collect all 24 Steps into a List to simplify PRECEDENCE / linking at bottom of DAG
        This Dummy simply neatens 24 Steps for a clearer, less confusing, DAG Graph View
        """
    X2DummyNeatener.trigger_rule = TriggerRule.ALL_FAILED

    for i in ['00','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23']:
        
        X2i = op_gen.mk_bash_generic('LoadX2_' + i, 
            #load_base + ' --source_format=PARQUET kiwi.X2_{{ ds_nodash[4:] }} "gs://ext-kiwi-excl-dev-data/data/{{ macros.ds_format(ds,"%Y-%m-%d","y=%Y/m=%m/d=%d") }}/hr=' + i + '/*.gz.parquet"'
            load_base + ' --source_format=PARQUET kiwi.X2_{{ ds_nodash[4:] }} "gs://ext-kiwi-excl-data/data/{{ macros.ds_format(ds,"%Y-%m-%d","y=%Y/m=%m/d=%d") }}/hr=' + i + '/*.gz.parquet"'
            , DEBUG_MODE
        )

        X2_list.append(X2i)


    LoadX2 = BashOperator(task_id = 'LoadX2', bash_command = "gsutil cp gs://a gs://b")    # test deliberate fail X2DummyNeatener.trigger_rule = TriggerRule.ALL_FAILED
    #LoadX2 = BashOperator(task_id = 'LoadX2', bash_command = "echo 'cool'")               # test success
    X5aPartReplace = DummyOperator(task_id = 'X5aPartReplace')

    # PRECEDENCE 
    LoadX2 >> X5aPartReplace
    LoadX2 >> X2DummyNeatener >> X2_list
   


    
