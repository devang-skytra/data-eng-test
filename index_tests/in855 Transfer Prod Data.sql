
--https://skytra.atlassian.net/browse/IN-855

--870 
--bq cp data_eng.in820_X1_MISSING iata.X1_2020_late_arriving_tickets
--Description - This table is a special extract by IATA to provide missing tickets, need time to analyse hence copying into iata. so available in PROD
--drop table data_eng.in820_X1_MISSING


--860 START
--==============================================================================================
--shuffle limit error
--insert into kiwi.X5b select NULL as pl_id, * EXCEPT(af_load_ts) from kiwi_PROD.X5b_2019

--can bq cp partition however have 1 different column...

bq cp -a -n 'd-dat-digitalaircrafttransport:kiwi_PROD.X5b_2019$20190101'	kiwi.X5b

/*
CAREFUL TESTING NEEDED
bq cp 'd-dat-digitalaircrafttransport:kiwi.X5b$20200317'	data_eng.X5b_cp_test

bq query --allow_large_results --append_table --use_legacy_sql=false --destination_table data_eng.X5b_cp_test "select NULL as pl_id, * EXCEPT(af_load_ts) FROM kiwi_PROD.X5b_2019 WHERE search_date = '2019-09-01'"
100 secs per day vs BETWEEN 4 days = 344 secs


bq query --allow_large_results --append_table --use_legacy_sql=false --destination_table kiwi.X5b "select NULL as pl_id, * EXCEPT(af_load_ts) FROM kiwi_PROD.X5b_2019 WHERE search_date between '2019-09-01' AND '2019-09-10'"

bq query --allow_large_results --append_table --use_legacy_sql=false --destination_table kiwi.X5b "select NULL as pl_id, * EXCEPT(af_load_ts) FROM kiwi_PROD.X5b_2019 WHERE search_date between '2019-09-11' AND '2019-09-20'"

bq query --allow_large_results --append_table --use_legacy_sql=false --destination_table kiwi.X5b "select NULL as pl_id, * EXCEPT(af_load_ts) FROM kiwi_PROD.X5b_2019 WHERE search_date between '2019-09-21' AND '2019-09-30'"

bq query --allow_large_results --append_table --use_legacy_sql=false --destination_table kiwi.X5b "select NULL as pl_id, * EXCEPT(af_load_ts) FROM kiwi_PROD.X5b_2019 WHERE search_date between '2019-10-01' AND '2019-10-10'"

bq query --allow_large_results --append_table --use_legacy_sql=false --destination_table kiwi.X5b "select NULL as pl_id, * EXCEPT(af_load_ts) FROM kiwi_PROD.X5b_2019 WHERE search_date between '2019-10-11' AND '2019-10-20'"

bq query --allow_large_results --append_table --use_legacy_sql=false --destination_table kiwi.X5b "select NULL as pl_id, * EXCEPT(af_load_ts) FROM kiwi_PROD.X5b_2019 WHERE search_date between '2019-10-21' AND '2019-10-31'"

bq query --allow_large_results --append_table --use_legacy_sql=false --destination_table kiwi.X5b "select NULL as pl_id, * EXCEPT(af_load_ts) FROM kiwi_PROD.X5b_2019 WHERE search_date between '2019-11-01' AND '2019-11-10'"

bq query --allow_large_results --append_table --use_legacy_sql=false --destination_table kiwi.X5b "select NULL as pl_id, * EXCEPT(af_load_ts) FROM kiwi_PROD.X5b_2019 WHERE search_date between '2019-11-11' AND '2019-11-20'"

bq query --allow_large_results --append_table --use_legacy_sql=false --destination_table kiwi.X5b "select NULL as pl_id, * EXCEPT(af_load_ts) FROM kiwi_PROD.X5b_2019 WHERE search_date between '2019-11-21' AND '2019-11-30'"

bq query --allow_large_results --append_table --use_legacy_sql=false --destination_table kiwi.X5b "select NULL as pl_id, * EXCEPT(af_load_ts) FROM kiwi_PROD.X5b_2019 WHERE search_date between '2019-12-01' AND '2019-12-10'"


bq query --allow_large_results --append_table --use_legacy_sql=false --destination_table kiwi.X5b "select NULL as pl_id, * EXCEPT(af_load_ts) FROM kiwi_PROD.X5b_2019 WHERE search_date between '2019-12-11' AND '2019-12-20'"

bq query --allow_large_results --append_table --use_legacy_sql=false --destination_table kiwi.X5b "select NULL as pl_id, * EXCEPT(af_load_ts) FROM kiwi_PROD.X5b_2019 WHERE search_date between '2019-12-21' AND '2019-12-31'"

*/

