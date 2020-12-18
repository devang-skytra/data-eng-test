CREATE OR REPLACE PROCEDURE data_eng.p_generate_dataset_scripts(pj STRING, type STRING, ds_include STRING, ds_exclude STRING)
BEGIN

-- cd ./index_utils/bq/DDL/t
-- file=data_eng.p_infsch.sql
-- cat "$(basename "$file")" | bq query --use_legacy_sql=false 
declare pj string default 'forfree-288615';
declare sq string;

set sq = (
    select  string_agg(concat('select * from `', pj, '.', schema_name, ".__TABLES__` "), 'union all \n')
    from `forfree-288615`.INFORMATION_SCHEMA.SCHEMATA );

execute immediate ('select * from (' || sq || ')');


END

/*
__TABLES__
table_id,creation_date,last_modified_date,row_count,size_bytes,size_mb,size_gb,type,creation_time,last_modified_time,last_modified_month,dataset_id,project_id
project_id,dataset_id,table_id,row_count,size_bytes,type,creation_time,last_modified_time

INFORMATION_SCHEMA.TABLES
table_catalog,table_schema,table_name,table_type,is_insertable_into,is_typed,creation_time


*/


/*
SELECT 
    table_id
    ,DATE(TIMESTAMP_MILLIS(creation_time)) AS creation_date
    ,DATE(TIMESTAMP_MILLIS(last_modified_time)) AS last_modified_date
    ,row_count
    ,size_bytes
    ,round(safe_divide(size_bytes, (1000*1000)),1) as size_mb
    ,round(safe_divide(size_bytes, (1000*1000*1000)),2) as size_gb
    ,CASE
        WHEN type = 1 THEN 'table'
        WHEN type = 2 THEN 'view'
        WHEN type = 3 THEN 'external'
        ELSE '?'
     END AS type
    ,TIMESTAMP_MILLIS(creation_time) AS creation_time
    ,TIMESTAMP_MILLIS(last_modified_time) AS last_modified_time
    ,FORMAT_TIMESTAMP("%Y-%m", TIMESTAMP_MILLIS(last_modified_time)) as last_modified_month
    ,dataset_id
    ,project_id
FROM 
(   
select * from `forfree-288615.austin_bikeshare_cp.__TABLES__` union all 
select * from `forfree-288615.inf_sch_us.__TABLES__` union all 
select * from `forfree-288615.aaa_Crush.__TABLES__` 

select * from `forfree-288615.aaa_Crush.INFORMATION_SCHEMA.TABLES` 

)
ORDER BY dataset_id, table_id asc 
*/
