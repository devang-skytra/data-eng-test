# gsutil cp ~/ops/af/dags/sample_Back*.py gs://europe-west2-benchmark-devt-6ca0db0f-bucket/dags

import os
from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.bash_operator import BashOperator

default_args = { 'owner': 'BA Team', 'depends_on_past': False, 'start_date': datetime(2020, 6, 1), 'schedule_interval': '@daily' }

with DAG('sample_BackFill_DS', catchup=True, default_args=default_args) as dag:
    
    echo_DS = BashOperator( task_id = 'echo_DS', bash_command = 'echo {{ ds }}' )
