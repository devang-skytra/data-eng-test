

gs://ext-kiwi-excl-data/data/2019/01/01/01/*.gz.parquet

bq mk --table --location=europe-west2 --schema ./kiwi.X4.json kiwi_TEST.X4_2019_noEUclustEtc



-- select * from kiwi_TEST.__TABLES__

-- select search_params.flyFrom_type from kiwi_TEST.test_pq_load

/*
select *, _FILE_NAME AS src from kiwi_PROD.STATS_2019 
where 
--string_field_0 = 'validAirbusItinerariesAcc' AND 
_FILE_NAME = 'gs://ext-kiwi-excl-stat/stats/2019/01/01/01/part-00000-8cc60023-1fb4-48b5-a738-fb252d0df452-c000.csv'
*/

-- select * from kiwi_TEST.__TABLES__

-- select search_params.flyFrom_type from kiwi_TEST.test_pq_load

select 
string_field_0, int64_field_1, _FILE_NAME AS src 
from kiwi_PROD.STATS_2019 
where 
string_field_0 = 'validAirbusItinerariesAcc' AND 
_FILE_NAME like 'gs://ext-kiwi-excl-stat/stats/2019/01/01/%.csv'
order by 3


select 
cast( round(int64_field_1, -6) as STRING) AS bucketing
, _FILE_NAME AS src from kiwi_PROD.STATS_2019 
where 
string_field_0 = 'validAirbusItinerariesAcc' AND 
_FILE_NAME like 'gs://ext-kiwi-excl-stat/stats/2019/01/01/%.csv'


with a as (
select 
string_field_0, 
int64_field_1,
_FILE_NAME AS src 
from kiwi_PROD.STATS_2019 
where 
string_field_0 in('parsedKiwiItinerariesAcc', 'validAirbusItinerariesAcc')
),
d as (select * from a where string_field_0 = 'parsedKiwiItinerariesAcc'),
n as (select * from a where string_field_0 = 'validAirbusItinerariesAcc')
select n.*, n.int64_field_1/d.int64_field_1 as pctRetained
from d full outer join n on d.src = n.src

select 
string_field_0, 
--select 24 * 31 --744
count(*), 
sum(case when int64_field_1 = 0 then 1 else 0 end) as ZeroCount --0, confirmed independently below
--_FILE_NAME AS src 
from kiwi_PROD.STATS_2019 
where 
--string_field_0 = 'validAirbusItinerariesAcc' AND --744
string_field_0 = 'parsedKiwiItinerariesAcc' AND    --744
_FILE_NAME like 'gs://ext-kiwi-excl-stat/stats/2019/01/%.csv'
group by string_field_0
--order by 3


select 
string_field_0, 
int64_field_1,
_FILE_NAME AS src 
from kiwi_PROD.STATS_2019 
where 
string_field_0 in('parsedKiwiItinerariesAcc', 'validAirbusItinerariesAcc')
--string_field_0 in('ZstdSerializationError', 'FileSplittingError')
and _FILE_NAME like 'gs://ext-kiwi-excl-stat/stats/2019/01/%.csv'
order by 2 -- no non-zero
 

select * from log.load 
where 
_PARTITIONDATE = '2020-01-16'
and ds = 'kiwi_PROD'
and tb = 'X5b_2019'
order by 1


select 
af_load_ts,
search_date,  
count(*)
--btid           
from kiwi_PROD.X4_2019 
where search_date >= '2019-01-03'
group by 
af_load_ts, 
search_date
--2019-01-02 33,156,814,289
--2019-01-03 32,198,745,603


select 
af_load_ts,
search_date,  
count(*)         
from kiwi_PROD.X5a_2019 
where search_date >= '2018-01-01'
group by 
af_load_ts, 
search_date
--2019-01-02 24,144,415,780

select 
af_load_ts,
search_date,  
count(*)         
from kiwi_PROD.X5b_2019 
where search_date >= '2018-01-01'
group by 
af_load_ts, 
search_date
--2019-01-02  3,908,250,094
 
 