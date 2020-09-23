
REM https://skytra.atlassian.net/browse/IN-1641

airflow
generic
iata
iata_sp
kiwi
log
log_sp
matching
matching_sp
product
stat


gcloud config get-value core/project
gcloud config set core/project skytra-benchmark-prod



SET ds=iata

SET src_prj=d-dat-digitalaircrafttransport
SET dst_prj=skytra-benchmark-prod


REM datasets
REM ****************************************************************************************
bq --location=EU mk --dataset --description "metric gathering for pipeline checks" 	%dst_prj%:airflow
bq --location=EU mk --dataset --description "benchmark and Airtyx products" 		%dst_prj%:product
bq --location=EU mk --dataset --description "_m(odules) broad cat for fxs, sps, vws" %dst_prj%:product_m
REM bq --location=EU mk --dataset --description "stat_sp dataset for sp's only" 		%dst_prj%:stat_sp
REM bq --location=EU mk --dataset --description "index_sp dataset for sp's only" 	%dst_prj%:index_sp
REM bq --location=EU mk --dataset --description "log_sp dataset for sp's only" 		%dst_prj%:log_sp
REM bq --location=EU mk --dataset --description "kiwi_sp dataset for sp's only" 	%dst_prj%:kiwi_sp
REM bq --location=EU mk --dataset --description "stat holds ext stat definitions " 	%dst_prj%:stat
REM bq --location=EU mk --dataset --description "stat_sp dataset for sp's only" 	%dst_prj%:stat_sp
REM bq --location=EU mk --dataset --description "kiwi_export dataset" 				%dst_prj%:kiwi_export
REM bq --location=EU mk --dataset --description "log dataset" 						%dst_prj%:log
REM bq --location=EU mk --dataset --description "matching_sp dataset for sp's only" %dst_prj%:matching_sp
REM bq --location=EU mk --dataset --description "kiwi_export_sp dataset for sp's only" %dst_prj%:kiwi_export_sp
REM bq --location=EU mk --dataset --description "iata_sp dataset for sp's only" %dst_prj%:iata_sp




REM SET ds=iata

