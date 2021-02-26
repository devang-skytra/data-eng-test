# https://stackoverflow.com/questions/46207365/can-a-workflow-with-many-many-subdags-be-performant

from datetime import datetime, timedelta
from airflow.models import DAG
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.subdag_operator import SubDagOperator

dag = DAG(
    'Dag_SubDag_Test1',
    schedule_interval = None,
    start_date = datetime(2017, 1, 1)
)

def make_sub_dag(parent_dag, N):
    dag = DAG(
        '%s.task_%d' % (parent_dag.dag_id, N),
        schedule_interval=parent_dag.schedule_interval,
        start_date=parent_dag.start_date
        )
    DummyOperator(task_id='task1', dag=dag) >> DummyOperator(task_id='task2', dag=dag)
    return dag

downstream_task = DummyOperator(task_id='downstream', dag=dag)
for N in range(20):
    SubDagOperator(
        dag=dag,
        task_id='task_%d' % N,
        subdag=make_sub_dag(dag, N)
        ) >> downstream_task
