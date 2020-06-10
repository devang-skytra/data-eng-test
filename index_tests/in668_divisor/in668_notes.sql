/* 
NOTES  IN-668 

IN-668--design-divisor-mechanism---phase

1) Produce X6 from the pipeline as usual
2) 670 Produce X6_Divisor
3) Indices get produced in X7 that now accounts for the divisors
4) when new data events occur, the “modified X6” sql and the “divisor table” gets updated

given X5b is recent only, will pretend AA case 

occured  01-Jan-2020 (+1 day for 'Europe-North America' to provide proof of solution flexibility)
detected 02-Jan-2020 (+1 day for 'Europe-North America' to provide proof of solution flexibility)

update generic.divisor_exclusions  set start_date_FD = '2020-01-02' where attribute1 in('Europe-North America')

resolved 24-Jan-2020
reintro  14-Apr-2020




*/

/*
SETUP 

--columns should be generalized to be divisor_code and attribute1 for divisor_all

create or replace table generic.divisor_all as ( select 'airline' as divisor_type, 'AA' as iata_code, 'North America-North America' as region_pair, NUMERIC'0.924214' as divisor, DATE'2020-01-01' as start_date, DATE'2099-12-31' as end_date )
insert into generic.divisor_all select divisor_type, iata_code, 'Asia/Pacific-North America' as region_pair, NUMERIC'0.5' as divisor, start_date, end_date from generic.divisor_all
insert into generic.divisor_all select divisor_type, iata_code, 'Europe-North America' as region_pair, NUMERIC'2.0' as divisor, DATE'2020-01-02' as start_date, end_date from generic.divisor_all where region_pair = 'Asia/Pacific-North America'
UPDATE generic.divisor_all SET end_date = NULL WHERE 1=1

create or replace table generic.divisor_generic as ( select divisor_type, iata_code as divisor_code, region_pair as attribute1, '' as attribute2, divisor, start_date, end_date from generic.divisor_all)

create or replace table generic.divisor_exclusions as ( select divisor_type, divisor_code, attribute1, attribute2, 
start_date as start_date_ELT, end_date as end_date_ELT, 
'first_flight_date' date_join_type,
end_date as start_date_DOI, end_date as end_date_DOI,
start_date as start_date_FD, end_date as end_date_FD
from generic.divisor_generic
)    



create or replace table generic.divisor_keys as (
select example as first_flight_date, attribute1 as region_pair, NUMERIC'0.924214' as divisor_value, start_date_ELT, end_date_ELT, 
from generic.divisor_exclusions, UNNEST(GENERATE_DATE_ARRAY('2020-01-01', '2020-01-30', INTERVAL 1 DAY)) AS example
)
*/

create or replace view  matching_v.v_X6_divisor_airline_subset as
-- we UNION each divisor_type in v_X6_divisor_generic_subset but here we use 1 specific divisor_type only



--TAKE THE DIVISOR AS INPUT

--1) left join set exclusions price to NULL


select
x6.* EXCEPT(price), price as price_orig, IF(d.divisor_code IS NULL, NULL, x6.price) as price_adj
from 
`d-dat-digitalaircrafttransport.matching.X6` x6 
left join generic.divisor_exclusions d on 
  x6.op_carrier = d.divisor_code and 
  x6.region_pair = d.attribute1 and 
  CURRENT_DATE between d.start_date_ELT and COALESCE(d.end_date_ELT, '2099-12-31') and
  CASE WHEN date_join_type = 'dt_of_issue' THEN
    x6.dt_of_issue 
  ELSE
    x6.first_flight_date_utc
  END
  between d.start_date_FD and COALESCE(d.end_date_FD, DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) )
where divisor_type = 'airline'
;


