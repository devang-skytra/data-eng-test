
# C:\git\DataEng\index_tests\in1752_1092 Best Index\PD-326 Best Index notes.ps1

$prj='skytra-benchmark-prod'

gcloud config get-value core/project
gcloud config set core/project $prj
gcloud auth login cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com

$src_prj='d-dat-digitalaircrafttransport'
$dst_prj='skytra-benchmark-prod'

# git checkout 
# cd c:\git\index2\bq\t\


# 2020 09 21
#---------------------------------------
#---------------------------------------

kiwi
#--------

cd c:\git\index2
git checkout feature/IN-1092-create-a-waterfall-pricing-mecha
git pull
cd c:\git\index2\bq\t\
 # BECAUSE BACKFILL, NO --time_partitioning_EXPIRATION !!!!!!!!!!!!!
$tbls='kiwi.X5a','kiwi.X5b'
foreach ($t in $tbls) { 
	"bq rm --project_id=$prj -t -f $t" | Invoke-Expression
	"bq mk --project_id=$prj --table --time_partitioning_field search_date --require_partition_filter --schema .`\$t.json $t" | Invoke-Expression
} 

### VITAL POINT - temporarily doing cross-project stats check using 'from stat.kiwi_stats_Migr' ie '_Migr' suffix
cd c:\git\index2\bq\t
bq mk --external_table_definition=./stat.kiwi_stats_defn.json --schema ./stat.kiwi_stats_schema.json stat.kiwi_stats_Migr

$ds='generic'
$tb='skytra_airports'
bq cp -a -n "$src_prj`:$ds.$tb" $dst_prj`:$ds.$tb

$ds='generic'
$tb='rrpk_filter_model'
bq cp -a -n "$src_prj`:$ds.$tb" $dst_prj`:$ds.$tb


'@
$ds='kiwi'

$tb='X5b'
bq rm -t -f $dst_prj`:$ds.$tb
$ptns=20200826
foreach ($p in $ptns) { bq cp -a -n "$src_prj`:$ds.$tb`$$p" $dst_prj`:$ds.$tb }
foreach ($p in $ptns) { "bq cp -a -n $src_prj`:$ds.$tb`$$p $dst_prj`:$ds.$tb" | Invoke-Expression }

$tb='X5a'
bq rm -t -f $dst_prj`:$ds.$tb
foreach ($p in $ptns) { "bq cp -a -n $src_prj`:$ds.$tb`$$p $dst_prj`:$ds.$tb" | Invoke-Expression }
@'

# af
# ****
cd c:\git\index2
git checkout feature/IN-1092-create-a-waterfall-pricing-mecha
cd c:\git\index2\af\dags

$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'
$sq='sq/X5*.*'
# Manually fix FROM kiwi.X2_{{ ds_nodash[4:] }},
gsutil -m cp -r $sq $bkt_dag/sq


cd c:\git\index2
git checkout IN-1754-v5-backfill-x2-parallel-run-comp
cd c:\git\index2\af\dags

$dag='dag_kiwi_daily_parallel_v5_0_ProdReadLocalGCSTest.py'
gsutil cp $dag $bkt_dag


$sq='sq/airflow_tasks_log.*'
gsutil -m cp -r $sq $bkt_dag/sq

BA csv
#--------

gsutil mb -b on -c standard -l europe-west1 gs://trillo-stage-prod

$ds='generic'
$tb='bank_hols'
bq cp -a -n "$src_prj`:$ds.$tb" $dst_prj`:$ds.$tb


$ds='index'
$tb='X7'
bq rm -t -f $dst_prj`:$ds.$tb
bq cp -a -n "$src_prj`:$ds.$tb" $dst_prj`:$ds.$tb


git checkout feature/IN-1200-create-bq-extract-customised-csv

cd c:\git\index2\bq\t
gsutil mb -b on -c standard -l europe-west1 gs://bq-generic-prod
$pfx='/prod_dims/generic.product_ba_label_dim.csv'
gsutil cp gs://d-dat-data-eng$pfx gs://bq-generic-prod$pfx
bq mk --external_table_definition=./generic.prod_ba_label_dim_ext_defn.json generic.prod_ba_label_dim_ext


cd c:\git\index2\af\dags
$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'
$sq='sq/BA_*.*'
gsutil -m cp -r $sq $bkt_dag/sq

$py='py/op_gen.py'
gsutil -m cp -r $py $bkt_dag/py
	
$dag='dag_BA_Trillo*.*'
gsutil cp $dag $bkt_dag

	
	




# 2020 09 15
#---------------------------------------
#---------------------------------------


# dag_kiwi_daily
#----------------------

# gsutil fxrates - see #fxrates in Best Index.ps1

# normally would use 'for each ($e in $exts)' below but these ext_file_source_log_defn does not use schema
cd c:\git\index2\bq\t\
bq mk --external_table_definition=./generic.ext_EURUSD_defn.json --schema ./ext_EURUSD_schema.json generic.ext_EURUSD
bq mk --external_table_definition=./generic.ext_file_source_log_defn.json generic.ext_file_source_log

# used 'BQ EXT TABLES' below to copy across kiwi stats and data for Aug 27th

# used 'DAGS - BACKFILL' below to init dag run







# BIG QUERY
# ****************************************************************************************
# remove syntax (needed before copy if has been schema change  bq rm -t -f %dst_prj%:%ds_tb%$%dt%

$ds='kiwi'
$tb='X5b'
# $ptns=20200202,20200826 # Paulo's choice for X2 in RnD, 20200711 my choice because ?
$ptns=20200826,20200827
foreach ($p in $ptns) { "bq cp -a -n $src_prj`:$ds.$tb`$$p $dst_prj`:$ds.$tb" | Invoke-Expression }


