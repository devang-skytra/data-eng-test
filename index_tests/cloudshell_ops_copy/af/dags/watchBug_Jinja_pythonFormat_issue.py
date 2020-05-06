import os
from datetime import datetime, timedelta
from dateutil.relativedelta import relativedelta

from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators.python_operator import PythonOperator

from airflow.utils.dates import days_ago


def getTS():
    dt = datetime.now()
    return [ int(dt.strftime("%Y%m%d%H%M%S%f")) , dt.strftime("%Y-%m-%d %H:%M:%S.%f UTC") ]


default_args = {
    'owner': 'BA Team',
    'start_date': days_ago(1),
    'retries': 1,  
    'retry_delay': timedelta(seconds = 30)
}

# days_ago(1) [above] and catchup = True [below] are helpful for allowing test scripts to dynamically change '@once' to '@once' to allow a once-only test run labelled with appropiate days_ago(1) run date
with DAG('watchBug_Jinja_pythonFormat_issue', schedule_interval = None, catchup = True, default_args = default_args) as dag:

    pyGetTs = PythonOperator(task_id = 'Get-Ts', python_callable = getTS, xcom_push = True)

    # https://issues.apache.org/jira/browse/AIRFLOW-436
    #  Incorrect templating when used with .format
    bashLogNoneSingle = BashOperator(task_id = 'Log-NoneSingle', 
        bash_command = "echo some {{ ti.xcom_pull('Get-TS')[0] }}")

    bashLogSingleSingle = BashOperator(task_id = 'Log-SingleSingle', 
        bash_command = "echo some '{{ ti.xcom_pull('Get-TS')[0] }}'")

    bashLogDoubleDouble = BashOperator(task_id = 'Log-DoubleDouble', 
        bash_command = 'echo "some {{ ti.xcom_pull("Get-TS")[0] }}"')

    cmd_log_sfx = " '{{ ti.xcom_pull('Process-ParamsX7List')[0][2] }}', CURRENT_TIMESTAMP );" + '"'

    pyGetTs >> [bashLogNoneSingle, bashLogSingleSingle, bashLogDoubleDouble]