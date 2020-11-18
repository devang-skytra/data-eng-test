

WITH 
known_new_req as ( SELECT * FROM UNNEST( ['golden_table_airports','golden_table_operating_carriers','golden_ticketing_carriers','index_rrpk_model_params_201811_201911','skytra_index_regions_ext','Ticketing_to_Operating_Carrier'] ) table_id ),
known_not_req as ( SELECT * FROM UNNEST( ['X7','od_cabin_class_mapping','index_lin_reg_params_ext','lin_reg_calibration','ext_EURUSD','ext_USD_EUR_','ext_USD_GBP','ext_EURGBP_','index_rrpk_model_params','traffic_region_abbrv','ext_EURUSD_HIST','full_eur_usd','ticket_rrpk_params_201902_20200','unique_airlines_open_flights','GlobalAirportDatabase','Airline_golden_table','Skytra_Airport_Details_t'] ) table_id ),

rnd as (
SELECT project_id, dataset_id, table_id, TIMESTAMP_MILLIS(creation_time) as creation_time, TIMESTAMP_MILLIS(last_modified_time) as last_modified_time, FORMAT("%'d", row_count) as row_count, FORMAT("%'d", size_bytes) as size_bytes, 
case when type = 3 then 'EXTERNAL' when type = 2 then 'VIEW' END as type FROM `skytra-benchmark-rnd.generic.__TABLES__` 
where TIMESTAMP_MILLIS(creation_time) > TIMESTAMP_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY) OR TIMESTAMP_MILLIS(last_modified_time) > TIMESTAMP_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY) OR type <> 1
),
/*mig as (
SELECT project_id, dataset_id, table_id, TIMESTAMP_MILLIS(creation_time) as creation_time, TIMESTAMP_MILLIS(last_modified_time) as last_modified_time, FORMAT("%'d", row_count) as row_count, FORMAT("%'d", size_bytes) as size_bytes, 
case when type = 3 then 'EXTERNAL' when type = 2 then 'VIEW' END as type FROM `skytra-benchmark-rnd.generic.__TABLES__` 
),*/
uat as (
SELECT project_id, dataset_id, table_id, TIMESTAMP_MILLIS(creation_time) as creation_time, TIMESTAMP_MILLIS(last_modified_time) as last_modified_time, FORMAT("%'d", row_count) as row_count, FORMAT("%'d", size_bytes) as size_bytes, 
case when type = 3 then 'EXTERNAL' when type = 2 then 'VIEW' END as type FROM `skytra-benchmark-uat.generic.__TABLES__` 
)
SELECT 
CASE
 WHEN known_new_req.table_id IS NOT NULL THEN 'KNOWN NEW TABLE'
 WHEN known_not_req.table_id IS NOT NULL THEN 'PROBABLE NOT NEEDED'
  WHEN rnd.table_id = uat.table_id THEN
    CASE 
      WHEN FORMAT('%t', STRUCT(rnd.row_count,rnd.size_bytes,rnd.type)) = FORMAT('%t', STRUCT(uat.row_count,uat.size_bytes,uat.type)) THEN 'PROBABLE FULL MATCH'
      ELSE 'FOUND - NOT MATCHED !!'
    END
  WHEN rnd.table_id IS NOT NULL THEN 'RnD ONLY ?'
  WHEN uat.table_id IS NOT NULL THEN 'UAT ONLY ?'
END as Table_Status,
CONCAT(rnd.project_id,'.',rnd.dataset_id,'.',rnd.table_id) as rnd_key_s, 
rnd.row_count,rnd.size_bytes,rnd.type,rnd.creation_time,rnd.last_modified_time,
CONCAT(uat.project_id,'.',uat.dataset_id,'.',uat.table_id) as uat_key_s,
uat.row_count,uat.size_bytes,uat.type
from 
rnd
--full outer join mig on (rnd.project_id,rnd.dataset_id,rnd.table_id) = (mig.project_id,mig.dataset_id,mig.table_id)
full outer join uat on (rnd.dataset_id,rnd.table_id) = (uat.dataset_id,uat.table_id)
left join known_new_req on rnd.table_id = known_new_req.table_id
left join known_not_req on rnd.table_id = known_not_req.table_id
ORDER BY 1, COALESCE(rnd.table_id,uat.table_id) --type desc, last_modified_time desc


-------------------------------------


