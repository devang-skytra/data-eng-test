--bq ls --format=json | jq -r '.[] | select(.location == "EU") | .id' | sed 's/:/./' | sed 's/\(.*\)/SELECT * FROM `\1.__TABLES__` UNION ALL/'

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


