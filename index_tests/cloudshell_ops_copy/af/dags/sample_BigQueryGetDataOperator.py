import os
from datetime import datetime, timedelta
from dateutil.relativedelta import relativedelta

from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators.python_operator import PythonOperator
from airflow.contrib.operators.bigquery_get_data import BigQueryGetDataOperator

from airflow.utils.dates import days_ago

DEBUG_MODE = True

def getTS():
    dt = datetime.now()
    return [ int(dt.strftime("%Y%m%d%H%M%S%f")) , dt.strftime("%Y-%m-%d %H:%M:%S.%f UTC") ]

def mk_bash_generic(tid, bsh):
    cmd = (f'echo {bsh}' if DEBUG_MODE else bsh)
    op = BashOperator(task_id = tid, bash_command = cmd)
    return op


default_args = {
    'owner': 'BA Team',
    'start_date': days_ago(1),
    'retries': 1,  
    'retry_delay': timedelta(seconds = 30)
}

# days_ago(1) [above] and catchup = True [below] are helpful for allowing test scripts to dynamically change '@once' to '@once' to allow a once-only test run labelled with appropiate days_ago(1) run date
with DAG('sample_BigQueryGetDataOperator', schedule_interval = None, catchup = True, default_args = default_args) as dag:
   
    bqGetParamsX7 = BigQueryGetDataOperator(
        task_id = 'Get-ParamsX7',
        dataset_id = 'index',
        table_id = 'airflow_params_X7',
        max_results = '1'
    )

    bashEchoList = mk_bash_generic('EchoList', '{{ ti.xcom_pull("Get-ParamsX7")[0][1] }}' )

    pyGetTsX7i = PythonOperator(task_id = 'Get-TsX7i', python_callable = getTS, xcom_push = True)

    bashEcho2 = mk_bash_generic('bashEcho2', '{{ ti.xcom_pull("Get-TsX7i")[0] }}' )

    # PRECEDENCE 
    bqGetParamsX7 >> bashEchoList
    pyGetTsX7i >> bashEcho2
