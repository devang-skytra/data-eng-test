# gsutil cp ~/ops/af/dags/sample_Cross*.py gs://europe-west2-benchmark-devt-6ca0db0f-bucket/dags
"""
25 tgtProject = 'skytra-benchmark-devandtest'
26 srcBucket = '-dev-'
55 sample_CrossProject_BigQueryTest_CLI_and_BQO_DEV"""
import os
from datetime import datetime, timedelta
from dateutil.relativedelta import relativedelta
from airflow.utils.dates import days_ago

from airflow import models # models needed to access models.Variable (GCC vars not AF vars?)
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.contrib.operators.bigquery_operator import BigQueryOperator
from airflow.contrib.operators.bigquery_to_gcs import BigQueryToCloudStorageOperator

quer_base = "bq query --project_id={} --use_legacy_sql=false 'SELECT COUNT(*) FROM log.proc_load'"
load_base = 'bq load --project_id={} --replace --source_format=PARQUET kiwi.X2_t "gs://ext-kiwi-excl{}data/data/y=2020/m=04/d=01/hr=00/part-00000-f2db2561-4c05-40b0-b759-a1e2ac32723a-c000.gz.parquet"'

expo_base = "bq extract --project_id={} --destination_format NEWLINE_DELIMITED_JSON --compression GZIP {} '{}'"
#--location=EU

gcloud_auth = "gcloud auth activate-service-account cloud-composer@skytra-benchmark-devandtest.iam.gserviceaccount.com --key-file /home/airflow/gcs/data/keys/skytra-benchmark-devandtest-f7495a84e893.json && "

tgtProject = 'skytra-benchmark-devandtest'
srcBucket = '-dev-'
gccProject = models.Variable.get('gccProject')

cmd_quer = quer_base.format(tgtProject)
cmd_load = load_base.format(tgtProject, srcBucket)

src = 'log.proc_load'
dest = 'gs://bq-generic{}/{}'.format(srcBucket[:4], src + '.json.gz')
#dest = 'gs://bq-generic{}/{}'.format('-uat', src + '.json.gz')
cmd_expo = expo_base.format(tgtProject, src, dest)

if gccProject == 'skytra-benchmark-devandtest' and tgtProject == 'skytra-benchmark-uat':
    cmd_quer = gcloud_auth + cmd_quer
    cmd_load = gcloud_auth + cmd_load
    cmd_expo = gcloud_auth + cmd_expo
    #echo_str = gcloud_auth + cmd_load

    conn = 'bigquery_UAT' # This connection type seems more sa based than service based
else:
    conn = 'bigquery_default'


default_args = {
    'owner': 'BA Team',
    'start_date': days_ago(1),
    'retries': 1,  
    'retry_delay': timedelta(seconds = 30)
}

with DAG('sample_CrossProject_BigQueryTest_CLI_and_BQO_DEV', schedule_interval = None, catchup = True, default_args = default_args) as dag:
    
    #testCommand = BashOperator(task_id = 'testCommand', bash_command = 'echo ' + cmd)
    """
    runCommand = BashOperator(task_id = 'runCommand', bash_command = cmd)

    runBQO = BigQueryOperator(
    task_id = 'runBQO',
    sql = 'select * from log.proc_load',
    destination_dataset_table = 'log.proc_load_duplicate_delete',
    create_disposition = 'CREATE_IF_NEEDED',
    write_disposition = 'WRITE_APPEND',
    allow_large_results = True,
    use_legacy_sql = False,
    bigquery_conn_id = conn
    )
    """

    bashLoadX2 = BashOperator(
        task_id = 'bashLoadX2',
        bash_command = cmd_load,
        retries = 1,  
        retry_delay = timedelta(seconds = 30)
    )
    """
    bashEcho = BashOperator(
        task_id = 'bashEcho',
        bash_command = 'echo "' + echo_str + '"'
    )
    """

    
    runBashExtract = BashOperator(task_id = 'runBashExtract', bash_command = cmd_expo)
    
    runBQtoGCS = BigQueryToCloudStorageOperator(
    task_id = 'runBQtoGCS',
    source_project_dataset_table = src,
    destination_cloud_storage_uris = [dest],
    export_format = 'JSON',
    bigquery_conn_id = conn
    )

    runBashExtract >> runBQtoGCS
    