REM Delete and Replace (when columns don't match)
REM bq rm -t -f %dst_prj%:%ds_tb%$%dt%
REM bq cp -a -n %src_prj%:%ds_tb%$%dt% %dst_prj%:%ds_tb%


WITH allDsTables as (
SELECT dataset_id, table_id FROM d-dat-digitalaircrafttransport.airflow.__TABLES__   UNION ALL

SELECT dataset_id, table_id FROM d-dat-digitalaircrafttransport.generic.__TABLES__ 
  WHERE table_id in(
    'api_username',
    #'holiday_calendar', #EXTERNAL
    'iata_rrpk_filter_model','kiwi_rrpk_filter_model', 'long_skytra_distance_table','skytra_distance_table','split_layout',
    #'spot_window_regions_ext',
     'divisor_exclusions', 'divisor_keys_airline'
  )  UNION ALL

SELECT dataset_id, table_id FROM d-dat-digitalaircrafttransport.iata.__TABLES__   
  WHERE table_id not like 'ext%' AND table_id not in('X1_v2') UNION ALL
  
SELECT dataset_id, table_id FROM d-dat-digitalaircrafttransport.index.__TABLES__
  WHERE table_id in('X7', 'X7_IATA', 'X7_composite_adjusted') UNION ALL

SELECT dataset_id, table_id FROM d-dat-digitalaircrafttransport.kiwi.__TABLES__
  WHERE table_id not like 'ext%' 
  # AND table_id not in('X5b') 
  AND table_id not in('X4','X5b') 
  UNION ALL

SELECT dataset_id, table_id FROM d-dat-digitalaircrafttransport.log.__TABLES__   
	WHERE table_id not in('load') UNION ALL
SELECT dataset_id, table_id FROM d-dat-digitalaircrafttransport.matching.__TABLES__   UNION ALL
#SELECT dataset_id, table_id FROM d-dat-digitalaircrafttransport.product.__TABLES__   UNION ALL
SELECT dataset_id, table_id FROM d-dat-digitalaircrafttransport.stat.__TABLES__   
  WHERE table_id not like '%tats%' 

)
SELECT CONCAT( 'bq cp -r %s%:', dataset_id, '.', table_id, ' %d%:', dataset_id, '.', table_id  ) FROM allDsTables




SET s=d-dat-digitalaircrafttransport
SET d=skytra-benchmark-prod


REM ENTIRE TABLE COPY
REM ****************************************************************************************

bq cp -f %s%:airflow.af_check_I2 %d%:airflow.af_check_I2
bq cp -f %s%:airflow.af_check_X1 %d%:airflow.af_check_X1
bq cp -f %s%:airflow.af_check_X2 %d%:airflow.af_check_X2
bq cp -f %s%:airflow.af_check_X5b %d%:airflow.af_check_X5b

bq cp -f %s%:generic.api_username %d%:generic.api_username
bq cp -f %s%:generic.iata_rrpk_filter_model %d%:generic.iata_rrpk_filter_model
bq cp -f %s%:generic.kiwi_rrpk_filter_model %d%:generic.kiwi_rrpk_filter_model
bq cp -f %s%:generic.long_skytra_distance_table %d%:generic.long_skytra_distance_table
bq cp -f %s%:generic.skytra_distance_table %d%:generic.skytra_distance_table
bq cp -f %s%:generic.split_layout %d%:generic.split_layout


bq cp -f %s%:iata.I1 %d%:iata.I1
bq cp -f %s%:iata.I2 %d%:iata.I2
bq cp -f %s%:iata.I3 %d%:iata.I3
bq cp -f %s%:iata.X1 %d%:iata.X1
bq cp -f %s%:iata.X3 %d%:iata.X3
bq cp -f %s%:iata.X3_daily %d%:iata.X3_daily
bq cp -f %s%:iata.int_X1_file_analysis %d%:iata.int_X1_file_analysis
bq cp -f %s%:iata.int_X1_repl_tdam %d%:iata.int_X1_repl_tdam

bq cp -f %s%:index.X7 %d%:index.X7
bq cp -f %s%:index.X7_IATA %d%:index.X7_IATA
bq cp -f %s%:index.X7_composite_adjusted %d%:index.X7_composite_adjusted

bq cp -f %s%:kiwi.X2 %d%:kiwi.X2
REM bq cp -f %s%:kiwi.X4 %d%:kiwi.X4
REM bq rm -t -f %d%:kiwi.X5a
bq cp -f %s%:kiwi.X5a %d%:kiwi.X5a


bq cp -f %s%:log.airflow_dag %d%:log.airflow_dag
bq cp -f %s%:log.airflow_load %d%:log.airflow_load
bq cp -f %s%:log.airflow_log_exports %d%:log.airflow_log_exports
REM bq cp -f %s%:log.airflow_log_exports_ext %d%:log.airflow_log_exports_ext EXTERNAL
REM bq cp -f %s%:log.export %d%:log.export
bq cp -f %s%:log.kiwi_api_url_hist %d%:log.kiwi_api_url_hist
bq cp -f %s%:log.load %d%:log.load
REM bq rm -t -f %d%:log.proc_load
bq cp -f %s%:log.proc_load %d%:log.proc_load

bq cp -f %s%:matching.X6 %d%:matching.X6

bq cp -f %s%:stat.X1_discarded %d%:stat.X1_discarded
bq cp -f %s%:stat.X3_discarded %d%:stat.X3_discarded
bq cp -f %s%:stat.metric %d%:stat.metric
bq cp -f %s%:stat.metric_dim %d%:stat.metric_dim



REM CHECKS
REM ****************************************************************************************

REM INFORMATION_SCHEMA.TABLES conveniently has region-eu scope, however...
SELECT *, creation_time > TIMESTAMP_SUB(CURRENT_TIMESTAMP, INTERVAL 3 HOUR) AS SUCCEEDED
FROM `skytra-benchmark-prod.region-eu.INFORMATION_SCHEMA.TABLES`
WHERE table_type not in('VIEW')
# could join allDsTables on ds.tb but why not do all
order by 1,2,3

REM ...INFORMATION_SCHEMA.TABLES does not have last_modified_time so use old __TABLES__  method
WITH allDsTables as (
SELECT * FROM skytra-benchmark-prod.airflow.__TABLES__   UNION ALL

SELECT * FROM skytra-benchmark-prod.generic.__TABLES__ 
  WHERE table_id in(
    'api_username',
    #'holiday_calendar', #EXTERNAL
    'iata_rrpk_filter_model','kiwi_rrpk_filter_model', 'long_skytra_distance_table','skytra_distance_table','split_layout',
    #'spot_window_regions_ext',
     'divisor_exclusions', 'divisor_keys_airline'
  )  UNION ALL

SELECT * FROM skytra-benchmark-prod.iata.__TABLES__   
  WHERE table_id not like 'ext%' AND table_id not in('X1_v2') UNION ALL
  
SELECT * FROM skytra-benchmark-prod.index.__TABLES__
  WHERE table_id in('X7', 'X7_IATA', 'X7_composite_adjusted') UNION ALL

SELECT * FROM skytra-benchmark-prod.kiwi.__TABLES__
  WHERE table_id not like 'ext%' 
  # AND table_id not in('X5b') 
  AND table_id not in('X4','X5b') 
  UNION ALL

SELECT * FROM skytra-benchmark-prod.log.__TABLES__   
	WHERE table_id not in('load') UNION ALL
SELECT * FROM skytra-benchmark-prod.matching.__TABLES__   UNION ALL
#SELECT * FROM skytra-benchmark-prod.product.__TABLES__   UNION ALL
SELECT * FROM skytra-benchmark-prod.stat.__TABLES__   
  WHERE table_id not like '%tats%' 
)

SELECT * EXCEPT(last_modified_time, size_bytes, type), TIMESTAMP_MILLIS(last_modified_time) as last_modified
FROM allDsTables
WHERE TIMESTAMP_MILLIS(last_modified_time) > TIMESTAMP_SUB(CURRENT_TIMESTAMP, INTERVAL 8 HOUR) 


REM CHECKS we can schedule
REM ******************************************

WITH day_int as (select 1 as day_int)
/*
SELECT routine_catalog, routine_schema, routine_name, routine_type, created, last_altered
#, creation_time > TIMESTAMP_SUB(CURRENT_TIMESTAMP, INTERVAL 3 HOUR) AS SUCCEEDED
FROM `skytra-benchmark-rnd.region-eu.INFORMATION_SCHEMA.ROUTINES` r, day_int
WHERE created > TIMESTAMP_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY) OR last_altered > TIMESTAMP_SUB(CURRENT_TIMESTAMP, INTERVAL day_int.day_int DAY) 
UNION ALL
SELECT routine_catalog, routine_schema, routine_name, routine_type, created, last_altered
#, creation_time > TIMESTAMP_SUB(CURRENT_TIMESTAMP, INTERVAL 3 HOUR) AS SUCCEEDED
FROM `d-dat-digitalaircrafttransport.region-eu.INFORMATION_SCHEMA.ROUTINES` r, day_int
WHERE created > TIMESTAMP_SUB(CURRENT_TIMESTAMP, INTERVAL 1 DAY) OR last_altered > TIMESTAMP_SUB(CURRENT_TIMESTAMP, INTERVAL day_int.day_int DAY) 
UNION ALL*/
SELECT *
FROM `skytra-benchmark-rnd.region-eu.INFORMATION_SCHEMA.TABLES` t, day_int
WHERE 
( substr(table_name,1,1) in ('X','R') OR table_schema in ('generic','stat') )
AND creation_time > TIMESTAMP_SUB(CURRENT_TIMESTAMP, INTERVAL day_int.day_int DAY) 





REM ****************************************************************************************


REM REMOVE DATASET CAREFUL!!!!! Even sa no permissions so far*******************************
REM bq rm -r -f -d skytra-benchmark-prod:test_bq_trfr

REM bq rm -t -f skytra-benchmark-prod:generic.EURUSD

REM bq rm -t -f skytra-benchmark-prod:index.X7_in180_v4_2018_2019
REM bq rm -t -f skytra-benchmark-prod:index.X7_in229_v4_2018_2019
REM bq rm -t -f skytra-benchmark-prod:index.X7_in660_v4_2018_2019


REM bq rm -t -f skytra-benchmark-prod:test_bq_trfr.af_check_I2
REM bq rm -t -f skytra-benchmark-prod:test_bq_trfr.af_check_X1
REM bq rm -t -f skytra-benchmark-prod:test_bq_trfr.af_check_X2
REM bq rm -t -f skytra-benchmark-prod:test_bq_trfr.af_check_X5b

REM bq rm -t -f skytra-benchmark-prod:log.debug_any
REM bq rm -t -f skytra-benchmark-prod:log.export
REM bq rm -t -f skytra-benchmark-prod:log.pipeline




REM when testing airflow, set dt to yesterday because by default that is what airflow processes
SET dt=20200826

REM PARTITION COPY ONLY
REM ****************************************************************************************
SET dt=20200826
bq cp -a -n %s%:kiwi.X5b$%dt% %d%:kiwi.X5b

#LegacySQL
select * from [skytra-benchmark-prod.kiwi.X5b$__PARTITIONS_SUMMARY__] where partition_id <> '__NULL__'



REM ****************************************************************************************
REM TO DO - EXTERNAL TABLES
REM ****************************************************************************************


airlines_ticketing
chinese_airlines
	ext_file_source_log
od_cabin_class_mapping
skytra_index_regions
Ticketing_to_Operating_Carrier



#iata
bkt_src="gs://ext-iata-excl-data"
bkt_dst="gs://ext-iata-excl-dev-data"
pfx_src="/2020/loaded_to_bq/"
pfx_dst="/2020/unzipped/"
wild="FinalOutput_2020-01-01*.csv"
gsutil -m cp -R $bkt_src$pfx_src$wild $bkt_dst$pfx_dst

bkt_src="gs://ext-iata-excl-stat"
bkt_dst="gs://ext-iata-excl-dev-stat"
wild="/*"
gsutil -m cp -R $bkt_src$wild $bkt_dst

#kiwi
bkt_src="gs://ext-kiwi-excl-data"
bkt_dst="gs://ext-kiwi-excl-dev-data"
pfx_src="/data/y=2020/m=04/d=01/"
pfx_dst="/data/y=2020/m=04/d=01/"
wild="*"
#Unable to delete 100 objects because they haven't reached their retention expiration dates yet. Expires 24 hrs after creation
#gsutil -m rm $bkt_dst$pfx_dst$wild
#-R RECURSIVE
gsutil -m cp -R $bkt_src$pfx_src$wild $bkt_dst$pfx_dst

bkt_src="gs://ext-kiwi-excl-stat"
bkt_dst="gs://ext-kiwi-excl-dev-stat"
pfx_src="/stats/y=2020/m=01/d=01/"
pfx_dst="/stats/y=2020/m=01/d=01/"
wild="*"
gsutil -m cp -R $bkt_src$pfx_src$wild $bkt_dst$pfx_dst

#fxrates
SET bkt_src=gs://fxrates
SET bkt_dst=gs://fxrates-dev
wild="/*"
gsutil -m cp -R %bkt_src%%wild% %bkt_dst%

#spot-windows
bkt_src="gs://spot_windows"
bkt_dst="gs://spot-windows-dev"
wild="/*"
gsutil -m cp -R $bkt_src$wild $bkt_dst

EUR

#generic
#git checkout feature/IN-917-build-source-code-for-all-old-non

loc1="EU"
loc2="europe-west2"
prj1="d-dat-digitalaircrafttransport"
prj2="skytra-benchmark-devandtest"
gcs1="gs://d-dat-data-eng/bq-extract/"
gcs2="gs://d-dat-data-eng-dev/bq-extract/"
ext="CSV"

#tbl="generic.api_username"
#tbl="generic.skytra_distance_table"
tbl="stat.metric_dim"
fle=$tbl.$ext
json=$tbl.json
bq show --schema --format=prettyjson $tbl > $json

bq --location=$loc1 extract --destination_format $ext $tbl $gcs1$fle
gsutil cp $gcs1$fle $gcs2

bq show --schema --format=prettyjson $tbl > $json
git stage $json
git commit $json -m "adding $json"
echo "bq load --source_format=$ext --skip_leading_rows=1 $tbl $gcs2$fle $json"

# run echo'ed string in skytra-benchmark-devandtest window



gcs1="gs://d-dat-data-eng/bq-extract/"
gcs2="gs://d-dat-data-eng-dev/bq-extract"

gsutil cp $gcs1* $gcs2

bq load --source_format=CSV --skip_leading_rows=1 iata.I3 gs://d-dat-data-eng-dev/bq-extract/I3_20200401.csv




REM ****************************************************************************************
REM bq/r (routines)
REM ****************************************************************************************

REM https://www.varonis.com/blog/powershell-foreach/


git checkout master


$files = Get-ChildItem .\*.sql | Where{$_.BaseName -notlike '*TEMPLATE*' -and $_.BaseName -notlike '*index_sp*' -and $_.BaseName -notlike '*export*' -and $_.BaseName -notlike '*stat_sp*'}

foreach ($file in $files) {
	Get-Content $file.FullName | bq query --project_id=skytra-benchmark-prod --use_legacy_sql=false 
}

REM bq query --project_id=skytra-benchmark-prod --use_legacy_sql=false "drop procedure iata_sp.sp_process_I3"







