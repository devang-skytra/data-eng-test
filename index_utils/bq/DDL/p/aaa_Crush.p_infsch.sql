CREATE OR REPLACE PROCEDURE aaa_Crush.p_infsch(prj STRING, region STRING, ds_include STRING, tb_exclude STRING, obj_type STRING, op_type STRING)
BEGIN
/*

DECLARE prj DEFAULT 'skytra-benchmark-uat';
# DECLARE prj DEFAULT 'forfree-288615';
DECLARE region STRING DEFAULT 'region-eu';
DECLARE ds_include STRING DEFAULT 'kiwi,iata,matching,index';
DECLARE tb_exclude STRING DEFAULT "'na'";

cd C:\git\DataEng\index_utils\bq\DDL\p

$prj='skytra-benchmark-uat'
$prj='forfree-288615'

cd /media/paul/code/dataeng/index_utils/bq/DDL/f
Get-ChildItem "." -Filter *mnList.sql | 
Foreach-Object {
    $cmd = "(Get-Content $_ -Raw) -replace 'aaa_Crush','eu_aaa_Crush' | bq query --project_id=$prj --use_legacy_sql=false"
    $cmd | Invoke-Expression
}    

CALL data_eng.p_infsch( 'skytra-benchmark-uat', 'region-eu',  "'iata,'", "'na'" ) 

__TABLES__
table_id,creation_date,last_modified_date,row_count,size_bytes,size_mb,size_gb,type,creation_time,last_modified_time,last_modified_month,dataset_id,project_id
project_id,dataset_id,table_id,row_count,size_bytes,type,creation_time,last_modified_time

INFORMATION_SCHEMA.TABLES
table_catalog,table_schema,table_name,table_type,is_insertable_into,is_typed,creation_time

*/

declare sq string;

set sq_ds = (
            select  string_agg(concat(
                CASE op_type
                    WHEN 'TRUNC' THEN 'TRUNCATE TABLE `'
                    WHEN 'SELECT' THEN 'select * from `'
                END, 
                pj, '.', schema_name, ".__TABLES__` "), 'union all \n'
                )
            from 
            `forfree-288615`.INFORMATION_SCHEMA.SCHEMATA 
        );

execute immediate ('select * from (' || sq_ds || ')');

END


select  string_agg(concat('select * from `', prj, '.', schema_name, ".__TABLES__` "), 'union all \n')
from `prj`.INFORMATION_SCHEMA.SCHEMATA
where schema_name in UNNEST(SPLIT(ds_include));

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