# These copies done Aug 27, 2020  PM
bq cp -f %s%:iata.I2 %d%:iata.I2
bq cp -f %s%:iata.I3 %d%:iata.I3
bq cp -f %s%:matching.X6$20200727 %d%:matching.X6


# BQ EXT TABLES
# ********************************************


$bkt_src='gs://ext-kiwi-excl-stat/stats'
$bkt_dst='gs://ext-kiwi-excl-prod-stat/stats'
$pfx='/y=2020/m=08/d=27/'
$wild='*'
gsutil -m cp -R $bkt_src$pfx$wild $bkt_dst$pfx

$bkt_src='gs://ext-kiwi-excl-data/data'
$bkt_dst='gs://ext-kiwi-excl-prod-data/data'
gsutil -m cp -R $bkt_src$pfx$wild $bkt_dst$pfx


Write-Output "gsutil -m cp -R $bkt_src$pfx_src$wild $bkt_dst$pfx_dst"
# $pfx_dst='/stats/y=2020/m=01/d=01/'
gsutil -m cp -R gs://ext-kiwi-excl-stat/stats/y=2020/m=01/d=01/* gs://ext-kiwi-excl-prod-stat/stats/y=2020/m=01/d=01/

c:\git\index2\bq\t\

# edit sourceUris bucket name, then...







bq cp skytra-benchmark-rnd:generic.Ticketing_to_Operating_Carrier skytra-benchmark-devandtest:generic.Ticketing_to_Operating_Carrier



$exts='stat.kiwi_stats'
foreach ($e in $exts) { "bq mk --external_table_definition=.`\$e`_defn.json --schema .`\$e`_schema.json $e" | Invoke-Expression }


foreach ($e in $exts) { 
	Write-Output $e
}





# BQ CODE DEPLOYMENT
# ********************************************

$files = Get-ChildItem .\*.sql | Where{$_.BaseName -notlike '*TEMPLATE*' -and $_.BaseName -notlike '*index_sp*' -and $_.BaseName -notlike '*export*'}

foreach ($file in $files) {
	Get-Content $file.FullName | bq query --project_id=skytra-benchmark-prod --use_legacy_sql=false
}





# 	https://cloud.google.com/bigquery/docs/copying-datasets
# bq mk --transfer_config --project_id=skytra-benchmark-prod --data_source=cross_region_copy --target_dataset=airflow --display_name='tfr_ds_airflow_Migr_to_Prod' --params='{"source_dataset_id":"airflow","source_project_id":"d-dat-digitalaircrafttransport","overwrite_destination_table":"true"}'




# DAGS
# ****************************************************************************************

	
cd c:\git\index2
git checkout feature/IN-1674-bi-airtex-reports-generator-for-
cd af\dags

# SET bkt_dag=gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags
SET bkt_dag=gs://europe-west2-benchmark-devt-6ca0db0f-bucket/dags

# gsutil -m cp -r py %bkt_dag%/py

# SET sq=sq
SET sq=sq/X5*.*
gsutil -m cp -r %sq% %bkt_dag%/sq



git checkout IN-1754-v5-backfill-x2-parallel-run-comp

SET dag=dag_kiwi_daily.py
gsutil cp %dag% %bkt_dag%

# BACKFILL
$inst='benchmark-prod-composer'
$dag_id='dag_kiwi_daily'
$bf_start='2020-08-27'
$bf_end='2020-08-28'

