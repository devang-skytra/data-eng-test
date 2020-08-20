


****asked Archi and Paulo if dt_of_issue >= '2017-10-19' should be globally replaced with dt_of_issue IS NOT NULL
*******

REM First, do global replace of prior file with new file, etc.
REM prior file 'FinalOutput_2020-07-06_w_2020-07-12_Global.csv'

SET file_date_int_start=20200720
SET file_date_int_end=20200726

SET from_file='IATA_daily_api_%file_date_int_start%'
SET to_file='IATA_daily_api_%file_date_int_end%'
echo %to_file%


'IATA_daily_api_', CAST(from_date


REM check  iata.int_X1_file_analysis  AND  matching.X6  updated in PROD and not RnD

REM with RnD project active

REM 1
REM bq cp d-dat-digitalaircrafttransport:iata.X1 iata.X1

bq query --destination_table iata.X1 \
--append_table \
--use_legacy_sql=false --allow_large_results \
"SELECT *
FROM d-dat-digitalaircrafttransport.iata.X1
WHERE file_date_int between %file_date_int_start% and %file_date_int_end%"

"""
run following to see rows_written

SELECT job_type, MAX(j.status) as job_status, start_time, end_time, destination_table.dataset_id, destination_table.table_id, total_bytes_processed as total_bytes,
0 as rows_read, SUM(IF(j.name like '%: Output', j.records_written, 0)) as rows_written, 
FROM `region-eu.INFORMATION_SCHEMA.JOBS_BY_USER`, UNNEST(job_stages) AS j
WHERE 
DATE(creation_time) = CURRENT_DATE 
AND user_email LIKE '%desmond%'
GROUP BY 1,3,4,5,6,7
ORDER BY start_time desc
LIMIT 20
"""
REM int_X1_file_analysis 	21,305,571 - 	22,201,003

REM 2 X3
REM bq cp iata.X3 zzz_PreDeployBak_Expire14d.X3_20200727

REM NB: these params are slightly different to Migrated Call
CALL `skytra-benchmark-rnd.iata_sp.sp_process_X3_daily`(%file_date_int_start%, %file_date_int_end%);

REM X3 					21,296,859 - 	22,191,924
REM metric 				572				546

REM 3 R1

cd indexproduction
git pull
git checkout feature/IN-1092-create-a-waterfall-pricing-mecha
#cd bq/sq/Iata-revenue-pipeline/

bq query --destination_table iata.R1 ^
--append_table ^
--use_legacy_sql=false --allow_large_results ^
"WITH iata_legs AS (
  -- Select everythin from IATA except
  -- arunk legs and not eco OD
  SELECT
    dt_of_issue, ticket_id, segment_id, nb_legs, leadtime,
    o, d, flyfrom_leg,flyto_leg, flight_datetime_local,
    SAFE.TIMESTAMP(flight_datetime_local,rd.timezone_o) AS flight_datetime_utc,
    class_of_service, transaction_code, mkt_carrier_code, operating_carrier,
    CAST(ROUND(rd.dist_km,1) AS NUMERIC) AS dist_km,
    CAST(ROUND(reg_seg_fare,2) AS NUMERIC) AS reg_seg_fare,
    stopover_code,  not_eco, od_cabin_class, cabin_class,
    ticketing_carrier, distribution_channel, source_code,
    CAST(ROUND(ticket_document_amount,2) AS NUMERIC) AS ticket_document_amount,
    FILE_SOURCE
  FROM iata.X3 x3 -- should be iata.X3 when data is migrated
  LEFT JOIN generic.long_skytra_distance_table rd
  ON x3.flyFrom_leg = rd.iata_code_o
  AND x3.flyTo_leg = rd.iata_code_d
  WHERE NOT arunk
  AND dt_of_issue >= '2017-10-19'
  AND FILE_SOURCE between %from_file% and %to_file%
)
-- Add country and region using skytra_ariports
-- Construct leg_maps and classless_leg_map
SELECT
  0 AS pl_id,
  ticket_id, segment_id,
  dt_of_issue,leadtime,nb_legs,
  o,d, a_o.country AS leg_true_o_country, a_d.country AS leg_true_d_country,
  a_o.traffic_region AS leg_true_o_region, a_d.traffic_region AS leg_true_d_region,
  IF(a_o.traffic_region < a_d.traffic_region,
    CONCAT(a_o.traffic_region ,'-',a_d.traffic_region),
    CONCAT(a_d.traffic_region ,'-',a_o.traffic_region)
  ) AS leg_true_region_pair_nondirectional,
  IF(a_o.country < a_d.country,
    CONCAT(a_o.country ,'-',a_d.country),
    CONCAT(a_d.country,'-',a_o.country)
  ) AS leg_true_country_pair_nondirectional,
  IF(leg_origin.traffic_region < leg_dest.traffic_region,
    CONCAT(leg_origin.traffic_region ,'-',leg_dest.traffic_region),
    CONCAT(leg_origin.traffic_region ,'-',leg_dest.traffic_region)
  ) AS leg_flight_region_pair_nondirectional,
  IF(leg_origin.country < leg_dest.country,
    CONCAT(leg_origin.country ,'-',leg_dest.country),
    CONCAT(leg_origin.country,'-',leg_dest.country)
  ) AS leg_flight_country_pair_nondirectional,
  flight_datetime_utc, flight_datetime_local, flyFrom_Leg, flyTo_leg,
  leg_origin.country AS flight_o_country, leg_dest.country AS flight_d_country,
  leg_origin.traffic_region AS flight_o_region, leg_dest.traffic_region AS flight_d_region,
  CONCAT(
    FORMAT_TIMESTAMP('%Y%m%d%H%M',flight_datetime_utc),'_',flyFrom_Leg,'-',flyTo_leg ,'(',Class_of_Service,')'
  ) AS leg_map,
  CONCAT(
    FORMAT_TIMESTAMP('%Y%m%d%H%M',flight_datetime_utc),'_',flyFrom_Leg,'-',flyTo_leg
  ) AS classless_leg_map,
  reg_seg_fare, dist_km, operating_carrier, mkt_carrier_code, transaction_code,
  class_of_service, od_cabin_class, cabin_class,
  not_eco, stopover_code, ticketing_carrier,
  distribution_channel, source_code, ticket_document_amount, FILE_SOURCE
