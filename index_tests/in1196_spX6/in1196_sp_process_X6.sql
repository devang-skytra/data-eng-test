/*
  -- CALL matching_sp.sp_process_X6('FinalOutput_2020-04-06_w_2020-04-12_Global.csv',2);
  DECLARE source_file STRING DEFAULT 'FinalOutput_2020-04-06_w_2020-04-12_Global.csv';
  DECLARE max_days INT64 DEFAULT 2;
*/

CREATE OR REPLACE PROCEDURE `skytra-benchmark-devandtest.matching_sp.in1196_sp_process_X6`(IN source_file STRING, IN max_days INT64)
BEGIN

  DECLARE from_date DATE;
  DECLARE to_date DATE;
  DECLARE dt DATE;
  DECLARE days_chunk INT64 DEFAULT 1;
  DECLARE dset STRING DEFAULT 'matching';
  DECLARE dtbl STRING DEFAULT 'X6_in1196';

  SET to_date   = (
    SELECT MAX(dt_of_issue)
    FROM iata.I2
    WHERE FILE_SOURCE = source_file AND dt_of_issue > '1970-01-01'
  );
  insert into log.any values( CAST(to_date as STRING), CURRENT_TIMESTAMP );
  
  
  SET from_date = DATE_SUB(to_date, INTERVAL max_days -1 DAY);
  insert into log.any values( CAST(to_date as STRING), CURRENT_TIMESTAMP );
  
  SET to_date   = (
    SELECT MAX(search_date)
    FROM kiwi.X5b
    WHERE search_date BETWEEN from_date AND to_date
  );
  insert into log.any values( CAST(to_date as STRING), CURRENT_TIMESTAMP );
  
  SET from_date = (
    SELECT MIN(search_date)
    FROM kiwi.X5b
    WHERE search_date BETWEEN from_date AND to_date
  );
  insert into log.any values( CAST(to_date as STRING), CURRENT_TIMESTAMP );
  
  IF from_date >= CURRENT_DATE() THEN RAISE USING MESSAGE = 'ARCHIVING DATE HAS REACHED CURRENT_DATE';
  END IF;

  SET dt = from_date;

  WHILE dt <= to_date DO
  BEGIN

      --variables can have different scopes, so set WHILE scope variables here
      DECLARE bq_ts TIMESTAMP;
      DECLARE uid INT64;
      DECLARE jobInfo ARRAY< STRUCT<rc INT64, bp INT64, bb INT64> >;

      SET bq_ts = CURRENT_TIMESTAMP();  --@@script.creation_time;
      CALL log_sp.sp_proc_load_start(bq_ts, dset, dtbl, dt, dt, uid);
      insert into log.any values( CAST(uid as STRING), CURRENT_TIMESTAMP );
      -- query: X6
      ------------------------------------------

      DELETE matching.X6_in1196
      WHERE FILE_SOURCE = source_file
      AND dt_of_issue = dt;
      insert into log.any values( 'DELETE', CURRENT_TIMESTAMP );
      
      CREATE OR REPLACE TEMP TABLE
      x5b AS (
        SELECT search_date, journey_map, REGEXP_REPLACE(journey_map,'\\([A-Z]?\\)','') AS classless_journey_map, price, classless_price, skytra_search
        FROM kiwi.X5b
        WHERE search_date = dt
      );
      insert into log.any values( 'TEMP X5b', CURRENT_TIMESTAMP );

      CREATE OR REPLACE TEMP TABLE I3 AS (
        SELECT *
        FROM iata.I3
        WHERE FILE_SOURCE = source_file
        AND dt_of_issue = dt
      );
      insert into log.any values( 'TEMP I3', CURRENT_TIMESTAMP );

      CREATE OR REPLACE TEMP TABLE I2 AS (
        SELECT * EXCEPT(pl_id)
        FROM iata.I2
        WHERE FILE_SOURCE = source_file
        AND dt_of_issue = dt
      );
      insert into log.any values( 'TEMP I2', CURRENT_TIMESTAMP );

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


    INSERT INTO matching.X6_in1196
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


    SET jobInfo = ( SELECT [ STRUCT(@@row_count as rc, @@script.bytes_processed as bp, @@script.bytes_billed as bb) ] );
    CALL log_sp.sp_proc_load_end(dt, uid, jobInfo);

    EXCEPTION WHEN ERROR THEN
      RETURN;

    END;
    SET dt = DATE_ADD(dt, INTERVAL 1 DAY); -- INTERVAL days_chunk DAY
  END WHILE;

  -- Add to X6 old ticket submitted by IATA on this file
  SET to_date = DATE_SUB(from_date, INTERVAL 1 DAY);
  SET from_date   = (
    SELECT MIN(dt_of_issue)
    FROM iata.I2
    WHERE FILE_SOURCE = source_file AND dt_of_issue > '1970-01-01'
  );
  SET dt = from_date;

  --variables can have different scopes, so set WHILE scope variables here
  IF from_date <= to_date THEN
    BEGIN

    DECLARE bq_ts TIMESTAMP;
    DECLARE uid INT64;
    DECLARE jobInfo ARRAY< STRUCT<rc INT64, bp INT64, bb INT64> >;

    SET bq_ts = CURRENT_TIMESTAMP();  --@@script.creation_time;
    CALL log_sp.sp_proc_load_start(bq_ts, dset, dtbl,  from_date, to_date, uid);

    INSERT INTO matching.X6_in1196
    SELECT
    uid AS pl_id,
    i2_fs.ticket_id, i2_fs.region_pair, i2_fs.dt_of_issue, i2_fs.nb_legs, i2_fs.leadtime,
    i2_fs.first_flight_date_utc, i2_fs.journey_map, i2_fs.classless_journey_map,
    i2_fs.sumP, i2_fs.od_mile, i2_fs.leg_prices, i2_fs.leg_miles, i2_fs.mkt_carrier_code_list,
    i2_fs.operating_carrier_list, i2_fs.mkt_carrier, i2_fs.op_carrier,
    0 AS n_pkg, NULL AS price, NULL AS key_type,
    i2_fs.distribution_channel, i2_fs.source_code, i2_fs.ticket_document_amount, i2_fs.FILE_SOURCE,
    NULL AS skytra_search
    FROM (
      SELECT * EXCEPT(pl_id)
      FROM iata.I2
      WHERE FILE_SOURCE = source_file
      AND dt_of_issue BETWEEN from_date AND to_date
    ) i2_fs
    LEFT JOIN(
      SELECT DISTINCT ticket_id
      FROM matching.X6_in1196
      WHERE dt_of_issue BETWEEN from_date AND to_date
    ) x6
    ON i2_fs.ticket_id = x6.ticket_id
    -- check that ticket_id has never been injected in X6 idependantly of FILE_SOURCE
    WHERE x6.ticket_id IS NULL;

    SET jobInfo = ( SELECT [ STRUCT(@@row_count as rc, @@script.bytes_processed as bp, @@script.bytes_billed as bb) ] );
    CALL log_sp.sp_proc_load_end(from_date, uid, jobInfo);


    EXCEPTION WHEN ERROR THEN
    --LOG EXCEPTION
    --@@error.stack_trace is ARRAY<STRUCT<line INT64, column INT64, filename STRING, location STRING>>
    --@@error.message will exactly match the message string supplied (which may be NULL if message is NULL).
    RETURN;
    END;
  END IF;

END;