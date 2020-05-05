
import os
from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.contrib.operators.bigquery_operator import BigQueryOperator

def getTS():
    dt = datetime.now()
    return [ int(dt.strftime("%Y%m%d%H%M%S%f")) , dt.strftime("%Y-%m-%d %H:%M:%S.%f UTC") ]


default_args = {
    'owner': 'BA Team',
    'start_date': datetime(2020, 1, 1)  
}

with DAG('sample_XCOM_embedded_into_sqlFile', default_args = default_args, schedule_interval = None
	) as dag:
    
    pyGetTsX7 = PythonOperator(task_id = 'Get-TsX7', python_callable = getTS, xcom_push = True)

    bqX7 = BigQueryOperator(
        task_id = 'X7',
        sql = f'./sq/X7.sql',
        destination_dataset_table = 'scratch_PaD_EU.in1135_X7',
        create_disposition = 'CREATE_NEVER',
        write_disposition = 'WRITE_TRUNCATE',
        allow_large_results = True,
        use_legacy_sql = False,
        retries = 1,  
        retry_delay = timedelta(minutes = 30)
    )

    pyGetTsX7 >> bqX7 