FROM iata_legs i_l
LEFT JOIN generic.skytra_airports a_o
ON i_l.o = a_o.iata_code
LEFT JOIN generic.skytra_airports a_d
ON i_l.d = a_d.iata_code
LEFT JOIN generic.skytra_airports leg_origin
ON i_l.flyFrom_leg = leg_origin.iata_code
LEFT JOIN generic.skytra_airports leg_dest
ON i_l.flyTo_leg = leg_dest.iata_code
"
REM R1 20,681,978

REM 4 R2 CASE STATEMENT gets broken by Bash so have to run manually
#bq query --destination_table iata.R2 --append_table --use_legacy_sql=false --allow_large_results 
"

WITH
r1 AS (
  -- Read r1 make o-d pair symetrical so that o, d is the same for return flight
  SELECT *,
  EXTRACT(DATE FROM flight_datetime_local) AS flight_date_local,
  EXTRACT(HOUR FROM flight_datetime_local) AS flight_hour_local,
  IF(o<d,CONCAT(o,'-',d),CONCAT(d,'-',o)) AS true_port_pair_leg_nondirectional,
  IF(flyFrom_leg<flyTo_leg,
    CONCAT(flyFrom_leg,'-',flyTo_leg),
    CONCAT(flyTo_leg,'-',flyFrom_leg)
  ) AS flight_port_pair_leg_nondirectional,
  CONCAT(o,"-",d) AS true_port_pair_leg_directional,
  CONCAT(leg_true_o_country,"-",leg_true_d_country) AS true_country_pair_leg_directional,
  CONCAT(leg_true_o_region,"-",leg_true_d_region) AS true_region_pair_leg_directional,
  CONCAT(flyFrom_leg,"-",flyTo_leg) AS  flight_port_pair_leg_directional,
  CONCAT(leg_true_o_country,"-",leg_true_d_country) AS flight_country_pair_leg_directional,
  CONCAT(leg_true_o_region,"-",leg_true_d_region) AS flight_region_pair_leg_directional
  FROM iata.R1
  WHERE dt_of_issue >= '2017-10-19'
  AND FILE_SOURCE = 'FinalOutput_2020-07-06_w_2020-07-12_Global.csv'
),
ticket_port_pair AS (
  -- We can have multiple and null port_pair, solve the problem here.  Results in a list by value AS long AS there is at least one entry.
  SELECT
    ticket_id,
    STRING_AGG(DISTINCT true_port_pair_leg_nondirectional ORDER BY true_port_pair_leg_nondirectional) AS port_pair
  FROM r1
  WHERE true_port_pair_leg_nondirectional IS NOT NULL
  GROUP BY ticket_id
),
ticket_region_pair AS (
  -- We can have multiple and null region_pair, solve the problem here.  Results in a list by value AS long AS there is at least one entry.
  SELECT
    ticket_id,
    STRING_AGG(DISTINCT leg_true_region_pair_nondirectional ORDER BY leg_true_region_pair_nondirectional) AS region_pair
  FROM r1
  WHERE leg_true_region_pair_nondirectional IS NOT NULL
  GROUP BY ticket_id
),
ticket_country_pair AS (
  -- We can have multiple and null country_pair, solve the problem here.  Results in a list by value AS long AS there is at least one entry.
  SELECT
    ticket_id,
    STRING_AGG(DISTINCT leg_true_country_pair_nondirectional ORDER BY leg_true_country_pair_nondirectional) AS country_pair
  FROM r1
  WHERE leg_true_country_pair_nondirectional IS NOT NULL
  GROUP BY ticket_id
),

