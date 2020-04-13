#d-dat-digitalaircrafttransport: skytra-benchmark-devandtest: skytra-benchmark-prod:

#2020-04-01

#data_eng to scratch_PaD
bq cp data_eng.in127_X2 skytra-benchmark-devandtest:scratch_PaD.in127_X2
bq cp data_eng.in127_X4 skytra-benchmark-devandtest:scratch_PaD.in127_X4
bq cp data_eng.in820_X1 skytra-benchmark-devandtest:scratch_PaD.in820_X1
bq cp data_eng.metric skytra-benchmark-devandtest:scratch_PaD.metric
bq cp data_eng.nul_test skytra-benchmark-devandtest:scratch_PaD.null_test
bq cp data_eng.proc_load skytra-benchmark-devandtest:scratch_PaD.proc_load
bq cp data_eng.sabre_sample_data skytra-benchmark-devandtest:scratch_PaD.sabre_sample_data

#manually move 2 data_eng procs 

gcloud config set core/project skytra-benchmark-devandtest

#datasets
bq --location=europe-west2 mk --dataset --description "index_sp dataset for sp's only" ${GC_PROJECT_ID}:index_sp
bq --location=europe-west2 mk --dataset --description "log_sp dataset for sp's only" ${GC_PROJECT_ID}:log_sp
bq --location=europe-west2 mk --dataset --description "kiwi_sp dataset for sp's only" ${GC_PROJECT_ID}:kiwi_sp
bq --location=europe-west2 mk --dataset --description "stat dataset holds ext stat definitions and data quality and compliance metric" ${GC_PROJECT_ID}:stat
bq --location=europe-west2 mk --dataset --description "stat_sp dataset for sp's only" ${GC_PROJECT_ID}:stat_sp
bq --location=europe-west2 mk --dataset --description "kiwi_export dataset" ${GC_PROJECT_ID}:kiwi_export
bq --location=europe-west2 mk --dataset --description "log dataset" ${GC_PROJECT_ID}:log
bq --location=europe-west2 mk --dataset --description "matching_sp dataset for sp's only" ${GC_PROJECT_ID}:matching_sp
bq --location=europe-west2 mk --dataset --description "kiwi_export_sp dataset for sp's only" ${GC_PROJECT_ID}:kiwi_export_sp
bq --location=europe-west2 mk --dataset --description "iata_sp dataset for sp's only" ${GC_PROJECT_ID}:iata_sp


gcloud config set core/project d-dat-digitalaircrafttransport

#misc
bq cp DataOps.ops_schema_history skytra-benchmark-devandtest:scratch_PaD.ops_schema_history


gcloud config set core/project skytra-benchmark-devandtest

#kiwi cannot copy from EU region to europe-west2 used in devandtest so go via scratch_PaD
bq cp skytra-benchmark-prod:kiwi.X4 skytra-benchmark-devandtest:scratch_PaD.X4
bq cp skytra-benchmark-prod:kiwi.X5a skytra-benchmark-devandtest:scratch_PaD.X5a
bq cp 'skytra-benchmark-prod:kiwi.X5b$20200101' skytra-benchmark-devandtest:scratch_PaD.X5b


bq mk --table --time_partitioning_field search_date --require_partition_filter --time_partitioning_expiration 17280000 --schema ./kiwi.X4.json kiwi.X4
bq mk --table --time_partitioning_field search_date --require_partition_filter --time_partitioning_expiration 17280000 --schema ./kiwi.X5a.json kiwi.X5a
bq mk --table --time_partitioning_field search_date --require_partition_filter --time_partitioning_expiration 30240000 --schema ./kiwi.X5b.json kiwi.X5b

#tried everything simply not possible without following so leave in scratch_PaD until bring up from scratch from GCS
#  https://medium.com/weareservian/how-to-transfer-bigquery-tables-between-locations-with-cloud-dataflow-9582acc6ae1d
#bq query --allow_large_results --append_table --use_legacy_sql=false --destination_table kiwi.X5b "select * FROM scratch_PaD.X5b where search_date >= '2020-01-01'"

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
bkt_src="gs://fxrates"
bkt_dst="gs://fxrates-dev"
wild="/*"
gsutil -m cp -R $bkt_src$wild $bkt_dst

#fxrates
bkt_src="gs://spot_windows"
bkt_dst="gs://spot-windows-dev"
wild="/*"
gsutil -m cp -R $bkt_src$wild $bkt_dst



WHERE table_name not in('') UNION ALL
SELECT * FROM index.INFORMATION_SCHEMA.COLUMNS      WHERE table_name not in('') UNION ALL
SELECT * FROM kiwi_PROD.INFORMATION_SCHEMA.COLUMNS  WHERE table_name not in('') UNION ALL
SELECT * FROM kiwi_export.INFORMATION_SCHEMA.COLUMNS WHERE table_name not in('') UNION ALL
SELECT * FROM log.INFORMATION_SCHEMA.COLUMNS        WHERE table_name not in('') UNION ALL
SELECT * FROM matching.INFORMATION_SCHEMA.COLUMNS   WHERE table_name not in('X6_modified','X6a')

)
SELECT
replace(table_schema, '_PROD', '') as table_schema, table_name

SELECT * FROM `d-dat-digitalaircrafttransport.generic.__TABLES__` 
  WHERE table_name in('api_username','holiday_calendar','iata_rrpk_filter_model','kiwi_rrpk_filter_model',
  'long_skytra_distance_table','skytra_distance_table','split_layout','spot_window_regions_ext') 
  UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.iata.__TABLES__` WHERE table_name not in('') UNION ALL

SELECT * FROM `d-dat-digitalaircrafttransport.index.__TABLES__` UNION ALL


SELECT * FROM `d-dat-digitalaircrafttransport.kiwi_export.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.log.__TABLES__` UNION ALL
SELECT * FROM `d-dat-digitalaircrafttransport.matching.__TABLES__` UNION ALL


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
tbl="generic.skytra_distance_table"
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



#source control
iata_rrpk_filter_model
kiwi_rrpk_filter_model
long_skytra_distance_table
skytra_distance_table

#source control and migrate
[done] api_username 
[done] split_layout
[done] spot_window_regions_ext 
  generic.spot_window_regions_ext_schema.json
  bq show --schema --format=prettyjson generic.spot_window_regions_ext > generic.spot_window_regions_ext_schema.json



iata.int_X1_file_analysis

index.X7

matching.X6 




gcs1="gs://d-dat-data-eng/bq-extract/"
gcs2="gs://d-dat-data-eng-dev/bq-extract"

gsutil cp $gcs1* $gcs2

bq load --source_format=CSV --skip_leading_rows=1 iata.I3 gs://d-dat-data-eng-dev/bq-extract/I3_20200401.csv



