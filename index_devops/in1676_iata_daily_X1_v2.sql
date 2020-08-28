
https://skytra.atlassian.net/browse/IN-1676

		Stage 1
		--------

		DONE test that can differentiate '%20200717%20200717%' and '%20200717%20200718%' using 
				d-dat-digitalaircrafttransport:iata.ext_data_gz so can retain both without renaming

		DONE created iata.X1_v2 table

		DONE use gsutil to trigger reload of 40 files
			-- SEE 'IATA API multi-day caller.xlsx' which automates trigger *****************************************
			

		DONE run manual query(s) to load  40 files ONLY into iata.X1_v2 table


		Stage 2
		--------
		Assess ticket/segment/overall alignment and operating_carrier
			-- based on 'Iata Daily vs Weekly Analysis Updated for we 20200621'.xlsx ************************************


			WITH 
			tickets_daily_new AS (
			SELECT CAST(file_date_int as STRING) as src, ticket_id, segment_id, ANY_VALUE(PARSE_DATE('%Y-%m-%d',dt_of_issue)) AS dt_of_issue
			  FROM `d-dat-digitalaircrafttransport.iata.X1_v2`
			  WHERE file_date_int between 20200701 and 20200809
			  --AND ticket_id IS NOT NULL
			  GROUP BY src, ticket_id, segment_id
			),
			tickets_daily AS (
			  SELECT CAST(file_date_int as STRING) as src, ticket_id, segment_id, ANY_VALUE(PARSE_DATE('%Y-%m-%d',dt_of_issue)) AS dt_of_issue
			  FROM `d-dat-digitalaircrafttransport.iata.X1`
			  WHERE file_date_int between 20200701 and 20200809
			  --AND ticket_id IS NOT NULL
			  GROUP BY src, ticket_id, segment_id
			)
			SELECT 
			  w_src, d_src,
			  dt_of_issue,
			  COUNT(*) AS total,
			  COUNTIF(both) AS matching_tickets,
			  COUNTIF(missing_weekly) AS missing_weekly,
			  COUNTIF(missing_daily) AS missing_daily
			FROM (
			  SELECT 
			   tdn.src as w_src, td.src as d_src,
			   IFNULL(tdn.dt_of_issue, td.dt_of_issue) AS dt_of_issue,
				tdn.ticket_id IS NOT NULL AND td.ticket_id IS NOT NULL AS both,
				tdn.ticket_id IS NULL AS missing_weekly,
				td.ticket_id IS NULL AS missing_daily
			  FROM tickets_daily_new tdn
			  FULL OUTER JOIN tickets_daily td
			  ON tdn.ticket_id = td.ticket_id and tdn.segment_id = td.segment_id
			)
			GROUP BY w_src, d_src, dt_of_issue
			ORDER BY w_src, d_src, dt_of_issue


		Stage 3 Option A (wrong I think)
		--------
		use bq cp to replace relevant 40 partitions of iata.X1 with iata.X1_v2
		do Stage 3 Option B without the X1 step somehow (??)

		Stage 3 Option B (long method)
		--------
		check appropriateness of dag_iata_daily_v2_0 vs dag_iata_daily_v2_1
		check appropriateness of backfill [2020-07-01 - 2020-07-19] starting from very start - dagStartPy task
		check appropriateness of re-run [2020-07-20 - 2020-08-09] starting from very start - dagStartPy task


		Stage 3 Option C (short method)
		--------
		if ticket/segment/overall alignment, INNER JOIN iata.X1 and iata.X1_v2 and update iata.X1 with iata.X1_v2.operating_carrier

		Stage 4
		--------
		redo matching for X6 ??


		Stage 5
		--------
		Potentially archive out/delete 40 x OLD version files into separate bucket to avoid re-load problems


		--------
		redo matching for X6 ??


bq cp iata.X1$20200101 iata.X1_v2


-- STD VERSION	********************************************************************
DECLARE iStr STRING;
DECLARE flt STRING;

DECLARE i INT64 DEFAULT 9;
WHILE i <= 10 DO
BEGIN

	SET iStr = RIGHT( CONCAT('0', CAST(i as STRING))  , 2);
	SET flt = CONCAT('%202007', iStr, '_2020081911%');
	
  INSERT INTO iata.X1_v2
  SELECT 
  *
  , CAST( SUBSTR(_FILE_NAME, LENGTH(_FILE_NAME) -29, 8) AS INT64) as file_date_int 
  FROM iata.ext_data_gz 
  WHERE _FILE_NAME like flt;
  
EXCEPTION WHEN ERROR THEN
  SET i = i + 1; 
  CONTINUE;

END;
SET i = i + 1; 
END WHILE;



SELECT file_date_int, count(*) as rc
FROM iata.X1_v2
WHERE file_date_int >= 20200701
GROUP BY 1
ORDER BY 1


/*
ERRORS

0709-10
0716	
0723-25
0728-30

0801
0805-06
0808

13/40

SELECT 0

*/


-- VERSION FOR PROBLEMATIC FILES	********************************************************************


/*
SELECT CONCAT('CAST(', column_name, ' AS STRING) as ', column_name) FROM iata.INFORMATION_SCHEMA.COLUMNS  WHERE table_name in('X1_v2_load_issue_20200709')
data_type
*/