itin_operating_carrier AS (
  -- Get largest op carrier per itinerary.
  SELECT
    ticket_id,
    IF(MAX(carrier_pct)>=0.6,
        ARRAY_AGG(operating_carrier ORDER BY carrier_pct DESC)[OFFSET(0)]
        ,NULL
    ) AS itin_op_carrier
  FROM (
    -- DyT refrained from cleaning up ANY_VALUE(carrier_dist) -> SUM(dist_km)
    SELECT ticket_id, operating_carrier, ANY_VALUE(carrier_dist) / ANY_VALUE(itin_dist) AS carrier_pct
    FROM (
      SELECT
        ticket_id, operating_carrier,
        SUM(dist_km) OVER (PARTITION BY ticket_id) AS itin_dist,
        SUM(dist_km) OVER (PARTITION BY ticket_id, operating_carrier) AS carrier_dist
      FROM r1
    )
    GROUP BY ticket_id, operating_carrier
  )
  GROUP BY ticket_id
)
SELECT
  0 AS pl_id,
  r1.ticket_id,
  --Single value per itinerary:
  ANY_VALUE(dt_of_issue) AS dt_of_issue,
  ANY_VALUE(leadtime) AS leadtime,
  STRING_AGG(leg_Map ORDER BY segment_id ) AS journey_map,
  STRING_AGG(classless_leg_Map ORDER BY segment_id ) AS classless_journey_map,
  ANY_VALUE(nb_legs) AS nb_legs,
  COUNTIF(stopover_code = 'X') AS nb_stopover,
  ANY_VALUE(transaction_code) AS transaction_code_itin,
  MAX(not_eco>0) AS not_eco_itin,-- aggregate OR functionality for the not_eco flag
  ARRAY_AGG( EXTRACT (DATE FROM flight_datetime_utc)   ORDER BY segment_id)[OFFSET(0)] AS first_flight_date_utc,
  ARRAY_AGG( EXTRACT (DATE FROM flight_datetime_local) ORDER BY segment_id)[OFFSET(0)] AS first_flight_date_local,
  CASE
		WHEN ANY_VALUE(leadtime) BETWEEN 0 AND 6 THEN 'short-term'
		WHEN ANY_VALUE(leadtime) BETWEEN 7 AND 51 THEN 'mid-term'
		WHEN ANY_VALUE(leadtime)>51 then 'long-term'
		ELSE NULL
  END as flight_date_horizon,
  ANY_VALUE(ticket_region_pair.region_pair) AS region_pair_itin_nondirectional,
  ANY_VALUE(ticket_country_pair.country_pair) AS country_pair_itin_nondirectional,
  ANY_VALUE(ticket_port_pair.port_pair) AS port_pair_itin_nondirectional,
  SUM(reg_seg_fare) AS sumP, SUM(dist_km) AS itin_dist_km,
  ANY_VALUE(itin_op_carrier) AS itin_op_carrier,
  ANY_VALUE(ticketing_carrier) AS ticketing_carrier,
  ANY_VALUE(distribution_channel) AS distribution_channel,-- distribustion channel and source code feature
  ANY_VALUE(source_code) AS source_code,
  AVG(ticket_document_amount) AS ticket_document_amount_itin,-- full ticket amount
  -- FILE_SOURCE
    --Date and time:
    STRING_AGG(FORMAT_DATETIME('%Y%m%d%H%M',flight_datetime_local) ORDER BY segment_id) AS flight_datetime_local_list_byleg,
    STRING_AGG(FORMAT_DATE('%Y%m%d',flight_date_local) ORDER BY segment_id) AS flight_date_local_list_byleg,
    STRING_AGG(CAST(EXTRACT(DAYOFWEEK FROM flight_date_local) AS STRING) ORDER BY segment_id) AS flight_DoW_local_list_byleg,
    STRING_AGG(CAST(flight_hour_local AS STRING) ORDER BY segment_id) AS flight_hour_local_list_byleg,
    STRING_AGG(CAST(TRUNC(flight_hour_local/3.0) AS STRING) ORDER BY segment_id) AS flight_ToD_local_list_byleg,  --given as octile base 0
	  STRING_AGG(CAST(TRUNC(flight_hour_local/6.0) AS STRING) ORDER BY segment_id) AS flight_ToD_quartile_local_list_byleg,
    --leg based O&D:
    STRING_AGG(flight_port_pair_leg_directional ORDER BY segment_id) AS leg_port_pair_list_byleg_directional,
    STRING_AGG(flight_port_pair_leg_nondirectional ORDER BY segment_id) AS leg_port_pair_list_byleg_nondirectional,
    STRING_AGG(leg_flight_country_pair_nondirectional ORDER BY segment_id) AS leg_country_pair_list_byleg_nondirectional,
    STRING_AGG(leg_flight_region_pair_nondirectional ORDER BY segment_id) AS leg_region_pair_list_byleg_nondirectional,
    STRING_AGG(flight_country_pair_leg_directional ORDER BY segment_id) AS leg_country_pair_list_byleg_directional,
    STRING_AGG(flight_region_pair_leg_directional ORDER BY segment_id) AS leg_region_pair_list_byleg_directional,
    --trueOD based O&D:
    STRING_AGG(true_port_pair_leg_directional ORDER BY segment_id) AS true_port_pair_list_byleg_directional,
    STRING_AGG(true_country_pair_leg_directional ORDER BY segment_id) AS true_country_pair_list_byleg_directional,
    STRING_AGG(true_region_pair_leg_directional ORDER BY segment_id) AS true_region_pair_list_byleg_directional,
    STRING_AGG(true_port_pair_leg_nondirectional ORDER BY segment_id) AS true_port_pair_list_byleg_nondirectional,
    STRING_AGG(r1.leg_true_country_pair_nondirectional ORDER BY segment_id) AS true_country_pair_list_byleg_nondirectional,
    STRING_AGG(r1.leg_true_region_pair_nondirectional ORDER BY segment_id) AS true_region_pair_list_byleg_nondirectional,
    --operators and classes:
    STRING_AGG(operating_carrier ORDER BY segment_id) AS operating_carrier_list_byleg,
    STRING_AGG(class_of_Service ORDER BY segment_id) AS class_of_service_list_byleg,
    STRING_AGG(od_cabin_class ORDER BY segment_id) AS od_cabin_class_list_byleg,
    STRING_AGG(cabin_class ORDER BY segment_id) AS cabin_class_list_byleg,
    STRING_AGG(stopover_code ORDER BY segment_id) AS stopover_code_list_byleg,
	--Listed by value:
    -- sets of mqrketing and operqting cqriers
	  STRING_AGG(DISTINCT mkt_carrier_code ORDER BY mkt_carrier_code) AS mkt_carrier_list_byvalue,
	  STRING_AGG(DISTINCT operating_carrier ORDER BY operating_carrier) AS op_carrier_list_byvalue,
    -- sets of fare class
	  STRING_AGG(DISTINCT class_of_Service ORDER BY class_of_Service) AS class_of_Service_list_byvalue,
	  STRING_AGG(DISTINCT od_cabin_class ORDER BY od_cabin_class) AS od_cabin_class_list_byvalue,
	--Spare:
	  --STRING_AGG(o ORDER BY segment_id) AS true_o_port_byleg,
	  --STRING_AGG(d ORDER BY segment_id) AS true_d_port_byleg,
	  --STRING_AGG(CAST(reg_seg_fare AS STRING) ORDER BY segment_id) AS leg_prices,
	  --STRING_AGG(CAST(dist_km AS STRING) ORDER BY segment_id) AS leg_km,
	  --STRING_AGG(mkt_carrier_code ORDER BY segment_id) AS mkt_carrier_code_list,
	  --STRING_AGG(DISTINCT true_port_pair_leg_nondirectional ORDER BY true_port_pair_leg_nondirectional) AS true_port_pair_byvalue_nondirectional,
  FILE_SOURCE
