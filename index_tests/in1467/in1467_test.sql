/* resources

C:\git\DataEng\index_utils\bq\bq_copy_latest_partition_from_PROD.cmd

gcloud config set core/project skytra-benchmark-uat

IN-1467 
IN-1467 correct X3_daily call in DAG


utilises iata_sp.sp_process_X3_daily (named bq/r/sp/iata_sp.sp_process_X3.sql) from IN-1333

*/

SET bktPfx=gs://ext-kiwi-excl-
SET ym=y=2020/m=07
SET bktMS=%bktPfx%stat/stats/%ym%
SET bktMSU=%bktPfx%uat-stat/stats/%ym%
SET bktMD=%bktPfx%data/data/%ym%
SET bktMDU=%bktPfx%uat-data/data/%ym%

SET d=d=11
echo gsutil -m cp -r %bktMS%/%d% %bktMSU%/%d%
echo gsutil -m cp -r %bktMD%/%d% %bktMDU%/%d%


-- DEPLOYMENTS
----------------------------------------
----------------------------------------


	iata_sp.sp_process_X3_daily


-- TABLES COPIED
----------------------------------------

	SET src_prj=d-dat-digitalaircrafttransport
	SET dst_prj=skytra-benchmark-uat

	SET ds_tb=iata.X1
	SET dt=20200701
	bq rm -t -f %dst_prj%:%ds_tb%$%dt%
	bq cp -a -n %src_prj%:%ds_tb%$%dt% %dst_prj%:%ds_tb%

	SET ds_tb=stat.metric_dim
	bq cp -a -n %src_prj%:%ds_tb% %dst_prj%:%ds_tb%



	-- INTERNAL GENERIC
	SET ds_tb=generic.api_username
	bq cp -a -n %src_prj%:%ds_tb% %dst_prj%:%ds_tb%
	
	SET ds_tb=generic.iata_rrpk_filter_model
	bq cp -a -n %src_prj%:%ds_tb% %dst_prj%:%ds_tb%
	
	SET ds_tb=generic.kiwi_rrpk_filter_model
	bq cp -a -n %src_prj%:%ds_tb% %dst_prj%:%ds_tb%
	
	SET ds_tb=generic.long_skytra_distance_table
	bq cp -a -n %src_prj%:%ds_tb% %dst_prj%:%ds_tb%

	SET ds_tb=generic.rrpk_filter_model
	bq cp -a -n %src_prj%:%ds_tb% %dst_prj%:%ds_tb%
	
	SET ds_tb=generic.split_layout
	bq cp -a -n %src_prj%:%ds_tb% %dst_prj%:%ds_tb%

	SET ds_tb=generic.skytra_distance_table
	bq cp -a -n %src_prj%:%ds_tb% %dst_prj%:%ds_tb%
	
	
	
