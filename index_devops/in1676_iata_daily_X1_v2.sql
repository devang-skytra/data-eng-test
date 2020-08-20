
https://skytra.atlassian.net/browse/IN-1676


bq cp iata.X1$20200101 iata.X1_v2


select 
#*, CAST( SUBSTR(_FILE_NAME, LENGTH(_FILE_NAME) -29, 8) AS INT64) as file_date_int 
distinct CAST( SUBSTR(_FILE_NAME, LENGTH(_FILE_NAME) -29, 8) AS INT64) as file_date_int 
from iata.ext_data_gz 
where _FILE_NAME like '%2020%2020081911%'


Stage 1
--------

DONE test that can differentiate '%20200717%20200717%' and '%20200717%20200718%' using 
		d-dat-digitalaircrafttransport:iata.ext_data_gz so can retain both without renaming

DONE created iata.X1_v2 table

	use gsutil to trigger reload of 40 files
DONE echo 'new data' | gsutil cp - gs://ext-iata-trig/prod-20200701-data.txt && sleep 2m
REST 39 NOT DONE 


run manual query(s) to load  40 files ONLY into iata.X1_v2 table

Stage 2
--------
Assess ticket/segment/overall alignment and operating_carrier


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