FROM r1
INNER JOIN ticket_region_pair
ON r1.ticket_id = ticket_region_pair.ticket_id
INNER JOIN ticket_country_pair
ON r1.ticket_id = ticket_country_pair.ticket_id
INNER JOIN ticket_port_pair
ON r1.ticket_id = ticket_port_pair.ticket_id
INNER JOIN itin_operating_carrier
ON r1.ticket_id = itin_operating_carrier.ticket_id
GROUP BY ticket_id, FILE_SOURCE -- We account for IATA sending the same ticket multiple times

"

REM R2 13,206,349

REM 5 R3 
bq query --destination_table matching.R3 \
--append_table \
--use_legacy_sql=false --allow_large_results \
"
WITH
x6 AS (
    -- Select min priced ticket of X6
    -- Convert kiwi price in Euro int US Dallars
  SELECT
    ticket_id, price, key_type, dt_of_issue AS priced_issue
  FROM
  (
    SELECT ticket_id, dt_of_issue, key_type, price*fx AS price,
    RANK() OVER(PARTITION BY ticket_id ORDER BY price, n_pkg) AS irank
    FROM d-dat-digitalaircrafttransport.matching.X6 it
    LEFT JOIN
      d-dat-digitalaircrafttransport.generic.ext_EURUSD eurusd
    ON it.dt_of_issue = eurusd.date
    WHERE dt_of_issue >= '2017-10-19'
    AND price IS NOT NULL
  AND FILE_SOURCE = 'FinalOutput_2020-07-06_w_2020-07-12_Global.csv'
  )
  WHERE irank = 1
),
x6_priced AS (
  SELECT MAX(priced_issue) AS last_pricing
  FROM x6
),
r2 AS (
  SELECT * EXCEPT(pl_id,last_pricing)
  FROM skytra-benchmark-rnd.iata.R2, x6_priced
  WHERE dt_of_issue IS NOT NULL
  AND dt_of_issue <= x6_priced.last_pricing
  -- filtering for only eco cabin class
  AND NOT not_eco_itin
  AND FILE_SOURCE = 'FinalOutput_2020-07-06_w_2020-07-12_Global.csv'
)
SELECT
  0 AS pl_id,
  r2.*,
  CAST(x6.price/r2.itin_dist_km AS NUMERIC) AS skytra_rrpk,
  CAST(ROUND(x6.price,2) AS NUMERIC) AS price,
  x6.key_type
FROM r2
LEFT JOIN x6
ON  r2.ticket_id = x6.ticket_id
"
REM R3 8,978,050

REM 6 R4*

bq query --use_legacy_sql=false --allow_large_results "CALL index_sp.sp_process_R4_index(DATE('2017-10-19'), CURRENT_DATE());"
#
""" 
SELECT job_type, MAX(j.status) as job_status, start_time, end_time, destination_table.dataset_id, destination_table.table_id, total_bytes_processed as total_bytes,
0 as rows_read, SUM(IF(j.name like '%: Output', j.records_written, 0)) as rows_written, 
FROM `region-eu.INFORMATION_SCHEMA.JOBS_BY_USER`, UNNEST(job_stages) AS j
WHERE 
DATE(creation_time) = CURRENT_DATE 
AND user_email LIKE '%desmond%'
AND destination_table.table_id like 'R4%'
GROUP BY 1,3,4,5,6,7
ORDER BY start_time desc
LIMIT 20

R4_index19 987
R4_index18 224,409
R4_index17 14,786,435
R4_index16 157,447,483
...
R4_index11 1,008,034,374
...
R4_index03 287,643,519
"""

REM 7 R5

