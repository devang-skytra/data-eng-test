
Best Index 

Archie PD-326  (from IN-1092) https://bitbucket.org/indexproduction_SK/indexproduction/pull-requests/430


REM SCHEMA SETUP
REM ****************************************************************************************

	gcloud config set core/project skytra-benchmark-devandtest

	git checkout feature/PD-326-Best-Index


	REM ************************  BECAUSE BACKFILL, NO --time_partitioning_expiration

	cd c:\git\index2\bq\t\
	bq mk --table --time_partitioning_field search_date --require_partition_filter --schema ./kiwi.X5a.json kiwi.X5a
	bq mk --table --time_partitioning_field search_date --require_partition_filter --schema ./kiwi.X5b.json kiwi.X5b
	
	REM bq rm -t -f generic.ext_EURUSD
	bq mk --external_table_definition=./generic.ext_EURUSD_defn.json --schema ./ext_EURUSD_schema.json generic.ext_EURUSD
	bq mk --external_table_definition=./generic.ext_file_source_log_defn.json generic.ext_file_source_log


	bq cp skytra-benchmark-rnd:generic.Ticketing_to_Operating_Carrier skytra-benchmark-devandtest:generic.Ticketing_to_Operating_Carrier

	

REM ****************************************************************************************




REM DAGS
REM ****************************************************************************************

	

git checkout IN-1754-v5-backfill-x2-parallel-run-comp

cd c:\git\index2\af\dags\
REM SET bkt_dag=gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags
SET bkt_dag=gs://europe-west2-benchmark-devt-6ca0db0f-bucket/dags

REM gsutil -m cp -r py %bkt_dag%/py
REM gsutil -m cp -r sq %bkt_dag%/sq

SET dag=dag_kiwi_daily_parallel.py
gsutil cp %dag% %bkt_dag%/%dag%

REM ****************************************************************************************



REM archive
REM ****************************************************************************************



REM  GCS sample data move/load
REM **************************************************



gsutil -m cp -r gs://ext-kiwi-excl-stat/stats/y=2020/m=08 gs://ext-kiwi-excl-dev-stat/stats/y=2020/m=08
REM gsutil -m rm gs://ext-kiwi-excl-dev-data/data/y=2020/m=08/**
gsutil -m cp -r gs://ext-kiwi-excl-data/data/y=2020/m=08/d=27 gs://ext-kiwi-excl-dev-data/data/y=2020/m=08/d=27


y=2020/m=02/d=02 y=2020/m=08/d=26

bq load --project_id=skytra-benchmark-rnd --location=EU --replace --source_format=PARQUET kiwi.X2 "gs://ext-kiwi-excl-data/data/y=2020/m=02/d=02/*.gz.parquet,gs://ext-kiwi-excl-data/data/y=2020/m=08/d=26/*.gz.parquet"

UAT

gs://ext-kiwi-excl-uat-data/data/y=2020/m=03/d=23/hr=21/part-00000-e1a29e0a-b4b4-4d76-9260-ba56427489fb-c000.gz.parquet
gs://ext-kiwi-excl-uat-data/data/y=2020/m=07/d=01/hr=00/part-00000-aa73f8d7-e62d-4165-9f7f-7f10a98f5d0d-c000.gz.parquet



REM  X2 partitioning idea - dropped for kiwi.X2_{{ ds_nodash }} approach
REM *************************************************
simply add search_date to X2.json and use X2.sh to create

then
	INSERT INTO .X2
	SELECT 
	EXTRACT(date FROM TIMESTAMP_SECONDS(timestamp)) AS search_date,
	* EXCEPT(m,d,hr)
	FROM kiwi.ext_data 
	WHERE 
	_FILE_NAME like '%data/y=2020/m=03/d=23/hr=21/part-00000-e1a29e0a-b4b4-4d76-9260-ba56427489fb-c000.gz.parquet'
	OR
	hr = '21'
	
key ***
	can we get kiwi.ext_data working in Migrated (ISSUE)
	
cd C:\git\index2\bq\t\
bq mk --project_id=d-dat-digitalaircrafttransport --external_table_definition=./kiwi.ext_data_defn.json kiwi.ext_data_UAT