WITH extraTableInfo as (
SELECT dataset_id, table_id, TIMESTAMP_MILLIS(last_modified_time) as last_modified_time, FORMAT("%'d", row_count) as row_count, FORMAT("%'d", size_bytes) as size_bytes FROM `kiwi.__TABLES__` UNION ALL
SELECT dataset_id, table_id, TIMESTAMP_MILLIS(last_modified_time) as last_modified_time, FORMAT("%'d", row_count) as row_count, FORMAT("%'d", size_bytes) as size_bytes FROM `matching.__TABLES__` UNION ALL
SELECT dataset_id, table_id, TIMESTAMP_MILLIS(last_modified_time) as last_modified_time, FORMAT("%'d", row_count) as row_count, FORMAT("%'d", size_bytes) as size_bytes FROM `index.__TABLES__` UNION ALL
SELECT dataset_id, table_id, TIMESTAMP_MILLIS(last_modified_time) as last_modified_time, FORMAT("%'d", row_count) as row_count, FORMAT("%'d", size_bytes) as size_bytes FROM `iata.__TABLES__` UNION ALL
SELECT dataset_id, table_id, TIMESTAMP_MILLIS(last_modified_time) as last_modified_time, FORMAT("%'d", row_count) as row_count, FORMAT("%'d", size_bytes) as size_bytes FROM `generic.__TABLES__`
)
SELECT * from extraTableInfo ORDER BY 1 ,last_modified_time desc



-------------------------------------


WITH allDsTables as (

SELECT * FROM generic.INFORMATION_SCHEMA.TABLES   WHERE  table_name in('golden_table_airports','golden_table_operating_carriers','golden_ticketing_carriers','index_rrpk_model_params_201811_201911','spot_window_regions_ext','skytra_index_regions','Ticketing_to_Operating_Carrier') UNION ALL

SELECT * FROM kiwi.INFORMATION_SCHEMA.TABLES      WHERE  table_name in('X5a','X5b_v5') UNION ALL
SELECT * FROM matching.INFORMATION_SCHEMA.TABLES  WHERE  table_name in('X6','X7') UNION ALL
SELECT * FROM index.INFORMATION_SCHEMA.TABLES     WHERE  table_name in('X8','X9','X11','X12','X13') UNION ALL
SELECT * FROM iata.INFORMATION_SCHEMA.TABLES      WHERE  table_name in('X1_Pre_Daily_Merged_v2', 'X3', 'R1', 'R2','R3I3') 
/*
SELECT * FROM `skytra-benchmark-rnd.kiwi.__TABLES__` UNION ALL
SELECT * FROM `skytra-benchmark-rnd.matching.__TABLES__` UNION ALL
SELECT * FROM `skytra-benchmark-rnd.index.__TABLES__` UNION ALL
SELECT * FROM `iata.__TABLES__` 
*/
ORDER BY 1,2
),

unqNames as (select STRUCT(TABLE_SCHEMA, TABLE_NAME) as unq from allDsTables),

extraTableInfo as (

SELECT dataset_id, table_id, TIMESTAMP_MILLIS(last_modified_time) as last_modified_time, FORMAT("%'d", row_count) as row_count, FORMAT("%'d", size_bytes) as size_bytes FROM `generic.__TABLES__`
    WHERE (dataset_id, table_id) IN(SELECT unq from unqNames) UNION ALL
	
SELECT dataset_id, table_id, TIMESTAMP_MILLIS(last_modified_time) as last_modified_time, FORMAT("%'d", row_count) as row_count, FORMAT("%'d", size_bytes) as size_bytes FROM `kiwi.__TABLES__`
  WHERE (dataset_id, table_id) IN(SELECT unq from unqNames) UNION ALL
SELECT dataset_id, table_id, TIMESTAMP_MILLIS(last_modified_time) as last_modified_time, FORMAT("%'d", row_count) as row_count, FORMAT("%'d", size_bytes) as size_bytes FROM `matching.__TABLES__`
  WHERE (dataset_id, table_id) IN(SELECT unq from unqNames) UNION ALL
SELECT dataset_id, table_id, TIMESTAMP_MILLIS(last_modified_time) as last_modified_time, FORMAT("%'d", row_count) as row_count, FORMAT("%'d", size_bytes) as size_bytes FROM `index.__TABLES__`
  WHERE (dataset_id, table_id) IN(SELECT unq from unqNames) UNION ALL
SELECT dataset_id, table_id, TIMESTAMP_MILLIS(last_modified_time) as last_modified_time, FORMAT("%'d", row_count) as row_count, FORMAT("%'d", size_bytes) as size_bytes FROM `iata.__TABLES__`
  WHERE (dataset_id, table_id) IN(SELECT unq from unqNames)
),