bq query --destination_table matching.R5 \
--replace \
--use_legacy_sql=false --allow_large_results \
"
--R5 final
WITH
rrpk_options AS (
  SELECT
    r3.* EXCEPT(pl_id,price, skytra_rrpk),
    ---accounting that before 1st of october we are not using skytra prices as per the main index
    -- reset AS-AS pre October 2019 to NULL so that they are repriced by the waterfall
    IF(
      r3.region_pair_itin_nondirectional ='Asia/Pacific-Asia/Pacific' AND r3.dt_of_issue < '2019-10-01',
      NULL,r3.skytra_rrpk
    ) AS skytra_rrpk,
    L3.skytra_rrpk  AS rrpk_3,
    L4.skytra_rrpk  AS rrpk_4,
    L5.skytra_rrpk  AS rrpk_5,
    L6.skytra_rrpk  AS rrpk_6,
    L7.skytra_rrpk  AS rrpk_7,
    L8.skytra_rrpk  AS rrpk_8,
    L9.skytra_rrpk  AS rrpk_9,
    L10.skytra_rrpk AS rrpk_10,
    L11.skytra_rrpk AS rrpk_11,
    L12.skytra_rrpk AS rrpk_12,
    L13.skytra_rrpk AS rrpk_13,
    L14.skytra_rrpk AS rrpk_14,
    L15.skytra_rrpk AS rrpk_15,
    L16.skytra_rrpk AS rrpk_16,
    L17.skytra_rrpk AS rrpk_17,
    L18.skytra_rrpk AS rrpk_18,
    L19.skytra_rrpk AS rrpk_19
  FROM matching.R3 r3
  LEFT JOIN index.R4_index03 L3
  ON r3.flight_date_local_list_byleg = L3.flight_date_local_list_byleg
  AND r3.flight_hour_local_list_byleg = L3.flight_hour_local_list_byleg
  AND r3.leg_port_pair_list_byleg_directional = L3.leg_port_pair_list_byleg_directional
  AND r3.class_of_service_list_byleg = L3.class_of_service_list_byleg
  AND r3.operating_carrier_list_byleg = L3.operating_carrier_list_byleg
  AND r3.dt_of_issue = L3.dt_of_issue

  LEFT JOIN index.R4_index04 L4
  ON r3.flight_date_local_list_byleg = L4.flight_date_local_list_byleg
  AND r3.flight_ToD_local_list_byleg = L4.flight_ToD_local_list_byleg
  AND r3.leg_port_pair_list_byleg_directional = L4.leg_port_pair_list_byleg_directional
  AND r3.class_of_service_list_byleg = L4.class_of_service_list_byleg
  AND r3.operating_carrier_list_byleg = L4.operating_carrier_list_byleg
  AND r3.dt_of_issue = L4.dt_of_issue

  LEFT JOIN index.R4_index05 L5
  ON r3.flight_date_local_list_byleg = L5.flight_date_local_list_byleg
  AND r3.flight_ToD_quartile_local_list_byleg = L5.flight_ToD_quartile_local_list_byleg
  AND r3.leg_port_pair_list_byleg_directional = L5.leg_port_pair_list_byleg_directional
  AND r3.class_of_service_list_byleg = L5.class_of_service_list_byleg
  AND r3.operating_carrier_list_byleg = L5.operating_carrier_list_byleg
  AND r3.dt_of_issue = L5.dt_of_issue

  LEFT JOIN index.R4_index06 L6
  ON r3.flight_date_local_list_byleg = L6.flight_date_local_list_byleg
  AND r3.flight_ToD_quartile_local_list_byleg = L6.flight_ToD_quartile_local_list_byleg
  AND r3.leg_port_pair_list_byleg_directional = L6.leg_port_pair_list_byleg_directional
  AND r3.class_of_service_list_byleg = L6.class_of_service_list_byleg
  AND r3.dt_of_issue = L6.dt_of_issue

  LEFT JOIN index.R4_index07 L7
  ON r3.flight_date_local_list_byleg = L7.flight_date_local_list_byleg
  AND r3.leg_port_pair_list_byleg_directional = L7.leg_port_pair_list_byleg_directional
  AND r3.class_of_service_list_byleg = L7.class_of_service_list_byleg
  AND r3.stopover_code_list_byleg = L7.stopover_code_list_byleg
  AND r3.dt_of_issue = L7.dt_of_issue

  LEFT JOIN index.R4_index08 L8
  ON r3.flight_date_local_list_byleg = L8.flight_date_local_list_byleg
  AND r3.leg_port_pair_list_byleg_directional = L8.leg_port_pair_list_byleg_directional
  AND r3.cabin_class_list_byleg = L8.cabin_class_list_byleg
  AND r3.stopover_code_list_byleg = L8.stopover_code_list_byleg
  AND r3.dt_of_issue = L8.dt_of_issue

  LEFT JOIN index.R4_index09 L9
  ON r3.flight_date_local_list_byleg = L9.flight_date_local_list_byleg
  AND r3.leg_port_pair_list_byleg_directional = L9.leg_port_pair_list_byleg_directional
  AND r3.od_cabin_class_list_byleg = L9.od_cabin_class_list_byleg
  AND r3.stopover_code_list_byleg = L9.stopover_code_list_byleg
  AND r3.dt_of_issue = L9.dt_of_issue

  LEFT JOIN index.R4_index10 L10
  ON r3.flight_date_local_list_byleg = L10.flight_date_local_list_byleg
  AND r3.leg_port_pair_list_byleg_directional = L10.leg_port_pair_list_byleg_directional
  AND r3.stopover_code_list_byleg = L10.stopover_code_list_byleg
  AND r3.dt_of_issue = L10.dt_of_issue

  LEFT JOIN index.R4_index11 L11
  ON r3.flight_date_local_list_byleg = L11.flight_date_local_list_byleg
  AND r3.leg_port_pair_list_byleg_directional = L11.leg_port_pair_list_byleg_directional
  AND r3.dt_of_issue = L11.dt_of_issue

  LEFT JOIN index.R4_index12 L12
  ON r3.first_flight_date_local = L12.first_flight_date_local
  AND r3.leg_port_pair_list_byleg_directional = L12.leg_port_pair_list_byleg_directional
  AND r3.dt_of_issue = L12.dt_of_issue

  LEFT JOIN index.R4_index13 L13
  ON r3.first_flight_date_local = L13.first_flight_date_local
  AND r3.true_port_pair_list_byleg_directional = L13.true_port_pair_list_byleg_directional
  AND r3.dt_of_issue = L13.dt_of_issue

  LEFT JOIN index.R4_index14 L14
  ON r3.first_flight_date_local = L14.first_flight_date_local
  AND r3.leg_country_pair_list_byleg_nondirectional = L14.leg_country_pair_list_byleg_nondirectional
  AND r3.op_carrier_list_byvalue = L14.op_carrier_list_byvalue
  AND r3.dt_of_issue = L14.dt_of_issue

  LEFT JOIN index.R4_index15 L15
  ON r3.first_flight_date_local = L15.first_flight_date_local
  AND r3.country_pair_itin_nondirectional = L15.country_pair_itin_nondirectional
  AND r3.op_carrier_list_byvalue = L15.op_carrier_list_byvalue
  AND r3.dt_of_issue = L15.dt_of_issue

  LEFT JOIN index.R4_index16 L16
  ON r3.first_flight_date_local = L16.first_flight_date_local
  AND r3.country_pair_itin_nondirectional = L16.country_pair_itin_nondirectional
  AND r3.dt_of_issue = L16.dt_of_issue

  LEFT JOIN index.R4_index17 L17
  ON r3.country_pair_itin_nondirectional = L17.country_pair_itin_nondirectional
  AND r3.dt_of_issue = L17.dt_of_issue

  LEFT JOIN index.R4_index18 L18
  ON r3.region_pair_itin_nondirectional = L18.region_pair_itin_nondirectional
  AND r3.dt_of_issue = L18.dt_of_issue

  LEFT JOIN index.R4_index19 L19
  ON r3.dt_of_issue = L19.dt_of_issue

  WHERE r3.dt_of_issue IS NOT NULL)

