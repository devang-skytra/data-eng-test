import os
from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.bash_operator import BashOperator



cmd_base = 'bq query --location=EU --use_legacy_sql=false "'

default_args = {
    'owner': 'BA Team',
    'start_date': datetime(2020, 1, 1)
}


dag = DAG(
    dag_id = 'dag_Matching_X6_TEST',
    catchup = False,
    default_args = default_args,
    schedule_interval = None
    )

with dag:
    bashX6_FinalOutput_2020_04_06=BashOperator(task_id='Bash-FinalOutput_2020_04_06',bash_command=cmd_base+"CALL matching_sp.sp_process_X6('FinalOutput_2020-04-06_w_2020-04-12_Global.csv',2);"+'"')
    bashX6_FinalOutput_2020_04_13=BashOperator(task_id='Bash-FinalOutput_2020_04_13',bash_command=cmd_base+"CALL matching_sp.sp_process_X6('FinalOutput_2020-04-13_w_2020-04-19_Global.csv',2);"+'"')
    #bashX6_FinalOutput_2020_04_20=BashOperator(task_id='Bash-FinalOutput_2020_04_20',bash_command=cmd_base+"CALL matching_sp.sp_process_X6('FinalOutput_2020-04-20_w_2020-04-26_Global.csv',56);"+'"')
    #bashX6_FinalOutput_2020_04_27=BashOperator(task_id='Bash-FinalOutput_2020_04_27',bash_command=cmd_base+"CALL matching_sp.sp_process_X6('FinalOutput_2020-04-27_w_2020-05-03_Global.csv',56);"+'"')
    #bashX6_FinalOutput_2020_05_04=BashOperator(task_id='Bash-FinalOutput_2020_05_04',bash_command=cmd_base+"CALL matching_sp.sp_process_X6('FinalOutput_2020-05-04_w_2020-05-10_Global.csv',56);"+'"')
    #bashX6_FinalOutput_2020_05_11=BashOperator(task_id='Bash-FinalOutput_2020_05_11',bash_command=cmd_base+"CALL matching_sp.sp_process_X6('FinalOutput_2020-05-11_w_2020-05-17_Global.csv',56);"+'"')


    bashX6_FinalOutput_2020_04_06 >> bashX6_FinalOutput_2020_04_13
    #bashX6_FinalOutput_2020_04_13 >> bashX6_FinalOutput_2020_04_20
    #bashX6_FinalOutput_2020_04_20 >> bashX6_FinalOutput_2020_04_27
    #bashX6_FinalOutput_2020_04_27 >> bashX6_FinalOutput_2020_05_04
    #bashX6_FinalOutput_2020_05_04 >> bashX6_FinalOutput_2020_05_11
    