import os
from datetime import datetime, timedelta
from dateutil.relativedelta import relativedelta

from airflow import DAG
from airflow.contrib.operators.bigquery_check_operator import BigQueryCheckOperator


from airflow.utils.dates import days_ago


default_args = {
    'owner': 'BA Team',
    'start_date': days_ago(1),
    'retries': 1,  
    'retry_delay': timedelta(seconds = 30)
}

# days_ago(1) [above] and catchup = True [below] are helpful for allowing test scripts to dynamically change '@once' to '@once' to allow a once-only test run labelled with appropiate days_ago(1) run date
with DAG('watchFixed_BigQueryCheck_Legacy_vs_Standard', schedule_interval = None, catchup = False, default_args = default_args) as dag:

    bqCheck_Legacy = BigQueryCheckOperator(
        task_id = 'bqCheck_Legacy',
        sql = f'select username from generic.api_username', 
        bigquery_conn_id = 'bigquery_default',
        use_legacy_sql = True
	)

    ds = 'scratch_PaD.'
    bqCheck_Standard = BigQueryCheckOperator(
        task_id = 'bqCheck_Standard',
        sql = f'select username from generic.api_username', 
        bigquery_conn_id = 'bigquery_default',
        use_legacy_sql = False
	)
