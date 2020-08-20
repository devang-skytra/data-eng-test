-- create table kiwi_AirlineExclTest.AirlineExcl (iata_code STRING, divisor float, start_date DATE, end_date DATE)

-- insert into kiwi_AirlineExclTest.AirlineExcl values( 'AA', 0.9, '2018-01-24', NULL )

--MODIFY X6.sql like below but with any required sophisticated join syntax on operating_carrier_list expression
--insert into X6
select
x.*,
case when ae.iata_code is null then price else price / ae.divisor end as price_div,
case when ae.iata_code is null then price else null end as price_ae
--, divisor syntax 
FROM 
--REPLACE x with Proper X5b join Logic in X6.sql
( SELECT * FROM `d-dat-digitalaircrafttransport.matching.X6` WHERE dt_of_issue between '2019-12-21' and '2019-12-31' and region_pair like 'North%' ) x
left join ( select * from kiwi_AirlineExclTest.AirlineExcl where CURRENT_DATE() between start_date and coalesce(end_date, '2099-12-31') ) ae on x.op_carrier = ae.iata_code --operating_carrier_list


select op_carrier, operating_carrier_list, price, price_ae 
from kiwi_AirlineExclTest.X6_AE 
where price is not null and price_ae is null

--Not stated, but obviously X7 index and X8 benchmark, can choose from price, price_div, price_ae as needed, again joining to kiwi_AirlineExclTest.AirlineExcl Dim if conditional logic needed
--
can back apply price_div or price_ae as required with conditional logic 
case when ffd_utc between DATE_SUB ( CURRENT_DATE(), INTERVAL 60 DAY ) and DATE_SUB ( CURRENT_DATE(), INTERVAL 1 DAY ) then else end

--may also need a lag olap function to back apply price_div or price_ae as required
 LAG(name) OVER (PARTITION BY division ORDER BY ORDER BY z ROWS BETWEEN -60 PRECEDING AND -1 FOLLOWING ASC) AS 
 
 
 
 
 
IN-670 -> IF(mkt_carrier like "%AA%" OR op_carrier like "%AA%" AND first_flight_date_utc > "2018-01-23" AND first_flight_date_utc < "2019-04-14" AND region_pair = "North America-North America", NULL, n_pkg) as n_pkg,
becomes

----------------------------------------

/*
Do we only need to append today or virtual modify X6 transactions backward?
*/


SET dt = ( SELECT DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY) );


CREATE OR REPLACE TEMP TABLE x6_div_airline as
select * 
from 
matching.X6_divisor x6d
inner join (select region_pair as rp, MIN(min_leadtime) AS min_lt, MAX(max_leadtime) AS max_lt
            from generic.spot_window_regions) spot on x6d.region_pair = spot.rp
where 
x6d.div_type = "Airline" 
and CURRENT_DATE() between x6d.start_date and COALESCE(x6d.end_date, '2099-12-31');


SELECT
EXCEPT(n_pkg, price, key_type),
IFNULL( COALESCE(x6.mkt_carrier,x6.op_carrier), price, NULL) as price,
IFNULL( COALESCE(x6.mkt_carrier,x6.op_carrier), key_type, NULL) as key_type,
IFNULL( COALESCE(x6.mkt_carrier,x6.op_carrier), 0, 1) as modified_record,
IFNULL( COALESCE(x6.mkt_carrier,x6.op_carrier), NULL, CONCAT(COALESCE(x6.mkt_carrier,x6.op_carrier)," loss in KIWI") ) as modification_reason
FROM
matching.X6 x6 
LEFT JOIN (select rp as rp_mc, iata_code as iata_code_mc, min_lt as min_lt_mc, max_lt  as max_lt_mc from x6_div_airline ) divMC on x6.region_pair = divMC.rp_mc and x6.mkt_carrier = divMC.iata_code_mc
LEFT JOIN (select rp as rp_oc, iata_code as iata_code_oc, min_lt as min_lt_oc, max_lt  as max_lt_oc from x6_div_airline ) divOC on x6.region_pair = divOC.rp_oc and x6.op_carrier  = divOC.iata_code_oc
where
-- if ffd = yesterday then doi already embedded in X6 logic, however doi ptn filter enforced so use again
x6.date_of_issue between x6_div_airline.min_leadtime and x6_div_airline.max_leadtime
and x6.first_flight_date_utc = dt
 
----------------------------------------
 
paulo used matching.X6 and sql like
x7_modified = "WITH
  x6_modified AS(



index.X7_v4_2018_2019

cf

final_benchmark_DF


create or replace table data_eng.X7_668 as select * from index.X7_v4_2018_2019 limit 0




 
