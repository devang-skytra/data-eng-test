
import os
from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.contrib.operators.bigquery_operator import BigQueryOperator

def getTS():
  return int(datetime.now().strftime("%Y%m%d%H%M%S%f"))


default_args = {
    'owner': 'BA Team',
    'start_date': datetime(2020, 1, 1)  
}

with DAG('sample_PyOpTime_as_ForeignKey', default_args = default_args, schedule_interval = None
	) as dag:

    pyGetTS = PythonOperator(
        task_id = 'Get-TS',
        python_callable = getTS,
        #provide_context = True, # need to specify def with openargs for this I think
        xcom_push = True
    )
    
    bqSelectMigrToRnD = BigQueryOperator(
        task_id = 'SelectMigr-ToRnD',
        sql = 'SELECT ts, "{{ ti.xcom_pull("Get-TS") }}" msg from d-dat-digitalaircrafttransport.log.debug_any where msg like "bq%"',
        destination_dataset_table = 'd-dat-digitalaircrafttransport:log.debug_any',
        create_disposition = 'CREATE_NEVER',
        write_disposition = 'WRITE_APPEND',
        use_legacy_sql = False
    )

    pyGetTS >> bqSelectMigrToRnD 
