--C:\git\DataEng\index_tests\data_product_tuning\R7_country_pair__op_carrier__DIM.sql


/*

select  max(country_pair__op_carrier__skey), max(country_pair__op_carrier__skey)/4000 from scratch_SaN.country_pair__op_carrier__DIM
-- 99999471249575403 2.499986781239385E13
--100000000000000000
select 25000000000000*4000

--GENERATE_ARRAY(0, 100000000000000000 , 25000000000000)
*/



create or replace table scratch_PaD_EU.R7_cp_op_DIM
( 
  country_pair__op_carrier__skey INT64,
  country_pair STRING,
  op_carrier STRING
) 
PARTITION BY RANGE_BUCKET(country_pair__op_carrier__skey, GENERATE_ARRAY(0, 1000000 , 250)
)  
--CLUSTER BY dt_of_issue 
as
(
  WITH comp_key as (
  SELECT 
  distinct 
  country_pair,
  op_carrier
  FROM 
  `skytra-benchmark-rnd.matching.R7_itineraries`
  )
  
  SELECT 
  --SAFE_CAST( SUBSTR ( REGEXP_REPLACE( GENERATE_UUID(), r'[^\d]+', ''), 0, 17 ) AS INT64) as 
  ROW_NUMBER() OVER() as 
  country_pair__op_carrier__skey, 
  country_pair,
  op_carrier
  FROM 
  comp_key
)

create or replace table scratch_PaD_EU.P0003_0 ( 
  P0003_skey INT64,
  country_pair	STRING,
  op_carrier	STRING,
  dt_of_issue	DATE, 
  revenue	NUMERIC,
  rpk	NUMERIC,
  net_revenue	NUMERIC,
  net_rpk NUMERIC
) 
PARTITION BY RANGE_BUCKET(P0003_skey, GENERATE_ARRAY(0, 1000000 , 250))
CLUSTER BY dt_of_issue
as (
WITH
  base_merge AS (
  SELECT
    p.country_pair,
    p.flight_op_carrier as op_carrier,
    p.dt_of_issue,
    SUM(COALESCE(revenue,0)) AS revenue,
    SUM(COALESCE(rpk,0)) AS rpk,
    SUM(COALESCE(net_revenue,0)) AS net_revenue,
    SUM(COALESCE(net_rpk,0)) AS net_rpk
  FROM
  `skytra-benchmark-rnd.products_IN1139.A005_country_pair_airline_dt_of_issue` p
  LEFT JOIN `skytra-benchmark-rnd.matching.R7_itineraries` r7
  ON
    p.dt_of_issue = r7.dt_of_issue
    AND p.country_pair = r7.country_pair
    AND p.flight_op_carrier = r7.op_carrier 
  GROUP BY
    p.dt_of_issue,
    p.country_pair,
    p.flight_op_carrier
    ),
  
 exclusions AS (
  SELECT
    country_pair,
    op_carrier,
    1 AS exclusion
  FROM
    base_merge
  GROUP BY 1,2
  HAVING SUM( ABS(revenue) + ABS(rpk) + ABS(net_revenue) + ABS(net_rpk) ) = 0
)
  
SELECT 
d.country_pair__op_carrier__skey as P0003_skey, 
dt.* 
FROM base_merge dt 
INNER JOIN scratch_PaD_EU.R7_cp_op_DIM d on
  dt.country_pair = d.country_pair and 
  dt.op_carrier = d.op_carrier
LEFT JOIN exclusions e 
  ON
  dt.country_pair = e.country_pair
  AND dt.op_carrier = e.op_carrier 
  
WHERE
  exclusion IS NULL
)

create or replace table scratch_PaD_EU.P0003_1 ( 
  P0003_skey INT64,
  country_pair	STRING,
  op_carrier	STRING,
  dt_of_issue	DATE, 
  revenue	NUMERIC,
  rpk	NUMERIC,
  net_revenue	NUMERIC,
  net_rpk NUMERIC,
  revenue_7day	NUMERIC,
  rpk_7day	NUMERIC,
  net_revenue_7day	NUMERIC,
  net_rpk_7day NUMERIC
) 
PARTITION BY RANGE_BUCKET(P0003_skey, GENERATE_ARRAY(0, 1000000 , 250))
CLUSTER BY dt_of_issue
as (
SELECT
  P0003_skey,
  country_pair,
  op_carrier,
  dt_of_issue,
  revenue,
  rpk,
  net_revenue,
  net_rpk,
  SUM(revenue)      OVER (PARTITION BY P0003_skey  ORDER BY P0003_skey, dt_of_issue ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS revenue_7day,
  SUM(rpk)          OVER (PARTITION BY P0003_skey  ORDER BY P0003_skey, dt_of_issue ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rpk_7day,
  SUM(net_revenue)  OVER (PARTITION BY P0003_skey  ORDER BY P0003_skey, dt_of_issue ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS net_revenue_7day,
  SUM(net_rpk)      OVER (PARTITION BY P0003_skey  ORDER BY P0003_skey, dt_of_issue ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS net_rpk_7day
FROM scratch_PaD_EU.P0003_0
)


with k as (select country_pair__op_carrier__skey as k from scratch_PaD_EU.R7_cp_op_DIM where country_pair like 'Sri Lanka-Ukraine' and op_carrier = 'EK')

select dt.* 
from scratch_PaD_EU.P0003_1 dt, k
where dt.P0003_skey = k.k
ORDER BY P0003_skey, dt_of_issue 