gcloud composer environments run $inst --location europe-west2 backfill -- $dag_id --start_date $bf_start --end_date $bf_end


gcloud composer environments run benchmark-prod-composer --location europe-west2 backfill -- dag_kiwi_daily --start_date 2020-08-27 --end_date 2020-08-28

# --reset_dagruns --rerun_failed_tasks


# ****************************************************************************************



SOURCE CHECKS
------------------------------------------------------------------------------------------------------


-- select *  FROM log.proc_load order by 1 desc


--bq query --location=EU --use_legacy_sql=false "CALL matching_sp.sp_process_X6('IATA_daily_api_20200729', 2);"

-- select * EXCEPT(pl_id) FROM `iata.I3` where FILE_SOURCE = 'IATA_daily_api_20200729' AND dt_of_issue = '2020-07-28'        
        
-- select * FROM iata.I3 where dt_of_issue = '2020-07-28'

-- select * FROM matching.X6 where dt_of_issue = '2020-07-28'

-- select * FROM `kiwi.X5b` where search_date = '2020-07-28'
 

DEBUG SCRIPT I
------------------------------------------------------------------------------------------------------

  create table if not exists log.log_any (msg STRING, ts TIMESTAMP);

  
  DECLARE START_DATE DATE DEFAULT DATE'2020-07-25';
  DECLARE source_file STRING DEFAULT 'IATA_daily_api_20200729';
  DECLARE  max_days INT64 DEFAULT 2;
  DECLARE from_date DATE;
  DECLARE to_date DATE;
  DECLARE dt DATE;
  DECLARE days_chunk INT64 DEFAULT 1;
  DECLARE dset STRING DEFAULT 'matching';
  DECLARE dtbl STRING DEFAULT 'X6';

  SET to_date   = (
    SELECT MAX(dt_of_issue)
    FROM `iata.I2`
    WHERE FILE_SOURCE = source_file AND dt_of_issue > START_DATE
  );

  
  SET from_date = DATE_SUB(to_date, INTERVAL max_days -1 DAY);
  insert into log.log_any values( CONCAT('earliest result - ', from_date, ' TO ', to_date), CURRENT_TIMESTAMP );
  
  SET to_date   = (
    SELECT MAX(search_date)
    FROM `kiwi.X5b`
    WHERE search_date BETWEEN from_date AND to_date
  );
  
  SET from_date = (
    SELECT MIN(search_date)
    FROM `kiwi.X5b`
    WHERE search_date BETWEEN from_date AND to_date
  );
  insert into log.log_any values( CONCAT('recalc from result - ', from_date, ' TO ', to_date), CURRENT_TIMESTAMP );

  IF from_date >= CURRENT_DATE() THEN RAISE USING MESSAGE = 'ARCHIVING DATE HAS REACHED CURRENT_DATE';
  END IF;

  SET dt = from_date;

  WHILE dt <= to_date DO
    BEGIN
      insert into log.log_any values( CONCAT('current loop is ', dt), CURRENT_TIMESTAMP );
    END;
    SET dt = DATE_ADD(dt, INTERVAL 1 DAY); 
  END WHILE;


DEBUG SCRIPT II
------------------------------------------------------------------------------------------------------

