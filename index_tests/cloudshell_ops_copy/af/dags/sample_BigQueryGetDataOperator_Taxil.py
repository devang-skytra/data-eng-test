import os
from datetime import datetime, timedelta
from dateutil.relativedelta import relativedelta

from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators.python_operator import PythonOperator
from airflow.contrib.operators.bigquery_get_data import BigQueryGetDataOperator

from airflow.utils.dates import days_ago



default_args = {
    'owner': 'BA Team',
    'start_date': days_ago(1),
    'retries': 1,  
    'retry_delay': timedelta(seconds = 30)
}

with DAG('sample_BigQueryGetDataOperator_Taxil', schedule_interval = None, catchup = False, default_args = default_args) as dag:
   
    bqGetParamsX7 = BigQueryGetDataOperator(
        task_id = 'Get-ParamsX7',
        dataset_id = 'generic',
        table_id = 'divisor_exclusions',
        max_results = '1000'
    )


    def process_data_from_bq(**kwargs):
        ti = kwargs['ti']
        bq_data = ti.xcom_pull(task_ids = 'Get-ParamsX7')

        for r in bq_data:
            process_row(r)

    def process_row(r):
        print('attr1 = ' + r[2])
    
    
    process_data = PythonOperator(
        task_id = 'process_data',
        python_callable = process_data_from_bq,
        provide_context = True
    )


    bqGetParamsX7 >> process_data