with 
t1 as (
SELECT column_name as c1 FROM iata.INFORMATION_SCHEMA.COLUMNS  WHERE table_name in('X1_v2')
),

t2 as (
SELECT column_name as c2 FROM iata.INFORMATION_SCHEMA.COLUMNS  WHERE table_name in('X1_v2_load_issue_20200709')
)

select * from t1 full outer join t2 on c1 = c2
where c1 is null or c2 is null


/*
create table iata.X1_v2_load_issues as (select * from iata.X1_v2_load_issue limit 0)
create table iata.X1_v2_load_issue as (select *, NULL as file_date_int from iata.X1_v2_load_issues limit 0)
create table iata.X1_v2_load_issue0 as (select * EXCEPT (file_date_int) from iata.X1_v2_load_issue limit 0)
*/

-- SEE IATA API multi-day caller.xlsx which automates **********************************************************

	bq load
	bq query etc



INSERT INTO iata.X1_v2
SELECT 
CAST(TICKET_ID AS STRING) as TICKET_ID	,
CAST(TICKETING_CARRIER AS STRING) as TICKETING_CARRIER	,
CAST(TRANSACTION_CODE AS STRING) as TRANSACTION_CODE	,
CAST(DT_OF_ISSUE AS STRING) as DT_OF_ISSUE	,
CAST(CONJUNCTION_COMPANION AS STRING) as CONJUNCTION_COMPANION	,
CAST(E_TICKET_IND AS STRING) as E_TICKET_IND	,
CAST(REG_SEG_FARE AS STRING) as REG_SEG_FARE	,
CAST(REG_FULL_FARE AS STRING) as REG_FULL_FARE	,
CAST(CLASS_OF_SERVICE AS STRING) as CLASS_OF_SERVICE	,
CAST(CABIN_CLASS AS STRING) as CABIN_CLASS	,
CAST(OD_CABIN_CLASS AS STRING) as OD_CABIN_CLASS	,
CAST(SIGN_AMT AS STRING) as SIGN_AMT	,
CAST(OLD_TICKET_ID AS STRING) as OLD_TICKET_ID	,
CAST(EXCHANGE_DOC_NBR AS STRING) as EXCHANGE_DOC_NBR	,
CAST(COUNTRY_CODE AS STRING) as COUNTRY_CODE	,
CAST(SEGMENT_ID AS STRING) as SEGMENT_ID	,
CAST(TOT_COUPN2 AS STRING) as TOT_COUPN2	,
CAST(COUPON_NUMBER AS STRING) as COUPON_NUMBER	,
CAST(ORIGIN_AIRPORT_CITY_CODE AS STRING) as ORIGIN_AIRPORT_CITY_CODE	,
CAST(DESTINATION_AIRPORT_CITY_CODE AS STRING) as DESTINATION_AIRPORT_CITY_CODE	,
CAST(STOPOVER_CODE AS STRING) as STOPOVER_CODE	,
CAST(FLIGHT_DATE AS STRING) as FLIGHT_DATE	,
CAST(FLIGHT_DEPART_TIME AS STRING) as FLIGHT_DEPART_TIME	,
CAST(FLIGHT_ARRIVAL_DATE AS STRING) as FLIGHT_ARRIVAL_DATE	,
CAST(FLIGHT_ARRIVAL_TIME AS STRING) as FLIGHT_ARRIVAL_TIME	,
CAST(MKT_CARRIER_CODE AS STRING) as MKT_CARRIER_CODE	,
CAST(MKT_CARRIER_FLT_NBR AS STRING) as MKT_CARRIER_FLT_NBR	,
CAST(ORIGINAL_CURR_CODE AS STRING) as ORIGINAL_CURR_CODE	,
CAST(CARRIER_TYPE AS STRING) as CARRIER_TYPE	,
CAST(FIRST_CLASS_SEAT_CNT AS STRING) as FIRST_CLASS_SEAT_CNT	,
CAST(BUSINESS_CLASS_SEAT_CNT AS STRING) as BUSINESS_CLASS_SEAT_CNT	,
CAST(ECONOMY_CLASS_SEAT_CNT AS STRING) as ECONOMY_CLASS_SEAT_CNT	,
CAST(OPERATING_CARRIER AS STRING) as OPERATING_CARRIER	,
CAST(TRUE_ORIGIN AS STRING) as TRUE_ORIGIN	,
CAST(BASE_FARE AS STRING) as BASE_FARE	,
CAST(FARE_TYPE_INDICATOR AS STRING) as FARE_TYPE_INDICATOR	,
CAST(SEGMENT_MILE AS STRING) as SEGMENT_MILE	,
CAST(OD_MILE AS STRING) as OD_MILE	,
CAST(DISTRIBUTION_CHANNEL AS STRING) as DISTRIBUTION_CHANNEL	,
CAST(SOURCE_CODE AS STRING) as SOURCE_CODE	,
CAST(TICKET_DOCUMENT_AMOUNT AS STRING) as TICKET_DOCUMENT_AMOUNT	,
CAST(DOC_AMT_TYPE_INDICATOR AS STRING) as DOC_AMOUNT_TYPE_INDICATOR	,
file_date_int as file_date_int 
FROM iata.X1_v2_load_issue

