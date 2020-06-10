import os
from datetime import datetime, timedelta
from dateutil.relativedelta import relativedelta
from airflow.utils.dates import days_ago

from airflow import models # models needed to access models.Variable (GCC vars not AF vars?)
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators.python_operator import PythonOperator


default_args = {
    'owner': 'BA Team',
    'start_date': days_ago(1),
    'retries': 1,  
    'retry_delay': timedelta(seconds = 30)
}

with DAG('sample_Test_afJobVisibility', schedule_interval = None, catchup = True, default_args = default_args) as dag:
    
    #testCommand = BashOperator(task_id = 'testCommand', bash_command = 'echo ' + cmd)
    runCommand = BashOperator(task_id = 'runCommand', bash_command = 'bq cp log.proc_load log.proc_load_delete')