allDsTableOptions as (

SELECT TABLE_SCHEMA, table_name,option_name FROM generic.INFORMATION_SCHEMA.TABLE_OPTIONS    WHERE (TABLE_SCHEMA, TABLE_NAME) IN(SELECT unq from unqNames) and option_name = "require_partition_filter" UNION ALL

SELECT TABLE_SCHEMA, table_name,option_name FROM kiwi.INFORMATION_SCHEMA.TABLE_OPTIONS       WHERE (TABLE_SCHEMA, TABLE_NAME) IN(SELECT unq from unqNames) and option_name = "require_partition_filter" UNION ALL
SELECT TABLE_SCHEMA, table_name,option_name FROM matching.INFORMATION_SCHEMA.TABLE_OPTIONS   WHERE (TABLE_SCHEMA, TABLE_NAME) IN(SELECT unq from unqNames) and option_name = "require_partition_filter" UNION ALL
SELECT TABLE_SCHEMA, table_name,option_name FROM index.INFORMATION_SCHEMA.TABLE_OPTIONS      WHERE (TABLE_SCHEMA, TABLE_NAME) IN(SELECT unq from unqNames) and option_name = "require_partition_filter" UNION ALL
SELECT TABLE_SCHEMA, table_name,option_name FROM iata.INFORMATION_SCHEMA.TABLE_OPTIONS       WHERE (TABLE_SCHEMA, TABLE_NAME) IN(SELECT unq from unqNames) and option_name = "require_partition_filter"
ORDER BY 1,2
),
# select * from allDsTableOptions
# SELECT * FROM kiwi.INFORMATION_SCHEMA.COLUMNS WHERE (TABLE_SCHEMA, TABLE_NAME) = STRUCT('kiwi','X5a')

allDsPtn as (

SELECT TABLE_SCHEMA, table_name, ARRAY_AGG(STRUCT(column_name, replace(is_partitioning_column, 'NO', '') as is_partitioning_column, clustering_ordinal_position) ORDER BY is_partitioning_column DESC, clustering_ordinal_position) as part_info FROM generic.INFORMATION_SCHEMA.COLUMNS       
  WHERE (TABLE_SCHEMA, TABLE_NAME) IN(SELECT unq from unqNames) and (is_partitioning_column = "YES" OR clustering_ordinal_position > 0) GROUP BY 1,2 UNION ALL
  
SELECT TABLE_SCHEMA, table_name, ARRAY_AGG(STRUCT(column_name, replace(is_partitioning_column, 'NO', '') as is_partitioning_column, clustering_ordinal_position) ORDER BY is_partitioning_column DESC, clustering_ordinal_position) as part_info FROM kiwi.INFORMATION_SCHEMA.COLUMNS       
  WHERE (TABLE_SCHEMA, TABLE_NAME) IN(SELECT unq from unqNames) and (is_partitioning_column = "YES" OR clustering_ordinal_position > 0) GROUP BY 1,2 UNION ALL
SELECT TABLE_SCHEMA, table_name, ARRAY_AGG(STRUCT(column_name, replace(is_partitioning_column, 'NO', '') as is_partitioning_column, clustering_ordinal_position) ORDER BY is_partitioning_column DESC, clustering_ordinal_position) as part_info FROM matching.INFORMATION_SCHEMA.COLUMNS       
  WHERE (TABLE_SCHEMA, TABLE_NAME) IN(SELECT unq from unqNames) and (is_partitioning_column = "YES" OR clustering_ordinal_position > 0) GROUP BY 1,2 UNION ALL
SELECT TABLE_SCHEMA, table_name, ARRAY_AGG(STRUCT(column_name, replace(is_partitioning_column, 'NO', '') as is_partitioning_column, clustering_ordinal_position) ORDER BY is_partitioning_column DESC, clustering_ordinal_position) as part_info FROM index.INFORMATION_SCHEMA.COLUMNS       
  WHERE (TABLE_SCHEMA, TABLE_NAME) IN(SELECT unq from unqNames) and (is_partitioning_column = "YES" OR clustering_ordinal_position > 0) GROUP BY 1,2 UNION ALL
SELECT TABLE_SCHEMA, table_name, ARRAY_AGG(STRUCT(column_name, replace(is_partitioning_column, 'NO', '') as is_partitioning_column, clustering_ordinal_position) ORDER BY is_partitioning_column DESC, clustering_ordinal_position) as part_info FROM iata.INFORMATION_SCHEMA.COLUMNS       
  WHERE (TABLE_SCHEMA, TABLE_NAME) IN(SELECT unq from unqNames) and (is_partitioning_column = "YES" OR clustering_ordinal_position > 0) GROUP BY 1,2
ORDER BY 1,2
),

allDsPtnFlat as ( select * EXCEPT(part_info), p from allDsPtn, UNNEST(part_info) p )
-- SELECT * FROM allDsPtnFlat