--Prior 2020 to 20200317 = 548,347,505,079
--Prior 2019 fr 20190901 = 688,519,656,714
-- = 1,236,867,161,793
--Confirmed post Merge ? = YES


drop table data_eng.X5b_cp_test
--860 END
--==============================================================================================

--861 START
--==============================================================================================
select * from
(SELECT FORMAT_DATE('%Y%m', search_date) as Xdate, count(*) as Xcount FROM kiwi.X5b WHERE search_date < "2021-01-01" group by 1) X
full outer join
(SELECT FORMAT_DATE('%Y%m', search_date) as X2019date, count(*) as X2019count FROM kiwi_PROD.X5b_2019 WHERE search_date < "2020-01-01" group by 1) X2019
on X.Xdate = X2019.X2019date

Xdate	Xcount	X2019date	X2019count	

201909
157676394745
201909
157676394745

201910
163289110572
201910
163289110572

201911
178394603951
201911
178394603951

201912
189159547446
201912
189159547446

202001
242867220556
null
null

202002
205982011000
null
null

202003
99498273523
null
null


--861 END
--==============================================================================================

--874
--222 days protects 1/9/2019 until 10/4/2020
--bq update --time_partitioning_expiration 19180800 data_eng.X5b_cp_test
--bq update --time_partitioning_expiration 19180800 kiwi.X5b


--862
SELECT 'iata.X3' as tb, min(dt_of_issue) as doi_min, max(dt_of_issue) as doi_max, count(*) as Xcount FROM iata.X3 WHERE dt_of_issue > "2000-01-01"
UNION ALL
SELECT 'iata.I1' as tb, min(dt_of_issue) as doi_min, max(dt_of_issue) as doi_max, count(*) as Xcount FROM iata.I1 WHERE dt_of_issue > "2000-01-01"
UNION ALL
SELECT 'iata.I2' as tb, min(dt_of_issue) as doi_min, max(dt_of_issue) as doi_max, count(*) as Xcount FROM iata.I2 WHERE dt_of_issue > "2000-01-01"
UNION ALL
SELECT 'iata.I3' as tb, min(dt_of_issue) as doi_min, max(dt_of_issue) as doi_max, count(*) as Xcount FROM iata.I3 WHERE dt_of_issue > "2000-01-01"
order by 1

tb	doi_min	doi_max	Xcount	

iata.I1
2013-01-01
2020-03-22
11,416,993,233

iata.I2
2013-01-01
2020-03-22
6,236,089,554

iata.I3
2013-01-01
2020-03-22
25,746,945,386

iata.X3
2013-01-01
2020-03-22
16,455,576,612

--863
SELECT 'matching.X6' as tb, min(dt_of_issue) as doi_min, max(dt_of_issue) as doi_max, count(*) as Xcount FROM matching.X6 WHERE dt_of_issue > "2000-01-01"

tb	doi_min	doi_max	Xcount	

matching.X6
2017-10-19
2020-02-29
3,254,855,146

--872
SELECT min(first_flight_date) as ffd_min, max(first_flight_date) as ffd_max, count(*) as Xcount FROM index.X7

ffd_min	ffd_max	Xcount	
2017-11-20
2020-03-03
23,380

--868

--Visually confirmed 1,236,867,161,793 in PROD ? = YES

--check one month against Migrated = YES (see below)
SELECT FORMAT_DATE('%Y%m', search_date) as Xdate, count(*) as Xcount FROM kiwi.X5b 
WHERE search_date between "2020-02-01" and "2020-02-29" group by 1

Xdate	Xcount	

202002
205,982,011,000
205,982,011,000


--864,869,876
SELECT CONCAT('bq rm -f -t ',table_schema,'.',table_name) 
FROM 
--kiwi_PROD
kiwi
--KIWI_full_process
.INFORMATION_SCHEMA.TABLES 
WHERE table_name not in('') 