SELECT
  0 AS pl_id,
  *,
  -- implement waterfall indexes
  COALESCE(skytra_rrpk,
  rrpk_3, rrpk_4, rrpk_5,
  rrpk_6, rrpk_7, rrpk_8,
  rrpk_9, rrpk_10, rrpk_11,
  rrpk_12, rrpk_13, rrpk_14,
  rrpk_15, rrpk_16, rrpk_17,
  rrpk_18, rrpk_19
  )  AS waterfall_rrpk,
  -- trace waterfall indexes source
  CASE
    WHEN skytra_rrpk IS NOT NULL AND key_type ='classfull' THEN 'Level 01 skytra classful'
    WHEN skytra_rrpk IS NOT NULL THEN 'Level 02 skytra classless'
    WHEN rrpk_3 IS NOT NULL THEN 'Level 03 classfull by hour + carrier + class_of_service'
    WHEN rrpk_4 IS NOT NULL THEN 'Level 04 classfull by 3 hour + carrier + class_of_service'
    WHEN rrpk_5 IS NOT NULL THEN 'Level 05 classfull by 6 hour + carrier + class_of_service'
    WHEN rrpk_6 IS NOT NULL THEN 'Level 06 classfull by 6 hour + class_of_service'
    WHEN rrpk_7 IS NOT NULL THEN 'Level 07 classfull by day + stopover code + class_of_service'
    WHEN rrpk_8 IS NOT NULL THEN 'Level 08 classfull by day + stopover code + cabin class'
    WHEN rrpk_9 IS NOT NULL THEN 'Level 09 classfull by day + stopover code + od_cabin class'
    WHEN rrpk_10 IS NOT NULL THEN 'Level 10 classfull by day + stopover code'
    WHEN rrpk_11 IS NOT NULL THEN 'Level 11 fd + port'
    WHEN rrpk_12 IS NOT NULL THEN 'Level 12 ffd(I) + port'
    WHEN rrpk_13 IS NOT NULL THEN 'Level 13 ffd(I) + od_port'
    WHEN rrpk_14 IS NOT NULL THEN 'Level 14 ffd(I) + country + carrier(I)'
    WHEN rrpk_15 IS NOT NULL THEN 'Level 15 ffd(I) + od_country(I) + carrier(I)'
    WHEN rrpk_16 IS NOT NULL THEN 'Level 16 ffd(I) + od_country(I)'
    WHEN rrpk_17 IS NOT NULL THEN 'Level 17 od_country(I)'
    WHEN rrpk_18 IS NOT NULL THEN 'Level 18 od_region(I)'
    WHEN rrpk_19 IS NOT NULL THEN 'Level 19'
    ELSE 'No match found'
  END AS waterfall_source
FROM rrpk_options
"
REM R5 FinalOutput_2020-07-06_w_2020-07-12_Global.csv 8978050 8978050 5323613 8978050
"""
check number_of_rows = nb_of_tickets

SELECT FILE_SOURCE, COUNT(*) AS n_rows, COUNT(DISTINCT ticket_id) AS
n_tickets,
COUNTIF(skytra_rrpk IS NOT NULL) AS n_matched,
COUNTIF(waterfall_rrpk IS NOT NULL) AS n_matched_waterfall
FROM `skytra-benchmark-rnd.matching.R5`
WHERE dt_of_issue > '1970-01-01'
GROUP BY FILE_SOURCE
ORDER BY FILE_SOURCE DESC
"""

REM 8 R6

bq query --destination_table matching.R6 \
--replace \
--use_legacy_sql=false --allow_large_results \
"
WITH
  leg_revenue AS (
  SELECT
    r5.ticket_id,
    -- date dimensionality associated to the itinerary
    r5.dt_of_issue,
    r5.first_flight_date_utc,
    r5.leadtime,
    -- geographical feature associated to the itinerary
    r5.port_pair_itin_nondirectional AS od_pair,
    r5.country_pair_itin_nondirectional AS country_pair,
    r5.region_pair_itin_nondirectional AS region_pair,
    -- operactiong carrier associated to the leg
    r5.op_carrier_list_byvalue AS ticket_op_carrier,
    r5.mkt_carrier_list_byvalue AS ticket_mkt_carrier,
    -- date dimensionality associated to the leg
    r1.flight_datetime_utc,
    -- geographical feature associated to the leg
    r1.flyFrom_leg,
    r1.flyTo_leg,
    -- operactiong carrier associated to the leg
    r1.operating_carrier AS flight_op_carrier,
    r1.mkt_carrier_code AS flight_mkt_carrier,
    -- Leg rpk and revenue
    r1.dist_km,
    r5.waterfall_rrpk,
    r5.waterfall_source,
    IF(r1.reg_seg_fare = 0,0,ROUND(r5.waterfall_rrpk*r1.dist_km,2)) AS leg_revenue,
    r5.sumP/r5.itin_dist_km AS iata_rrpk,
    r1.reg_seg_fare AS leg_revenue_iata,
    -- Transaction type
    r1.transaction_code,
    r1.od_cabin_class,
    -- FILE source
    r5.FILE_SOURCE,
    -- rank by ticket_id, to take into accout that
    -- the same ticket can be submitted multiple times by IATA
    RANK() OVER(PARTITION BY r5.ticket_id ORDER BY r5.FILE_SOURCE) AS release
  FROM
    `skytra-benchmark-rnd.iata.R1` r1
  INNER JOIN
    `skytra-benchmark-rnd.matching.R5` r5
  ON
    r1.ticket_id = r5.ticket_id
    AND r1.FILE_SOURCE = r5.FILE_SOURCE
  WHERE
    r1.dt_of_issue IS NOT NULL
    AND r5.dt_of_issue IS NOT NULL ),
  leg_revenue_filtered AS (
  SELECT
    0 AS pl_id,
    * EXCEPT(release)
  FROM
    leg_revenue
  WHERE
    release = 1 )
