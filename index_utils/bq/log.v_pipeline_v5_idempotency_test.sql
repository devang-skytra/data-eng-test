

create or replace view log.v_pipeline_v5_idempotency_test as
with 
# select * from log.v_pipeline_v5_idempotency_test
# delete log.pipeline_v5_idempotency_test where ts  in('2020-11-08 13:08:11.377218 UTC', '2020-11-08 13:10:36.346290 UTC' ,'2020-11-08 14:27:52.640689 UTC')
allr as (select *, CAST(REPLACE(row_count,',','') AS INT64) AS rc_int from log.pipeline_v5_idempotency_test),
mints as (select min(ts) as mints from allr),
b as (select * from allr, mints where ts = mints.mints ),
a as (select *,
  row_number()  over(partition by table_id order by last_modified_time) as rown,
  lag(rc_int)   over(partition by table_id order by last_modified_time) as rc_int_prev,
  lag(rc_int,2) over(partition by table_id order by last_modified_time) as rc_int_prev2      
  from allr, mints where ts > mints.mints)
#select * from a

select 
b.dataset_id,b.table_id,b.row_count as Baseline_20200730,
ARRAY_AGG(
  STRUCT(
    a.row_count,
    CASE 
      WHEN a.row_count is NULL THEN NULL
      
      # at this point we are at Row 1 
      WHEN rown = 1 THEN
        CASE 
        WHEN a.rc_int < b.rc_int THEN CONCAT(FORMAT("%'d", (b.rc_int - a.rc_int)), ' rows truncated') 
        ELSE ' ** NO TRUNCATION ** ' 
        END
        
      WHEN a.rc_int = b.rc_int THEN 'Matches Baseline' 
          
      # at this point we are at Row 2 AND do NOT have 'Matches Baseline'
      WHEN rown = 2 THEN
        # here we don't Match         # NO LONGER CORRECT,   have less rows than baseline but last step has inserted some rows after expected truncation at rown = 1
        CASE 
        WHEN b.rc_int <> a.rc_int     # NO LONGER NEEDED ,    AND a.rc_int > IFNULL(a.rc_int_prev, 0) 
        THEN CONCAT( FORMAT( "%'d", (a.rc_int - b.rc_int)), ' rows inserted, ', FORMAT("%'d", ABS(a.rc_int - b.rc_int)), CASE WHEN (a.rc_int > b.rc_int) THEN ' MORE' ELSE ' LESS' END,' rows than baseline')
        END

      # at this point we are past Row 2 
      WHEN a.rc_int = IFNULL(a.rc_int_prev, 0) THEN ' ** NO TRUNCATION ** ' 
      WHEN a.rc_int < IFNULL(a.rc_int_prev, 0) THEN CONCAT(FORMAT("%'d", (b.rc_int - a.rc_int)), ' rows truncated') 
      WHEN a.rc_int <> a.rc_int_prev2 
        THEN CONCAT( FORMAT( "%'d", a.rc_int - IFNULL(a.rc_int_prev, 0)), ' rows inserted, ', FORMAT("%'d", ABS(a.rc_int - a.rc_int_prev2)), CASE WHEN (a.rc_int > IFNULL(a.rc_int_prev2, 0)) THEN ' MORE' ELSE ' LESS' END,' table rows than prior day')

    END as Delta,
    DATE_ADD(DATE'2020-07-26', INTERVAL CAST(trunc((1 + rown) / 2) AS INT64) DAY) as data_date,
    a.ts
    ) 
  order by a.last_modified_time
) as row_delta

from b 
left join a on b.table_id = a.table_id
where substr(b.table_id,1,3) not in('ext','int','x1_') 
group by 1,2,3
order by 2



/*
create or replace table log.pipeline_v5_idempotency_test as
	WITH extraTableInfo as (
	SELECT dataset_id, table_id, TIMESTAMP_MILLIS(last_modified_time) as last_modified_time, FORMAT("%'d", row_count) as row_count, FORMAT("%'d", size_bytes) as size_bytes FROM `matching.__TABLES__` UNION ALL
	SELECT dataset_id, table_id, TIMESTAMP_MILLIS(last_modified_time) as last_modified_time, FORMAT("%'d", row_count) as row_count, FORMAT("%'d", size_bytes) as size_bytes FROM `index.__TABLES__` UNION ALL
	SELECT dataset_id, table_id, TIMESTAMP_MILLIS(last_modified_time) as last_modified_time, FORMAT("%'d", row_count) as row_count, FORMAT("%'d", size_bytes) as size_bytes FROM `iata.__TABLES__` 
	)
	SELECT 
	current_timestamp as ts, * 
	from extraTableInfo
	where substr(table_id,1,3) not in('ext','int')
	ORDER BY 1,2 # last_modified_time desc
	
	#during processing run to ensure capture removal or current partition rows
	
	
	WITH extraTableInfo as (
	SELECT dataset_id, table_id, TIMESTAMP_MILLIS(last_modified_time) as last_modified_time, FORMAT("%'d", row_count) as row_count, FORMAT("%'d", size_bytes) as size_bytes FROM 
	
	`iata.__TABLES__` 
	WHERE TIMESTAMP_MILLIS(last_modified_time) > TIMESTAMP_SUB(current_timestamp, INTERVAL 5 MINUTE )
	
	)
	SELECT 
	current_timestamp as ts, * 
	from extraTableInfo
	where substr(table_id,1,3) not in('ext','int')
	ORDER BY 1,2 # last_modified_time desc
*/