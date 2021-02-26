
# https://www.astronomer.io/guides/subdags

def load_subdag(parent_dag_name, child_dag_name, args):
    dag_subdag = DAG(
        dag_id='{0}.{1}'.format(parent_dag_name, child_dag_name),
        default_args=args,
        schedule_interval="@daily",
    )
    with dag_subdag:
        for i in range(5):
            t = DummyOperator(
                task_id='load_subdag_{0}'.format(i),
                default_args=args,
                dag=dag_subdag,
            )

    return dag_subdag
	
load_tasks = SubDagOperator(
        task_id = 'load_tasks',
        subdag = load_subdag('example_subdag_operator', 'load_tasks', default_args),
        default_args = default_args,
        dag = dag
    )
	
	
# https://stackoverflow.com/questions/46207365/can-a-workflow-with-many-many-subdags-be-performant

from datetime import datetime, timedelta
from airflow.models import DAG
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.subdag_operator import SubDagOperator

dag = DAG(
    'subdaggy-2',
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
		
		
# Paul
		
def load_subdag(parent_dag_name, child_dag_name, args):
    dag_subdag = DAG(
        dag_id='{0}.{1}'.format(parent_dag_name, child_dag_name),
        default_args=args,
        schedule_interval="@daily",
    )
    with dag_subdag:
    
    
    
        for i in range(5):
        
        
        
        
            t = DummyOperator(
                task_id='load_subdag_{0}'.format(i),
                default_args=args,
                dag=dag_subdag,
            )

    return dag_subdag
	
    do_kiwi_API_requests = SubDagOperator(
        task_id = 'load_tasks',
        subdag = load_subdag('example_subdag_operator', 'load_tasks', default_args),
        default_args = default_args,
        dag = dag
    )
		
		
    gather_kiwi_API_requests = PythonOperator(
        task_id = 'call_kiwiAPI_' + i,
        python_callable = kiwi_api_async.kiwi_api_call_async, 
        op_kwargs = {
            'dte_as_str': '{{ macros.ds_add(ds, 1) }}',
            'maxRows': 1000000
            #, 'rChunk':100  rChunk = maxRows / i
        }
    )

		

		
		
		
		