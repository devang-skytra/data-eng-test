CREATE OR REPLACE PROCEDURE kiwi_PROD.sp_process_X4(IN from_date DATE, IN to_date DATE, IN debug_mode BOOL)
BEGIN

  --CALL kiwi_TEST.sp_process_X4('2019-05-17', '2019-05-17', TRUE);

  --DECLARE item DEFAULT (SELECT item FROM dataset1.products LIMIT 1);
  DECLARE dt DATE;
  DECLARE dset STRING DEFAULT 'kiwi_TEST';
  
  SET dt = from_date;
  
  WHILE dt <= to_date DO
    BEGIN

      --variables can have different scopes, so set WHILE scope variables here
      DECLARE bq_ts TIMESTAMP;
      DECLARE dtString STRING;
      DECLARE dtPrefix STRING;
      DECLARE proc_instance STRING;
      DECLARE dtbl STRING;

    --SET (variable_name_1, variable_name_2, …, variable_name_n) =
      --(expression_1, expression_2, …, expression_n);

      SET bq_ts = @@script.creation_time;
      SET dtString = CAST(dt as STRING);
      SET dtPrefix = CONCAT('%', REPLACE(dtString, '-', '/'), '%.gz.parquet');
      SET proc_instance = CONCAT('kiwi_TEST.sp_process_X4', ' ', dtString);
	  
      IF debug_mode THEN 
        INSERT INTO log.debug_any(ts, msg) VALUES( bq_ts, proc_instance );
      END IF;

    -- query: X4
    ------------------------------------------
      SET dtbl = 'X4_2019';
      
      IF debug_mode THEN
        
      ELSE
        DELETE kiwi_TEST.X4_2019 WHERE search_date = dt;

        CREATE TEMP TABLE
        preK1 AS (
          SELECT
            EXTRACT(date FROM TIMESTAMP_SECONDS(timestamp)) AS search_date,
            data_list.element.booking_token.sid AS sid,
            ind_sid,
            data_list.element.booking_token.id AS btid,
            data_list.element.booking_token.p AS p,
            data_list.element.route AS routes
          FROM kiwi_TEST.ext_kiwi_pq_CurrentProcessingMonth,
            UNNEST(data.list) AS data_list WITH OFFSET ind_sid
          WHERE
            _FILE_NAME LIKE dtPrefix
            AND search_params.flyFrom_type != 'anywhere'
            AND search_params.to_type != 'anywhere'
            AND search_params.flyFrom_type!='radius'
            AND search_params.to_type!='radius'
            AND ARRAY_LENGTH(data_list.element.route.list) < 7
        );

        CREATE TEMP TABLE itinerary_unduplicated AS (
          SELECT
            ANY_VALUE(search_date) AS search_date, sid, ind_sid,
            ANY_VALUE(btid) AS btid, ANY_VALUE(p) AS p, ANY_VALUE(routes) AS routes
          FROM preK1
          GROUP BY sid, ind_sid
        );

        CREATE TEMP TABLE routes_unfiltered AS (
          SELECT
            search_date, sid, ind_sid,btid,p,
            route_list.element.id AS leg_id,
            route_list.element.flyFrom AS leg_origin,
            route_list.element.flyTo AS leg_dest,
            route_list.element.dTimeUTC AS leg_depTS,
            route_list.element.fare_classes AS leg_class,
            COUNTIF(route_list.element.vehicle_type != 'aircraft') OVER(PARTITION BY sid,ind_sid) AS not_aircraft,
            COUNTIF(TRIM(route_list.element.fare_category) NOT IN ('M','W','')) OVER(PARTITION BY sid,ind_sid) AS not_eco
          FROM itinerary_unduplicated, UNNEST(routes.list) AS route_list
        );


      --qc multi-query
      --select 
      --COUNTIF(search_date != dt) as date_leakage
      --
      --from routes_unfiltered

        INSERT INTO kiwi_TEST.X4_2019
        SELECT
          bq_ts AS af_load_ts,
          search_date, sid, ind_sid, btid, p,
          REGEXP_REPLACE(leg_id,'_(\\d+)$','') AS pkg_id,
          leg_origin, leg_dest, leg_depTS, leg_class
        FROM routes_unfiltered
        WHERE 
        search_date = dt AND 
        not_aircraft = 0
        AND not_eco = 0;

        insert into log.load(af_load_ts, ds, tb, af_task_instance) 
        values( bq_ts, dset, dtbl, proc_instance );

      END IF;

    EXCEPTION WHEN ERROR THEN
      --LOG EXCEPTION
      --@@error.stack_trace is ARRAY<STRUCT<line INT64, column INT64, filename STRING, location STRING>>
    END;
    
    

    SET dt = DATE_ADD(dt, INTERVAL 1 DAY);
  END WHILE;

  --SELECT SOMETHING IF WISH TO RETURN NON-OUT PARAMETER;
  

END;