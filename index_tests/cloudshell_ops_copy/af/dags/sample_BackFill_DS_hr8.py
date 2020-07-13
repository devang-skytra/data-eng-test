# gsutil cp ~/ops/af/dags/sample_Back*.py gs://europe-west2-benchmark-devt-6ca0db0f-bucket/dags

import os
from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.bash_operator import BashOperator

DEBUG_MODE = False

default_args = { 
    'owner': 'BA Team', 
    'depends_on_past': False, 
    'start_date': datetime(2020, 6, 1, 8), 
    'end_date': datetime(2020, 6, 4, 9)
}

sched = (None if DEBUG_MODE else '@daily')
with DAG('sample_BackFill_DS_hr8', schedule_interval = sched, catchup=True, default_args=default_args) as dag:
    
    echo_DS = BashOperator( task_id = 'echo_DS', bash_command = 'echo {{ ds }}' )