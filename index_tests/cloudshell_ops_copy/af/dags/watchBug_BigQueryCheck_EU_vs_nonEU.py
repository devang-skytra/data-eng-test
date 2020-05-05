import os
from datetime import datetime, timedelta
from dateutil.relativedelta import relativedelta

from airflow import DAG
from airflow.contrib.operators.bigquery_check_operator import BigQueryCheckOperator


from airflow.utils.dates import days_ago

ds = 'scratch_PaD_EU'


default_args = {
    'owner': 'BA Team',
    'start_date': days_ago(1),
    'retries': 1,  
    'retry_delay': timedelta(seconds = 30)
}

# days_ago(1) [above] and catchup = True [below] are helpful for allowing test scripts to dynamically change '@once' to '@once' to allow a once-only test run labelled with appropiate days_ago(1) run date
with DAG('watchBug_BigQueryCheck_EU_vs_nonEU', schedule_interval = None, catchup = True, default_args = default_args) as dag:

    ds = 'scratch_PaD_EU'
    bqCheckParamsX7_EU = BigQueryCheckOperator(
        task_id = 'Check-ParamsX7EU',
        sql = f'select X6_gt_X7, X6_fresh from {ds}airflow_params_X7', # {ds}
        bigquery_conn_id = 'bigquery_default',
        use_legacy_sql = True
	)

    ds = 'scratch_PaD'
    bqCheckParamsX7 = BigQueryCheckOperator(
        task_id = 'Check-ParamsX7',
        sql = f'select X6_gt_X7, X6_fresh from {ds}airflow_params_X7', # {ds}
        bigquery_conn_id = 'bigquery_default',
        use_legacy_sql = True
	)