SELECT
  * EXCEPT (predicted_waterfall_rrpk,
    aux_region_pair,
    aux_ticket_op_carrier,leg_revenue, waterfall_source),
  CAST(predicted_waterfall_rrpk AS NUMERIC) AS predicted_waterfall_rrpk,
  CAST(ROUND(predicted_waterfall_rrpk*dist_km,2) AS NUMERIC) AS predicted_leg_revenue,
  IF(leg_revenue is null, CAST(ROUND(predicted_waterfall_rrpk*dist_km,2) AS NUMERIC), leg_revenue) as leg_revenue,
  IF(leg_revenue is null, "modelled", waterfall_source) as waterfall_source
FROM
  ML.PREDICT(MODEL `PD_309.lin_reg_model_yield`,
    (
    SELECT
      *,
      CASE
        WHEN region_pair IS NULL THEN 'Unknown'
        WHEN ARRAY_LENGTH(SPLIT(region_pair,',')) > 1 THEN 'Multiple'
      ELSE
      region_pair
    END
      AS aux_region_pair,
      CASE
        WHEN ticket_op_carrier IS NULL THEN 'Unknown'
        WHEN ARRAY_LENGTH(SPLIT(ticket_op_carrier,',')) > 1 THEN 'Multiple'
      ELSE
      ticket_op_carrier
    END
      AS aux_ticket_op_carrier
    FROM
      leg_revenue_filtered ) )
"
REM R6 5,497,706,461

REM 9.1 R7_flights
bq query --destination_table matching.R7_flights \
--replace \
--use_legacy_sql=false --allow_large_results \
"
WITH
  r6 AS (
  SELECT
    dt_of_issue, region_pair ,
    FORMAT_DATE('%Y',first_flight_date_utc) AS year_delivery,
    FORMAT_DATE('%m',first_flight_date_utc) AS month,
    FORMAT_DATE('%Y-%m',first_flight_date_utc) AS month_delivery,
    CAST(FLOOR((leadtime)/30.) + 1 AS INT64) AS l30,
    flyFrom_leg,
    flyTo_leg,
    IFNULL(a_o.country,
      'Unknown') AS flyFrom_country,
    IFNULL(a_d.country,
      'Unknown') AS flyTo_country,
    CASE
      WHEN a_o.country IS NULL OR a_d.country IS NULL THEN 'Unknown'
      WHEN a_o.country = a_d.country THEN 'Domestic'
    ELSE
    'International'
  END
    AS flight_type,
    IFNULL(a_o.traffic_region,
      'Unknown') AS flyFrom_region,
    IFNULL(a_o.traffic_region,
      'Unknown') AS flyTo_region,
    leg_revenue,
    dist_km,
    flight_op_carrier AS op_carrier,
    transaction_code
  FROM
    matching.R6
  LEFT JOIN
    generic.skytra_airports a_o
  ON
    flyFrom_leg = a_o.iata_code
  LEFT JOIN
    generic.skytra_airports a_d
  ON
    flyTo_leg = a_d.iata_code
  WHERE
    dist_km IS NOT NULL
    AND transaction_code IN ('I',
      'R')),
  r6_cat AS (
  SELECT
    dt_of_issue, region_pair ,
    year_delivery,
    month_delivery,
    month,
    CASE
      WHEN month = '01' THEN 'Q1'
      WHEN month = '02' THEN 'Q1'
      WHEN month = '03' THEN 'Q1'
      WHEN month = '04' THEN 'Q2'
      WHEN month = '05' THEN 'Q2'
      WHEN month = '06' THEN 'Q2'
      WHEN month = '07' THEN 'Q3'
      WHEN month = '08' THEN 'Q3'
      WHEN month = '09' THEN 'Q3'
      WHEN month = '10' THEN 'Q4'
      WHEN month = '11' THEN 'Q4'
      WHEN month = '12' THEN 'Q4'
    ELSE
    'other'
  END
    AS quarter,
    CASE
      WHEN l30 < 0 THEN 't1'
      WHEN l30 > 12 THEN 't12'
    ELSE
    CONCAT('t',CAST(l30 AS STRING))
  END
    AS lead_bucket,
    flyFrom_leg,
    flyTo_leg,
    flyFrom_country,
    flyTo_country,
    flyFrom_region,
    flyTo_region,
    flight_type,
    IFNULL(op_carrier,
      'Unknown') AS op_carrier,
  IF
    (transaction_code ='I',
      dist_km,
      0.) AS rpk_issued,
  IF
    (transaction_code ='R',
      dist_km,
      0.) AS rpk_refund,
  IF
    (transaction_code ='I',
      IFNULL(leg_revenue,
        0.),
      0.) AS revenue_issued,
  IF
    (transaction_code ='R',
      IFNULL(leg_revenue,
        0.),
      0.) AS revenue_refund
  FROM
    r6 )