SELECT
CURRENT_TIMESTAMP as Report_As_At,
t.TABLE_CATALOG as BQ_Project,
t.* EXCEPT(table_type,is_insertable_into,is_typed), 
eti.last_modified_time, eti.row_count, eti.size_bytes,
topt.option_name, 
-- ptn.part_info
-- if using allDsPtnFlat, separate columns like so rather than ptn.part_info ARRAY above...
p.column_name, p.is_partitioning_column,	p.clustering_ordinal_position
FROM 
allDsTables t
inner join extraTableInfo eti on  (t.TABLE_SCHEMA, t.TABLE_NAME) = (eti.dataset_id, eti.table_id)
left join allDsTableOptions topt on (t.TABLE_SCHEMA, t.TABLE_NAME) = (topt.TABLE_SCHEMA, topt.TABLE_NAME)
--left join allDsPtn ptn on (t.TABLE_SCHEMA, t.TABLE_NAME) = (ptn.TABLE_SCHEMA, ptn.TABLE_NAME)
-- cannot export to CSV unless flat so for this purpose use allDsPtnFlat
left join allDsPtnFlat ptn on (t.TABLE_SCHEMA, t.TABLE_NAME) = (ptn.TABLE_SCHEMA, ptn.TABLE_NAME)
ORDER BY 3,4,5


-------------------------------------



SELECT 
CONCAT( 'bq cp ', table_schema, '.', table_name, ' scratch_PaD_PreDeployBak_Expire14d.', table_name, '_20200629') as bq_bak 
FROM 
products_IN1139.
INFORMATION_SCHEMA.TABLES
--where table_name like 'P00%'
order by 1


SELECT 
CONCAT( 'cat ', table_name, '.sql | bq query --destination_table ', table_schema, '.', table_name, ' --replace --use_legacy_sql=false ') as bq_qry
FROM 
products_IN1139.
INFORMATION_SCHEMA.TABLES
--where table_name like 'P00%'
order by 1


-bq ls --format=json | jq -r '.[] | select(.location == "EU") | .id' | sed 's/:/./' | sed 's/\(.*\)/SELECT * FROM `\1.__TABLES__` UNION ALL/'

WITH allDsTables as (
SELECT * FROM `d-dat-digitalaircrafttransport.10ct_test.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.Archi_Scratch_Space.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.Audit_outputs_B3_clean.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.Date_leakage_Test.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.Finnair.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.IATA_AUDIT.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.IATA_batch_4_global.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.IATA_cleanup_experiment.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.IATA_full_process.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.KIWI_data_usage.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.KIWI_full_load.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.KIWI_full_load_20mn_sample.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.KIWI_full_process.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.KIWI_pkg_2018_10_11.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.Marketing_Support.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.Marketing_Support_Output.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.Phil_K.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.Phil_SIN_legOD_Asia_EU_Indexes.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.TurkishAir.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.alternative_spot_windows_regions.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.aws_val.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.backasting_index.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.classless_full_process.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.dashboard_production.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.dashboardtables.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.data_eng.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.generic.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.iata.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.iata_2019.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.iata_PROD.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.index.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.input_from_KIWI_10_pct_sample.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.kiwi_PROD.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.kiwi_TEST.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.kiwi_export.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.large_scale_test_v3.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.log.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.matching.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.min_price_X7.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.test635_in567.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.test665_in580.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.test6p6p4.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.test_20180116.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.test_20180701.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.test_6p1p1.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.test_6p1p2.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.test_6p1p3.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.test_6p3p1.__TABLES__`
)

SELECT dataset_id, table_id, 
format("%'d", cast((size_bytes/1073741824) as INT64)) as sizeGiB
FROM allDsTables
WHERE (size_bytes/1073741824) > 5000
ORDER BY size_bytes DESC



WITH tList as ( --INFORMATION_SCHEMA.TABLES INFORMATION_SCHEMA.COLUMNS INFORMATION_SCHEMA.COLUMN_FIELD_PATHS
SELECT * FROM iata_PROD.INFORMATION_SCHEMA.COLUMNS  WHERE table_name not in('') UNION ALL
SELECT * FROM index.INFORMATION_SCHEMA.COLUMNS      WHERE table_name not in('') UNION ALL
SELECT * FROM kiwi_PROD.INFORMATION_SCHEMA.COLUMNS  WHERE table_name not in('') UNION ALL
SELECT * FROM kiwi_export.INFORMATION_SCHEMA.COLUMNS WHERE table_name not in('') UNION ALL
SELECT * FROM log.INFORMATION_SCHEMA.COLUMNS        WHERE table_name not in('') UNION ALL
SELECT * FROM matching.INFORMATION_SCHEMA.COLUMNS   WHERE table_name not in('X6_modified','X6a')

)
SELECT
replace(table_schema, '_PROD', '') as table_schema, table_name, column_name, ordinal_position, is_nullable, data_type, replace(is_partitioning_column, 'NO', '') as is_partitioning_column, clustering_ordinal_position
FROM tList
order by 1,2,4

--SELECT * FROM matching.INFORMATION_SCHEMA.COLUMN_FIELD_PATHS --contains description column which can be specified in JSON