--variables can have different scopes, so set WHILE scope variables here
  DECLARE bq_ts TIMESTAMP;
  DECLARE uid INT64;
  DECLARE jobInfo ARRAY< STRUCT<rc INT64, bp INT64, bb INT64> >;

  DECLARE source_file STRING DEFAULT 'IATA_daily_api_20200729';
  DECLARE max_days INT64 DEFAULT 2;
  DECLARE from_date DATE;
  DECLARE to_date DATE;
  DECLARE dt DATE;
  DECLARE days_chunk INT64 DEFAULT 1;
  DECLARE dset STRING DEFAULT 'matching';
  DECLARE dtbl STRING DEFAULT 'X6';

  SET to_date   = DATE'2020-07-28';
  SET from_date   = DATE'2020-07-28';
  

      
  SET bq_ts = CURRENT_TIMESTAMP();  --@@script.creation_time;
  CALL log_sp.sp_proc_load_start(bq_ts, dset, dtbl, dt, dt, uid);

  -- query: X6
  ------------------------------------------

  DELETE matching.X6
  WHERE FILE_SOURCE = source_file
  AND dt_of_issue = dt;

  CREATE OR REPLACE TEMP TABLE
  x5b AS (
    SELECT search_date, journey_map, REGEXP_REPLACE(journey_map,'\\([A-Z]?\\)','') AS classless_journey_map, price, classless_price, skytra_search
    FROM `kiwi.X5b`
    WHERE search_date = dt
  );


  CREATE OR REPLACE TEMP TABLE I3 AS (
    SELECT *
    FROM `iata.I3`
    WHERE FILE_SOURCE = source_file
    AND dt_of_issue = dt
  );


  CREATE OR REPLACE TEMP TABLE I2 AS (
    SELECT * EXCEPT(pl_id)
    FROM `iata.I2`
    WHERE FILE_SOURCE = source_file
    AND dt_of_issue = dt
  );


  CREATE OR REPLACE TEMP TABLE clf_ik as (
    -- find row (ticket_id, n_pkg) with smallest price
    SELECT * EXCEPT(prank)
    FROM (
      SELECT ticket_id, n_pkg,
        sumprice AS price, skytra_search,
        -- create price rank
        ROW_NUMBER() OVER (PARTITION BY ticket_id, n_pkg ORDER BY sumprice) AS prank
      FROM (
        SELECT
          ticket_id, ANY_VALUE(n_pkg) AS n_pkg,
          SUM(price) AS sumprice, MAX(skytra_search) AS skytra_search
      FROM (
        SELECT ticket_id, package_map, price,split ,n_pkg, skytra_search
        FROM I3 LEFT JOIN x5b AS K
        ON I3.package_map = K.journey_map
        AND I3.dt_of_issue = K.search_date
      ) AS clfp
      GROUP BY ticket_id, split
      HAVING COUNTIF(price IS NULL) = 0
      --insists that, for a given split method, we have a price for every package.
      )
    )
    WHERE prank = 1
  );


  CREATE OR REPLACE TEMP TABLE cll_ik AS (
    -- find row (ticket_id, n_pkg) with smallest price
    SELECT * EXCEPT(prank)
    FROM (
      SELECT ticket_id, n_pkg,
        sumprice AS price, skytra_search,
        -- create price rank
        ROW_NUMBER() OVER (PARTITION BY ticket_id, n_pkg ORDER BY sumprice) AS prank
      FROM (
        SELECT
          ticket_id, ANY_VALUE(n_pkg) AS n_pkg,
          SUM(classless_price) AS sumprice, MAX(skytra_search) AS skytra_search
        FROM (
          SELECT ticket_id, classless_package_map, classless_price, split, n_pkg, skytra_search
          FROM I3 LEFT JOIN (
            --skytra search already is an average for the journey map, we add the average for safety
            SELECT classless_journey_map,  ANY_VALUE(classless_price) AS classless_price, search_date, AVG(skytra_search) AS skytra_search
            FROM  x5b
            GROUP BY classless_journey_map,search_date
           ) AS K
          ON I3.classless_package_map = K.classless_journey_map
          AND I3.dt_of_issue = K.search_date
        ) AS clfp
        GROUP BY ticket_id, split
        HAVING COUNTIF(classless_price IS NULL) = 0
      )
    )
    WHERE prank = 1
  );


  CREATE OR REPLACE TEMP TABLE cl_ik AS (
    SELECT
      IFNULL(clf_ik.ticket_id, cll_ik.ticket_id) AS ticket_id,
      IFNULL(clf_ik.n_pkg, cll_ik.n_pkg) AS n_pkg,
      IFNULL(clf_ik.price, cll_ik.price) AS price,
      IF(clf_ik.price IS NOT NULL,'classfull','classless') AS key_type,
      IF(clf_ik.price IS NOT NULL,clf_ik.skytra_search,cll_ik.skytra_search) AS skytra_search
    FROM cll_ik
    FULL OUTER JOIN clf_ik
    ON cll_ik.ticket_id = clf_ik.ticket_id AND cll_ik.n_pkg = clf_ik.n_pkg
  );


  INSERT INTO matching.X6
  SELECT
  uid AS pl_id,
  I2.ticket_id, I2.region_pair, I2.dt_of_issue, I2.nb_legs, I2.leadtime,
  I2.first_flight_date_utc, I2.journey_map, I2.classless_journey_map,
  I2.sumP, I2.od_mile, I2.leg_prices, I2.leg_miles, I2.mkt_carrier_code_list,
  I2.operating_carrier_list, I2.mkt_carrier, I2.op_carrier,
  IFNULL(cl_ik.n_pkg,0) AS n_pkg, cl_ik.price, cl_ik.key_type,
  I2.distribution_channel, I2.source_code, I2.ticket_document_amount, I2.FILE_SOURCE, cl_ik.skytra_search
  FROM I2 LEFT JOIN cl_ik
  ON I2.ticket_id = cl_ik.ticket_id;
  
  