SELECT
  0 AS pl_id,
  dt_of_issue, region_pair ,
  year_delivery,
  month_delivery,
  quarter,
  month,
  CONCAT(year_delivery,'-',quarter) AS quarter_delivery,
  lead_bucket,
  flyFrom_leg,
  flyTo_leg,
  ANY_VALUE(flyFrom_country) AS flyFrom_country,
  ANY_VALUE(flyTo_country) AS flyTo_country,
  ANY_VALUE(flyFrom_region) AS flyFrom_region,
  ANY_VALUE(flyTo_region) AS flyTo_region,
  ANY_VALUE(flight_type) AS flight_type,
  op_carrier,
  ROUND(SUM(revenue_issued),2) AS revenue,
  ROUND(SUM(rpk_issued),0) AS rpk,
  ROUND((SUM(revenue_issued)-SUM(revenue_refund)),2) AS net_revenue,
  ROUND((SUM(rpk_issued)-SUM(rpk_refund)),0) AS net_rpk
FROM
  r6_cat
GROUP BY
  dt_of_issue,
  year_delivery, region_pair ,
  quarter,
  month_delivery,
  month,
  lead_bucket,
  op_carrier,
  flyFrom_leg,
  flyTo_leg
"
REM 9.1 R7_flights 429,531,527

REM 9.2 R7_itineraries
bq query --destination_table matching.R7_itineraries \
--replace \
--use_legacy_sql=false --allow_large_results \
"
WITH
r6 AS (
  SELECT
    dt_of_issue,
    FORMAT_DATE('%Y',first_flight_date_utc) AS year_delivery,
    FORMAT_DATE('%m',first_flight_date_utc) AS month,
    FORMAT_DATE('%Y-%m',first_flight_date_utc) AS month_delivery,
    CAST(CEILING((leadtime)/30.) AS INT64) AS l30,
    CASE
    WHEN od_pair IS NULL THEN 'Unknown'
    WHEN ARRAY_LENGTH(SPLIT(od_pair,',')) > 1 THEN 'Multiple'
    ELSE od_pair END AS od_pair,
    CASE
    WHEN country_pair IS NULL THEN 'Unknown'
    WHEN ARRAY_LENGTH(SPLIT(country_pair,',')) > 1 THEN 'Multiple'
    ELSE country_pair END AS country_pair,
    CASE
    WHEN region_pair IS NULL THEN 'Unknown'
    WHEN ARRAY_LENGTH(SPLIT(region_pair,',')) > 1 THEN 'Multiple'
    ELSE region_pair END AS region_pair,
    leg_revenue, dist_km, flight_op_carrier AS op_carrier, transaction_code
  FROM matching.R6
  WHERE dist_km IS NOT NULL
  AND transaction_code IN ('I','R') 
),
r6_cat AS (
  SELECT
    dt_of_issue,
    year_delivery,
    month_delivery, month,
    CASE
      WHEN month = '01' THEN 'Q1'
      WHEN month = '02' THEN 'Q1'
      WHEN month = '03' THEN 'Q1'
      WHEN month = '04' THEN 'Q2'
      WHEN month = '05' THEN 'Q2'
      WHEN month = '06' THEN 'Q2'
      WHEN month = '07' THEN 'Q3'
      WHEN month = '08' THEN 'Q3'
      WHEN month = '09' THEN 'Q3'
      WHEN month = '10' THEN 'Q4'
      WHEN month = '11' THEN 'Q4'
      WHEN month = '12' THEN 'Q4'
      ELSE 'other' 
    END AS quarter,
    CASE
      WHEN l30 < 2 THEN '<= 30 days'
      WHEN l30 > 12 THEN '> 360 days'
      ELSE CONCAT(CAST((l30 -1)*30 + 1 AS STRING),'-',CAST((l30)*30 AS STRING), ' days')
    END AS lead_bucket ,
    CASE
    WHEN od_pair NOT IN ('Unknown','Multiple') THEN od_pair
    WHEN country_pair NOT IN ('Unknown','Multiple') THEN CONCAT(od_pair,':',country_pair)
    WHEN region_pair NOT IN ('Unknown','Multiple') THEN CONCAT(od_pair,':',region_pair)
    ELSE od_pair END AS od_pair,
    CASE
    WHEN country_pair IN ('Unknown','Multiple') AND region_pair NOT IN ('Unknown','Multiple') THEN CONCAT(country_pair,':',region_pair)
    ELSE country_pair END AS country_pair,
    region_pair,
    IFNULL(op_carrier,'Unknown') AS op_carrier,
    IF(transaction_code ='I',dist_km,0.) AS rpk_issued,
    IF(transaction_code ='R',dist_km,0.) AS rpk_refund,
    IF(transaction_code ='I',IFNULL(leg_revenue,0.),0.) AS revenue_issued,
    IF(transaction_code ='R',IFNULL(leg_revenue,0.),0.) AS revenue_refund
  FROM r6
)
SELECT
  0 AS pl_id,
  dt_of_issue, year_delivery, month_delivery,quarter, month,  CONCAT(year_delivery,'-',quarter)  as quarter_delivery, lead_bucket,
  od_pair,
  ANY_VALUE(country_pair) AS country_pair, ANY_VALUE(region_pair) AS region_pair,
  op_carrier,
  ROUND(SUM(revenue_issued),2) AS revenue,
  ROUND(SUM(rpk_issued),0) AS rpk,
  ROUND((SUM(revenue_issued)-SUM(revenue_refund)),2) AS net_revenue,
  ROUND((SUM(rpk_issued)-SUM(rpk_refund)),0) AS net_rpk
FROM r6_cat
GROUP BY
  dt_of_issue,year_delivery,quarter,
  month_delivery, month,
  lead_bucket,
  od_pair,
  op_carrier
"
REM R7_itineraries 377,463,817



