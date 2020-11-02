

--bq show --schema --format=prettyjson kiwi_PROD.X4_ARRAY > ./kiwi.X4_ARRAY.json
--bq mk --table --time_partitioning_field search_date --schema ./kiwi.X4_ARRAY.json kiwi_PROD.X4_ARRAY

#LegacySQL
SELECT substring(partition_id,1,4) as myYear, min(partition_id) as minPtn, max(partition_id) as maxPtn, COUNT(*) AS rc FROM [kiwi.X5b$__PARTITIONS_SUMMARY__] 
WHERE partition_id <> '__NULL__'
GROUP BY 1


#LegacySQL
SELECT MONTH(last_modified_timestamp) as MonthRan, DAY(last_modified_timestamp) as DayRan, min(partition_id) as minPtn, max(partition_id) as maxPtn, COUNT(*) AS rc FROM [kiwi.X5b$__PARTITIONS_SUMMARY__] GROUP BY 1,2 ORDER BY 3


-- -f skips confirmation bq rm -f -t 
-- HOWEVER brief experience suggests delete does not work without confirmation
-- AND SOME SUGGEST that '' is essential to remove partition only

/*
bq rm -f -t 'd-dat-digitalaircrafttransport:kiwi_PROD.X5a_2019$20190305'
bq rm -f -t 'd-dat-digitalaircrafttransport:kiwi_PROD.X5a_2019$20190306'

bq rm -f -t 'd-dat-digitalaircrafttransport:kiwi_PROD.X4_2019$20190301'
bq rm -f -t 'd-dat-digitalaircrafttransport:kiwi_PROD.X4_2019$20190302'
*/



--https://medium.com/@dhafnar/how-to-instantly-recover-a-table-in-google-bigquery-544a9b7e7a8d
----https://codechi.com/dev-tools/date-to-millisecond-calculators/

-------------------------1579525260000 is 2020-01-20 13:01:00.000000 UTC 
--bq cp kiwi_TEST.X4_2019@1579525260000 kiwi_EMERG_RESTORE.X4_test
--drop table kiwi_EMERG_RESTORE.X4_test


CREATE OR REPLACE TABLE kiwi_EMERG_RESTORE.X4_20190321
PARTITION BY search_date  
OPTIONS (require_partition_filter = TRUE) 
AS
SELECT
*
FROM
kiwi_PROD.X4_2019 FOR SYSTEM_TIME AS OF TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 2 DAY)
WHERE
search_date = '2019-03-21' --14 min 38 sec elapsed, 8.3 TB processed
between '2019-03-08' and '2019-03-21'

--select * from log.load where ds = 'kiwi_TEST' and tb = 'X4_2019' --2020-01-16 2019-02-01

--approx 90TB expected, duration = ?
restored search_date between '2019-03-08' and '2019-03-21' as kiwi_EMERG_RESTORE.X4_201903_part 