-- TABLES FROM DEFN
----------------------------------------
	cd \
	cd git\index2\bq\t


	bq mk --table --time_partitioning_field dt_of_issue --require_partition_filter --clustering_fields ticket_id --schema ./iata.I1.json iata.I1
	bq mk --table --time_partitioning_field dt_of_issue --require_partition_filter --clustering_fields ticket_id --schema ./iata.I2.json iata.I2
	bq mk --table --time_partitioning_field dt_of_issue --require_partition_filter --clustering_fields ticket_id --schema ./iata.I3.json iata.I3
	bq mk --table --time_partitioning_field dt_of_issue --require_partition_filter --clustering_fields ticket_id --schema ./iata.X3.json iata.X3_daily


	bq mk --table --time_partitioning_field search_date --require_partition_filter --time_partitioning_expiration 950400 --schema ./kiwi.X4.json kiwi.X4
	bq mk --table --time_partitioning_field search_date --require_partition_filter --time_partitioning_expiration 950400 --schema ./kiwi.X5a.json kiwi.X5a
	bq mk --table --time_partitioning_field search_date --require_partition_filter --time_partitioning_expiration 4320000 --schema ./kiwi.X5b.json kiwi.X5b


	bq mk --table --schema ./stat.metric.json --time_partitioning_field=ts --clustering_fields=pl_id,ds,tb,metric_tx_date --description "Product Team Data Quality and Compliance metrics on provided and pipeline data that can be viewed by Compliance). Data Quality and Compliance metrics can be split by metric_type column" stat.metric

	bq mk --table --schema ./stat.X1_discarded.json stat.X1_discarded
	bq mk --table --schema ./stat.X3_discarded.json stat.X3_discarded
	

	-- EXTERNAL
	bq mk --external_table_definition=./stat.kiwi_stats_defn.json --schema ./stat.kiwi_stats_schema.json stat.kiwi_stats
	bq mk --external_table_definition=./kiwi.ext_data_defn.json kiwi.ext_data
	
	gsutil cp gs://ext-iata-excl-stat/stat/y=2020/m=07/*.csv gs://ext-iata-excl-dev-stat/stat/y=2020/m=07/
	bq mk --external_table_definition=./stat.iata_stats_defn.json stat.iata_stats
	
	gsutil cp gs://ext-iata-excl-data/data/y=2020/m=07/20200701*.csv.gz gs://ext-iata-excl-uat-data/data/y=2020/m=07/
	bq mk --external_table_definition=./iata.ext_data_gz_defn.json --schema ./iata.X1.json iata.ext_data_gz



	-- EXTERNAL GENERIC
	gsutil cp -r gs://fxrates/to gs://fxrates-uat/to
	bq mk --external_table_definition=./generic.ext_EURUSD_defn.json --schema ./ext_EURUSD_schema.json generic.ext_EURUSD
	bq mk --external_table_definition=./generic.ext_file_source_log_defn.json generic.ext_file_source
	
	SET bkt=regression_parameters
	gsutil mb -b on -c standard -l EU gs://%bkt%-uat
	gsutil cp gs://%bkt%/index_lin_reg_params.* gs://%bkt%-uat/
	bq mk --external_table_definition=./generic.index_lin_reg_params_ext_defn.json --schema ./generic.index_lin_reg_params_ext_schema.json generic.index_lin_reg_params_ext

	SET bkt=spot_windows
	gsutil mb -b on -c standard -l EU gs://%bkt%-uat
	gsutil cp gs://%bkt%/spot_window_regions_ext.* gs://%bkt%-uat/
	bq mk --external_table_definition=./generic.spot_window_regions_ext_defn.json --schema ./generic.spot_window_regions_ext_schema.json generic.spot_window_regions_ext


-- AIRFLOW

	SET locDags=C:\git\index2\af\dags\
	SET bktDags=gs://europe-west2-benchmark-devt-6ca0db0f-bucket/dags
	gsutil cp %locDags%dag_iata_daily.py %bktDags%

	gsutil cp %locDags%dag_kiwi_daily_v2.py %bktDags%



	airflow dags backfill -s START_DATE -e END_DATE dag_id
	via GUI (Browse-DAG Runs) Create >> dag_iata_daily  2020-07-01 00:00:00  ba__2020-07-01 00:00:00
		1 dag run and 0 task instances were set to 'running'
		Record was successfully created.


-- RegrTests

-- IATA
C:\Users\PaulDesmond\OneDrive - SKYTRA LIMITED\UATvPRODregrTests\I3_20200713.xlsx

SELECT file_date_int, count(*) 
FROM `skytra-benchmark-uat.iata.X1` 
where file_date_int between 20200621 and 20200699
group by 1
order by 1


SELECT FILE_SOURCE, count(*), sum( nb_legs ) 
FROM `skytra-benchmark-uat.iata.X3_daily` 
WHERE dt_of_issue >= "2000-07-10" 
group by rollup (FILE_SOURCE) 
order by 1


-- I3
SELECT FILE_SOURCE, count(*), sum( n_pkg ) 
FROM `skytra-benchmark-uat.iata.I3` 
WHERE dt_of_issue >= "1970-01-01" 
and FILE_SOURCE between "IATA_daily_api_20200629" and "IATA_daily_api_20200705" 
group by rollup (FILE_SOURCE) 
order by 1


SELECT FILE_SOURCE, count(*), sum( n_pkg ) 
FROM `d-dat-digitalaircrafttransport.iata.I3` 
WHERE dt_of_issue >= "1970-01-01" 
and FILE_SOURCE like "%2020-06-29%" 
group by rollup (FILE_SOURCE) 
order by 1

-- KIWI
C:\Users\PaulDesmond\OneDrive - SKYTRA LIMITED\UATvPRODregrTests\X5b_20200713.xlsx