create or replace view  matching_v.v_X6_divisor_airport_subset as
-- we UNION each divisor_type in v_X6_divisor_generic_subset but here we use 1 specific divisor_type only
select 0 as fake
/*
x6.*, CAST(x6.price/d.divisor AS NUMERIC) as price_adj
from 
`d-dat-digitalaircrafttransport.matching.X6` x6 
inner join generic.divisor_generic d on 
  x6.theoretical_airport_join = d.divisor_code and 
  --airport divisor not likely to be spliced by attribute1 
  --x6.attribute1 = d.attribute1 and 
  --so instead have a theoretical airport join which is not supported by X6 yet
  CURRENT_DATE between d.start_date and COALESCE(d.end_date, '2099-12-31') and
  --not sure filter below is right but can be offset with date functions
  x6.dt_of_issue between d.start_date and COALESCE(d.end_date, DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) )
where divisor_type = 'airport'
*/
;


create or replace view  matching_v.v_X6_divisor_generic_subset as
select
x6.*, CAST(x6.price/d.divisor AS NUMERIC) as price_adj
from 
`d-dat-digitalaircrafttransport.matching.X6` x6 
inner join generic.divisor_generic d on 
  x6.op_carrier = d.divisor_code and 
  x6.attribute1 = d.attribute1 and 
  CURRENT_DATE between d.start_date and COALESCE(d.end_date, '2099-12-31') and
  --not sure filter below is right but can be offset with date functions
  x6.dt_of_issue between d.start_date and COALESCE(d.end_date, DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) )
where divisor_type = 'airline'

--it is possible airline, airport issues intersect so de-duplicate using UNION DIST
/*
UNION DISTINCT

select
x6.*, CAST(x6.price/d.divisor AS NUMERIC) as price_adj
from 
`d-dat-digitalaircrafttransport.matching.X6` x6 
inner join generic.divisor_generic d on 
  x6.theoretical_airport_join = d.divisor_code and 
  --airport divisor not likely to be spliced by attribute1 
  --x6.attribute1 = d.attribute1 and 
  --so instead have a theoretical airport join which is not supported by X6 yet
  CURRENT_DATE between d.start_date and COALESCE(d.end_date, '2099-12-31') and
  --not sure filter below is right but can be offset with date functions
  x6.dt_of_issue between d.start_date and COALESCE(d.end_date, DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) )
where divisor_type = 'airport'
*/
;


create or replace view  matching_v.v_X6_combined as
--to combine and get X6_Divisor simply substitute in divisor rows where they exist
-- ie initially exclude such rows from X6 and UNION in such rows in second ResultSet
select
x6.*, CAST(x6.price as FLOAT64) as price_adj
from 
matching.X6 
left outer join matching_v.v_X6_divisor_generic_subset x6d
 on 
  x6.op_carrier = x6d.op_carrier and 
  x6.region_pair = x6d.region_pair and 
  --theoretical airport join which is not supported by X6 yet
  x6.dt_of_issue = x6d.dt_of_issue
where x6d.op_carrier is null
/*
looks like this is valid now

select
x6.*, CAST(x6.price as FLOAT64) as price_adj
from 
matching.X6 
except distinct select * from matching_v.v_X6_divisor_generic_subset
*/

UNION ALL

select * from matching_v.v_X6_divisor_generic_subset
;


--=================================================================================================


24 Jan-2018
•Compute the benchmark for the day before with AA & Without AA
•Calculate divisor> 0.924214
•Eliminate all AA in X6 and compute index
•Divide value by divisor

12 Jan-2019
•Acknowledge that we now have AA
•Start producing index with AA (wait 90 days)

14 Apr 2019
•Compute benchmark for day before with AA and without AA (+ divisor)
•Update divisor > 0.996935
•Produce index WITH AA and divide by new divisor0.152278



--select max(dt_of_issue) from matching.X6 where dt_of_issue > '2020-04-01' -- DevTest 2020-05-06
--update generic.divisor_exclusions set start_date_FD = '2020-01-01', end_date_FD = '2020-01-02' where 1=1 



