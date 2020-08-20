CREATE OR REPLACE PROCEDURE `skytra-benchmark-rnd.iata_sp.sp_process_X3`(IN from_date DATE, IN to_date DATE, IN gcsFileFilter STRING)
BEGIN
  --NB: In this sp, from_date and to_date ARE INFORMATIVE ONLY (for Logging) because load is FILE-BASED not date-based as outlined in Idempotent Delete section below
  --CALL iata_sp.sp_process_X3('2020-03-02', '2020-03-08', 'FinalOutput_2020-03-02_w_2020-03-08_Global', 'gs://ext-iata-excl-data/2020/loaded_to_bq/');

  DECLARE dset STRING DEFAULT 'iata';
  DECLARE dtbl STRING DEFAULT 'X3';

  DECLARE bq_ts TIMESTAMP;
  DECLARE uid INT64;
  DECLARE jobInfo ARRAY< STRUCT<rc INT64, bp INT64, bb INT64> >;

  DECLARE metric_loc0 INT64;
  DECLARE metric_loc1 INT64;
  DECLARE metric_loc2 INT64;
  DECLARE metric_loc3 INT64;
  DECLARE metric_loc4 INT64;


  SET bq_ts = @@script.creation_time;
  CALL log_sp.sp_proc_load_start(bq_ts, dset, dtbl, from_date, to_date, uid);

