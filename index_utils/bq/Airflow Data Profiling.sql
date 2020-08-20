
--Airflow Data Profiling

--Ad Hoc Query
SELECT * 
FROM task_instance 
WHERE dag_id like '%iwi%' and operator like 'BigQueryOperator%' and state = 'success' and start_date > DATE'2020-01-01'

/* then in bq import into log.af_lk2020_temp
insert into log.airflow_load
select 'QUERY' as job_type, 'COMPLETE' as job_status, start_date as start_time, end_date as end_time, 'kiwi' as dataset_id, replace(replace(replace(task_id,'-',''),'2020','$2020'),'2019','$2019') as table_id, 0, 0, 0 
from log.af_lk2020_temp
where start_date <= TIMESTAMP_DIFF'2020-07-14'

SELECT CONCAT(dataset_id,'.',table_id) as table_id, start_time, end_time, TIMESTAMP_DIFF(end_time, start_time, SECOND) AS seconds 
from log.airflow_load 
order by end_time desc

SELECT CONCAT(ds,'.',tb,'$',replace(CAST(dateFrom as STRING),'-','')) as table_id, ts_start as start_time, ts_end as end_time, TIMESTAMP_DIFF(ts_end, ts_start, SECOND) AS seconds 
from log.proc_load 
order by end_time desc
*/


--Charts

SELECT 
dag_id as DagName, TRUNC(execution_date) as tseries, count(*) as ccount 
FROM task_instance 
WHERE dag_id like '%May%' and state = 'success'
GROUP BY 1,2


SELECT  
dag_id, min( execution_date) as minExec, max( execution_date) as maxExec
FROM `d-dat-digitalaircrafttransport.log.airflow_log_exports` 
group by 1
order by 1


airflow_log_exports_ext
airflow-log-exports/*.csv


--insert into log.airflow_log_exports
select * 
except( job_id, pid), 
CAST(job_id as INT64) as job_id, CAST(pid as INT64) as pid 
from log.airflow_log_exports_ext
where 
dag_id like
'%iwi_2020_X2%'
and operator like 'BigQueryOperator%'




SELECT  *
FROM `d-dat-digitalaircrafttransport.log.airflow_log_exports` 
where 
dag_id like
'%iwi_2020_X2%'
and operator not like 'BigQueryOperator%'
order by task_id

delete log.airflow_log_exports where 
dag_id like
'%iwi_2020_X2%'
and operator like 'BigQueryOperator%'