-- x6CountTestCaseConfirm as ( 
select 
x6.region_pair,
count(*) as rcAll, 
countif(
  ( x6.op_carrier = 'AA' and x6.region_pair in('North America-North America','Asia/Pacific-North America') and x6.first_flight_date_utc between '2020-01-01' and '2020-01-02' )
  OR
  ( x6.op_carrier = 'AA' and x6.region_pair in('Europe-North America') and x6.first_flight_date_utc between '2020-01-02' and '2020-01-02' )
  ) as rcExclusions,
sum(price) as priceAll, 
sum( if( 
    ( x6.op_carrier = 'AA' and x6.region_pair in('North America-North America','Asia/Pacific-North America') and x6.first_flight_date_utc between '2020-01-01' and '2020-01-02' )
  OR
  ( x6.op_carrier = 'AA' and x6.region_pair in('Europe-North America') and x6.first_flight_date_utc between '2020-01-02' and '2020-01-02' )
, price, 0 ) ) as priceExclusions,
--x6.op_carrier, x6.region_pair, x6.dt_of_issue, x6.first_flight_date_utc 
from matching.X6 
where x6.dt_of_issue between '2019-12-01' and '2019-12-31' --this is the only filter not in generic.divisor_exclusions and will just makes the test quicker and cheaper
group by rollup(1)
order by 1 --this is the only filter not in generic.divisor_exclusions and will just makes the test quicker and cheaper




select
x6.region_pair,
COUNT(*) as rcAll, 
COUNTIF(d.divisor_code IS NOT NULL) as rcExclusions,
SUM(x6.price) as priceAll, 
SUM( IF( d.divisor_code IS NOT NULL, x6.price, 0 ) ) as priceExclusions,
SUM ( IF(d.divisor_code IS NULL, x6.price, 0 ) ) as price_adj
from 
--`d-dat-digitalaircrafttransport.matching.X6` 
matching.X6 
x6 
left join generic.divisor_exclusions d on 
  x6.op_carrier = d.divisor_code and 
  x6.region_pair = d.attribute1 and 
  CURRENT_DATE between d.start_date_ELT and COALESCE(d.end_date_ELT, '2099-12-31') and
  CASE date_join_type 
    WHEN 'dt_of_issue' THEN x6.dt_of_issue between d.start_date_DOI and COALESCE(d.end_date_DOI, DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) ) 
    WHEN 'first_flight_date' THEN x6.first_flight_date_utc between d.start_date_FD and COALESCE(d.end_date_FD, DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) )
    ELSE 1 = 1
  END and
  d.divisor_type = 'airline'
where 
x6.dt_of_issue between '2019-12-01' and '2019-12-31'
group by rollup(1)
order by 1


  SELECT
--it is not possible to pass airflow XCOM variables as a parameter as we do for standard python variables
-- therefore have to take more direct task_instance-level approach (slightly inferior/less abstraction)
  {{ ti.xcom_pull('Get-TsX7')[0] }} AS pl_id,
  nlegs.region_pair,  nlegs.first_flight_date_utc AS first_flight_date,
  CAST( ( SUM(iata_rpk*iata_index)/SUM(iata_rpk) ) as NUMERIC) AS iata_index,
  
  CAST( (  ( SUM(w_leg*skytra_index)/SUM(w_leg) ) / COALESCE(d.divisor_value,1) ) as NUMERIC) AS skytra_index,
  
  CAST( SUM(iata_rpk) as NUMERIC) AS iata_rpk,
  CAST( SUM(skytra_rpk) as NUMERIC) AS skytra_rpk,
  SUM(iata_tickets) AS iata_tickets,
  SUM(skytra_tickets) AS skytra_tickets,
  CAST( ( 100.*SUM(skytra_tickets)/SUM(iata_tickets) ) as NUMERIC)  AS skytra_coverage
  --, '' as metric_code, CAST(0.0 as NUMERIC) as metric_value
FROM (
  SELECT * FROM index_nleg
  UNION ALL
  SELECT * FROM windex_nleg
  UNION ALL
  SELECT * FROM sindex_nleg
) nlegs
left join generic.divisor_keys d on nlegs.first_flight_date_utc = d.first_flight_date and nlegs.region_pair = d.region_pair
GROUP BY region_pair, first_flight_date_utc

