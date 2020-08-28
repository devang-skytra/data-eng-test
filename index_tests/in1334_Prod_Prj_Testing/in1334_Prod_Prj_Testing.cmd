

REM ******** DONT FORGET BASH DEVOPS OPTIONS  C:\git\DataEng\index_utils\bq\DataOps
REM ****************************************************************************************


gcloud config get-value core/project
gcloud config set core/project skytra-benchmark-prod







SET ds=iata
REM when testing airflow, set dt to yesterday because by default that is what airflow processes
SET dt=20200826
SET src_prj=d-dat-digitalaircrafttransport
SET dst_prj=skytra-benchmark-uat

SET dt=20200711
bq rm -t -f %dst_prj%:%ds_tb%$%dt%
bq cp -a -n %src_prj%:%ds_tb%$%dt% %dst_prj%:%ds_tb%




SET s=d-dat-digitalaircrafttransport
SET d=skytra-benchmark-prod

bq cp -a -n %s%:kiwi.X5b$20200727 %d%:kiwi.X5b
bq cp -a -n %s%:kiwi.X5b$20200728 %d%:kiwi.X5b

bq cp -f %s%:iata.I2 %d%:iata.I2

bq cp -f %s%:iata.I3 %d%:iata.I3

bq cp -f %s%:matching.X6$20200727 %d%:matching.X6


REM 	https://cloud.google.com/bigquery/docs/copying-datasets


bq mk --transfer_config --project_id=skytra-benchmark-prod --data_source=cross_region_copy --target_dataset=airflow --display_name='tfr_ds_airflow_Migr_to_Prod' --params='{"source_dataset_id":"airflow","source_project_id":"d-dat-digitalaircrafttransport","overwrite_destination_table":"true"}'




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
  
  