----------------------------------------------------------------------------------------------------
  --------------------------------------------------------------------------------------------------
  -- IATA       : X3 -- Cleaning raw data
  -- Query name : X3
  -- Authors    : D JENKINS, T HENRY
  -- Modified   : D TWEED, B KASSE
  --------------------------------------------------------------------------------------------------
  -- Inputs     : %%X1%% (RAW IATA DATA)
  -- Output     : %%X3%%
  --------------------------------------------------------------------------------------------------
  -- ASSUMPTIONS: ONLY APPLICABLE FOR IATA RAW DATA STANDARD BATCH 4
  --------------------------------------------------------------------------------------------------
  -- References : B1,B2,B3,B4,B5
  CREATE OR REPLACE TEMP TABLE
  -- Collect multiple IATA raw data version batch3_v2 a.k.a batch4
  iata_input AS(
    SELECT * EXCEPT(file_source),
      ARRAY_REVERSE(SPLIT(file_source,'/'))[SAFE_OFFSET(0)] AS FILE_SOURCE,
      IFNULL(SAFE_CAST(segment_id AS INT64),-1) AS seg_id
    FROM iata.int_X1_file_analysis
    WHERE file_source LIKE CONCAT('%',gcsFileFilter,'%')
  );

  --SP--
  -- Bring in file_source into X3
  DELETE iata.X3
  WHERE dt_of_issue > '1970-01-01'
  AND FILE_SOURCE LIKE CONCAT('%',gcsFileFilter,'%');

  -- Clean up list of discarded iata_rows
  DELETE stat.X1_discarded
  WHERE dt_of_issue > '1970-01-01'
  AND FILE_SOURCE LIKE CONCAT('%',gcsFileFilter,'%');
  --SP--

  --SP--
  CREATE OR REPLACE TEMP TABLE
  metric_meta AS (
    SELECT uid AS pl_id, dset AS ds,  dtbl AS tb, bq_ts AS ts
  );
  --SP--

  --SP-- R.1.0: number of rows
  SET metric_loc0 = (SELECT MAX(metric_id) FROM stat.metric_dim WHERE metric_code = 'R.1.0');
  INSERT INTO stat.metric
  SELECT
    pl_id,ds,tb,metric_tx_date,
    metric_loc0 AS metric_id, CAST(metric_value AS NUMERIC) AS metric_value,
    ts
  FROM metric_meta, (
    SELECT
      dt_of_issue AS metric_tx_date,
      COUNT(*) AS metric_value
    FROM (
      SELECT IFNULL(SAFE.PARSE_DATE('%Y%m%d',dt_of_issue),DATE('1970-01-01')) AS dt_of_issue,
      ticket_id, segment_id
      FROM iata_input
    )
    GROUP BY dt_of_issue
  );
  --SP--

  --SP-- R.1.1: number of null lines
  SET metric_loc1 = (SELECT MAX(metric_id) FROM stat.metric_dim WHERE metric_code = 'R.1.1');

  INSERT INTO stat.metric
  SELECT
    pl_id,ds,tb,metric_tx_date,
    metric_loc1 AS metric_id, CAST(metric_value AS NUMERIC) AS metric_value,
    ts
  FROM metric_meta, (
    SELECT
      dt_of_issue AS metric_tx_date,
      COUNTIF(
        dt_of_issue = '1970-01-01'
        OR ticket_id IS NULL OR TRIM(ticket_id) = ''
        OR SAFE_CAST(segment_id AS INT64) IS NULL
      ) AS metric_value
    FROM (
      SELECT IFNULL(SAFE.PARSE_DATE('%Y%m%d',dt_of_issue),DATE('1970-01-01')) AS dt_of_issue,
      ticket_id, segment_id
      FROM iata_input
    )
    GROUP BY dt_of_issue
  );
  --SP--

  CREATE OR REPLACE TEMP TABLE
  all_iata_casted AS (
    -- Parse data
    -- reference B1
    SELECT
      SAFE.PARSE_DATE('%Y%m%d',dt_of_issue) AS dt_of_issue, TRIM(ticket_id) AS ticket_id,
      IF(true_origin LIKE '%/%',SPLIT(TRIM(true_origin),"/")[OFFSET(0)],NULL) AS o,
      IF(true_origin LIKE '%/%',SPLIT(TRIM(true_origin),"/")[OFFSET(1)],NULL) AS d,
      IF(class_of_service IS NULL,'',TRIM(class_of_service)) AS class_of_service,
      IF(od_cabin_class IS NULL,'',TRIM( od_cabin_class)) AS od_cabin_class,
      IF(cabin_class IS NULL,'OTHER',TRIM( cabin_class)) AS cabin_class,
      TRIM( stopover_code) AS stopover_code,
      MKT_CARRIER_FLT_NBR AS mkt_carrier_flt_nbr, CARRIER_TYPE AS carrier_type,
      SAFE_CAST(FIRST_CLASS_SEAT_CNT AS INT64) AS first_class_seat_cnt,
      SAFE_CAST(BUSINESS_CLASS_SEAT_CNT AS INT64) AS business_class_seat_cnt,
      SAFE_CAST(ECONOMY_CLASS_SEAT_CNT AS INT64) AS economy_class_seat_cnt,
      IF(transaction_code IS NULL,'',TRIM(transaction_code)) AS transaction_code,
      TRIM(mkt_carrier_code) AS mkt_carrier_code,
      TRIM(operating_carrier) AS operating_carrier,
      SAFE_CAST(segment_mile AS FLOAT64) AS segment_mile,
      SAFE_CAST(segment_id AS INT64) AS segment_id,
      SAFE_CAST(tot_coupn2 AS INT64) AS tot_coupn2,
      SAFE_CAST(reg_seg_fare AS FLOAT64) AS reg_seg_fare,
      TRIM(origin_airport_city_code) AS flyfrom_leg, TRIM(destination_airport_city_code) AS flyto_leg,
      SAFE.PARSE_DATETIME('%Y%m%d %H%M',CONCAT(FLIGHT_DATE,' ',CAST(flight_depart_time AS STRING))) AS flight_datetime_local,
      ticketing_carrier,
      TRIM(DISTRIBUTION_CHANNEL) AS distribution_channel,
      TRIM(SOURCE_CODE) AS source_code,
      SAFE_CAST(TICKET_DOCUMENT_AMOUNT AS FLOAT64) AS ticket_document_amount,
      -- preparation for reference E2: detection of arunk
      CASE
      WHEN flight_date IS NULL THEN TRUE
      WHEN TRIM(flight_date) IN ('','99990101') THEN TRUE
      WHEN flight_arrival_date IS NULL THEN TRUE
      WHEN TRIM(flight_arrival_date) IN ('','99990101') THEN TRUE
      WHEN flight_depart_time IS NULL THEN TRUE
      WHEN flight_arrival_time IS NULL THEN TRUE
      WHEN TRIM(mkt_carrier_code) = 'V' THEN TRUE
      ELSE FALSE
      END AS arunk,
      FILE_SOURCE,
      -- reference: B3 detect duplicates
      ROW_NUMBER() OVER(PARTITION BY ticket_id, segment_id) AS i_dup
    FROM iata_input i
    -- reference: B1 get rid of empty rows
    WHERE ticket_id IS NOT NULL
    AND TRIM(ticket_id) NOT LIKE ''
    AND SAFE_CAST(segment_id AS INT64) IS NOT NULL
    AND SAFE.PARSE_DATE('%Y%m%d',dt_of_issue) IS NOT NULL
  );

  --SP--R.1.2: number of duplicates
  SET metric_loc2 = (SELECT MAX(metric_id) FROM stat.metric_dim WHERE metric_code = 'R.1.2');

  INSERT INTO stat.metric
  SELECT
    pl_id,ds,tb,metric_tx_date,
    metric_loc2 AS metric_id, CAST(metric_value AS NUMERIC) AS metric_value,
    ts
  FROM metric_meta, (
    SELECT
      dt_of_issue AS metric_tx_date,
      COUNTIF(i_dup>1) AS metric_value
    FROM all_iata_casted
    GROUP BY dt_of_issue
  );

  INSERT INTO stat.X1_discarded
  SELECT uid AS pl_id, metric_loc2 AS metric_id, iata_input.* EXCEPT(seg_id)
  FROM iata_input
  INNER JOIN (
    SELECT DISTINCT ticket_id, segment_id
    FROM all_iata_casted
    WHERE i_dup > 1
  ) dup
  ON iata_input.ticket_id = dup.ticket_id
  AND iata_input.seg_id = dup.segment_id
  ORDER BY ticket_id,segment_id;
  --SP--

  CREATE OR REPLACE TEMP TABLE
  iata_rows AS (
    -- reference: B3 remove duplicates
    SELECT
    ticket_id, segment_id, dt_of_issue, o, d, class_of_service, od_cabin_class, cabin_class, stopover_code,
    -- ensure that any negative reg_seg_fare are not flagged as I : Issue
    IF(reg_seg_fare<0. AND transaction_code = 'I','R',transaction_code) AS transaction_code,
    mkt_carrier_code, operating_carrier, segment_mile, tot_coupn2,
    -- force reg_seg_fare to be positive or 0.
    IFNULL(ABS(reg_seg_fare),0.) AS reg_seg_fare,
    flyfrom_leg,  flyto_leg, flight_datetime_local,
    ticketing_carrier, distribution_channel, source_code, ticket_document_amount,
    arunk, mkt_carrier_flt_nbr, carrier_type,
    first_class_seat_cnt, business_class_seat_cnt, economy_class_seat_cnt,
    FILE_SOURCE
    FROM all_iata_casted
    WHERE i_dup = 1
  );


  CREATE OR REPLACE TEMP TABLE
  I_ticket AS (
    -- aggregate by ticket id, count per ticket_id legs not complying to one selection criteria or an other
    -- reference B3,B5
    SELECT
      ticket_id,
      ANY_VALUE(dt_of_issue) AS dt_of_issue,
      COUNT(DISTINCT dt_of_issue) AS nb_dt_issue,
      COUNT(DISTINCT tot_coupn2) AS nb_coupn2,
      COUNTIF(tot_coupn2 IS NULL) AS bad_coupn2,
      DATE_DIFF(
        EXTRACT (DATE FROM MIN(flight_datetime_local)),
        ANY_VALUE(dt_of_issue),DAY
      ) AS leadtime,
      ANY_VALUE(tot_coupn2) AS total_segments, COUNT(*) AS nb_legs,
      (MAX(segment_id) = COUNT(DISTINCT segment_id) AND MIN(segment_id) = 1) AS cons_seg,
      -- Reference: Detect for B2 B3
      -- TEST for bad value in the leg row and count them per ticket
      -- OD_CABIN_CLASS  AO": All Other, "Y": Full Eco, "DY":Discount Eco, F: First, C: Business Cabin Classes.
      COUNTIF(od_cabin_class NOT IN ('DY','AO','Y','C','F')) AS bad_class,
      -- Prep for reference E2
      COUNTIF(od_cabin_class NOT IN ('DY','Y')) AS not_eco,
      -- Prep for reference E2
      COUNTIF(transaction_code IN ('E','R')) AS  not_issue,
      COUNTIF(transaction_code NOT IN ('E','R','I','V')) AS  bad_tr_code,
      -- discarded as we keep arunk legs in X.1
      COUNTIF(arunk) AS nb_arunk,
      ANY_VALUE(FILE_SOURCE) AS FILE_SOURCE
    FROM iata_rows
    GROUP BY ticket_id
  );

  --SP--R.1.3 intineraries with invalid values
  SET metric_loc3 = (SELECT MAX(metric_id) FROM stat.metric_dim WHERE metric_code = 'R.1.3');

  INSERT INTO stat.metric
  SELECT
    pl_id,ds,tb,metric_tx_date,
    metric_loc3 AS metric_id, CAST(metric_value AS NUMERIC) AS metric_value,
    ts
  FROM metric_meta, (
    SELECT
      dt_of_issue AS metric_tx_date,
      COUNTIF(
        nb_dt_issue > 1
        OR nb_coupn2 > 1
        OR bad_coupn2 > 0
        OR bad_tr_code > 0
        OR bad_class > 0
      ) AS metric_value
    FROM I_ticket
    GROUP BY dt_of_issue
  );

  INSERT INTO stat.X1_discarded
  SELECT uid AS pl_id, metric_loc3 AS metric_id, iata_input.* EXCEPT(seg_id)
  FROM iata_input
  INNER JOIN (
    SELECT DISTINCT ticket_id
    FROM I_ticket
    WHERE nb_dt_issue  > 1
    OR nb_coupn2 > 1
    -- prevent for NULL in tot_coupn2
    OR bad_coupn2 > 0
    -- check that the data is proper
    OR bad_tr_code > 0
    OR bad_class > 0
  ) bad
  ON iata_input.ticket_id = bad.ticket_id
  ORDER BY ticket_id,segment_id;
  --SP--

  --SP--R.1.4 intineraries with missing legs
  SET metric_loc4 = (SELECT MAX(metric_id) FROM stat.metric_dim WHERE metric_code = 'R.1.4');

  INSERT INTO stat.metric
  SELECT
    pl_id,ds,tb,metric_tx_date,
    metric_loc4 AS metric_id, CAST(metric_value AS NUMERIC) AS metric_value,
    ts
  FROM metric_meta, (
    SELECT
      dt_of_issue AS metric_tx_date,
      COUNTIF(
        nb_legs != total_segments OR NOT cons_seg
      ) AS metric_value
    FROM I_ticket
    GROUP BY dt_of_issue
  );

  INSERT INTO stat.X1_discarded
  SELECT uid AS pl_id, metric_loc4 AS metric_id, iata_input.* EXCEPT(seg_id)
  FROM iata_input
  INNER JOIN (
    SELECT DISTINCT ticket_id
    FROM I_ticket
    WHERE nb_legs != total_segments
    OR NOT cons_seg
  ) inc
  ON iata_input.ticket_id = inc.ticket_id
  ORDER BY ticket_id,segment_id;
  --SP--


  INSERT INTO iata.X3
  -- Main query :
  --- each row is a leg within an itinerary, if any leg is invalid the full itinerary is filtered out
  --- Use inner join to apply itineraries filters and to broadcast dt_of_issue, ticket_id, number of legs
  --- Create reference dataset output X.3
  SELECT
    uid AS pl_id, -- uid is a constant set in stored proc replace with O for manual
    it.ticket_id, segment_id, ir.dt_of_issue, nb_legs, not_eco, not_issue, nb_arunk,leadtime,
    flight_datetime_local, flyfrom_Leg , flyto_leg, o, d, Class_of_Service, od_cabin_class,
    cabin_class, stopover_code,
    reg_seg_fare, segment_mile, operating_carrier, mkt_carrier_code, transaction_code, arunk,
    ticketing_carrier,distribution_channel, source_code, ticket_document_amount,
    mkt_carrier_flt_nbr, carrier_type,
    first_class_seat_cnt, business_class_seat_cnt, economy_class_seat_cnt,
    it.FILE_SOURCE
  FROM I_ticket it
  INNER JOIN iata_rows ir -- reference B4
  ON it.ticket_id = ir.ticket_id
  -- reference B4
  -- check unicity of dt_of_issue and tot_coupn2
  WHERE nb_dt_issue =1
  AND nb_coupn2 = 1
  -- prevent for NULL in tot_coupn2
  AND bad_coupn2 = 0
  -- check that all legs are accounted for
  AND nb_legs = total_segments AND cons_seg
  -- check that the data is proper
  AND bad_tr_code = 0
  AND bad_class = 0;
----------------------------------------------------------------------------------------------------

  SET jobInfo = (
    SELECT [ STRUCT(@@row_count AS rc, @@script.bytes_processed AS bp, @@script.bytes_billed AS bb) ]
  );
  CALL log_sp.sp_proc_load_end(from_date, uid, jobInfo);


/*EXCEPTION WHEN ERROR THEN
  --@@error.stack_trace is ARRAY<STRUCT<line INT64, column INT64, filename STRING, location STRING>>
  --@@error.message will exactly match the message string supplied (which may be NULL if message is NULL).
  RETURN; */

END;