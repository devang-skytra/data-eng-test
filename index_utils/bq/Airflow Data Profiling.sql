
--Airflow Data Profiling

--Ad Hoc Query
SELECT * 
FROM task_instance 
WHERE dag_id like '%May%' and operator <> "BashOperator" and state = 'success'


--Charts

SELECT 
dag_id as DagName, TRUNC(execution_date) as tseries, count(*) as ccount 
FROM task_instance 
WHERE dag_id like '%May%' and state = 'success'
GROUP BY 1,2