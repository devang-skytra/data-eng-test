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


with k as (select country_pair__op_carrier__skey as k from scratch_PaD_EU.R7_cp_op_DIM where country_pair like 'Sri Lanka-Ukraine' and op_carrier = 'EK')

select dt.* 
from scratch_PaD_EU.P0003_1 dt, k
where dt.P0003_skey = k.k
ORDER BY P0003_skey, dt_of_issue 




create or replace table scratch_PaD_EU.P0003 
PARTITION BY RANGE_BUCKET(P0003_skey, GENERATE_ARRAY(0, 1000000 , 250))
CLUSTER BY dt_of_issue
as (
  select 
  *, --except(P0003_skey)
  
  SUM(revenue)      OVER (PARTITION BY P0003_skey  ORDER BY dt_of_issue ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS revenue_7day,
  SUM(rpk)          OVER (PARTITION BY P0003_skey  ORDER BY dt_of_issue ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rpk_7day,
  SUM(net_revenue)  OVER (PARTITION BY P0003_skey  ORDER BY dt_of_issue ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS net_revenue_7day,
  SUM(net_rpk)      OVER (PARTITION BY P0003_skey  ORDER BY dt_of_issue ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS net_rpk_7day,
  
  SUM(revenue) OVER (PARTITION BY P0003_skey, EXTRACT(YEAR FROM dt_of_issue)  ORDER BY dt_of_issue ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS revenue_YTD,
  SUM(rpk) OVER (PARTITION BY P0003_skey, EXTRACT(YEAR FROM dt_of_issue)  ORDER BY dt_of_issue ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rpk_YTD,
  SUM(net_revenue) OVER (PARTITION BY P0003_skey, EXTRACT(YEAR FROM dt_of_issue)  ORDER BY dt_of_issue ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS net_revenue_YTD,
  SUM(net_rpk) OVER (PARTITION BY P0003_skey, EXTRACT(YEAR FROM dt_of_issue)  ORDER BY dt_of_issue ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS net_rpk_YTD
  
  FROM 
  scratch_PaD_EU.P0003_0
  where P0003_skey in(2735,164826) -- ie country_pair = 'Sri Lanka-Ukraine' and op_carrier in('EK','FZ')
  --LIMIT 0
)

--NEEDED ONCE YEARLY ONLY ONCE PRIOR YEAR IS STATIC
create or replace table scratch_PaD_EU.P0003_hist
PARTITION BY RANGE_BUCKET(P0003_skey, GENERATE_ARRAY(0, 1000000 , 250))
CLUSTER BY dt_of_issue
as (select * FROM scratch_PaD_EU.P0003
    where 
    --P0003_skey in(2735,164826)
    dt_of_issue < '2020-01-01'
)


create or replace view vw_P0003 as --reporting layer
select p3.*,

  p3.revenue_ytd / (p3h.revenue_ytd /*+ 0.01*/) AS revenue_YoY_ytd,
  p3.rpk_ytd / (p3h.rpk_ytd /*+ 0.01*/) AS rpk_YoY_ytd,
  p3.net_revenue_ytd / (p3h.net_revenue_ytd /*+ 0.01*/) AS net_revenue_YoY_ytd,
  p3.net_rpk_ytd / (p3h.net_rpk_ytd /*+ 0.01*/) AS net_rpk_YoY_ytd,
  
  p3.revenue_7day / (p3h.revenue_7day /*+ 0.01*/) AS revenue_YoY_7day,
  p3.rpk_7day / (p3h.rpk_7day /*+ 0.01*/) AS rpk_YoY_7day,
  p3.net_revenue_7day / (p3h.net_revenue_7day /*+ 0.01*/) AS net_revenue_YoY_7day,
  p3.net_rpk_7day / (p3h.net_rpk_7day /*+ 0.01*/) AS net_rpk_YoY_7day
  
from 
scratch_PaD_EU.P0003 p3 
inner join scratch_PaD_EU.P0003_hist p3h on 
  p3.P0003_skey = p3h.P0003_skey 
  and DATE_SUB(p3.dt_of_issue, INTERVAL 1 YEAR) = p3h.dt_of_issue  --366 DAY)
where 
--p3.P0003_skey = 164826 and
p3.dt_of_issue >= '2020-01-01'
order by
P0003_skey,
dt_of_issue



WITH 
#src_dM1 as(SELECT * FROM scratch_PaD_EU.P0003_0 where P0003_skey in(2735,164826) and dt_of_issue = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) ),
#dst_dM2 as(SELECT * FROM scratch_PaD_EU.P0003   where P0003_skey in(2735,164826) and dt_of_issue = DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) ),
#dst_dM8 as(SELECT * FROM scratch_PaD_EU.P0003   where P0003_skey in(2735,164826) and dt_of_issue = DATE_SUB(CURRENT_DATE, INTERVAL 8 DAY) ),

src_dM1 as ( SELECT * FROM scratch_PaD_EU.P0003_0 where P0003_skey in(2735,164826) and dt_of_issue = DATE_SUB(CURRENT_DATE, INTERVAL 91 DAY) ),
dst_dM2 as ( SELECT * FROM scratch_PaD_EU.P0003   where P0003_skey in(2735,164826) and dt_of_issue = DATE_SUB(CURRENT_DATE, INTERVAL 92 DAY) ),
dst_dM8 as ( SELECT * FROM scratch_PaD_EU.P0003   where P0003_skey in(2735,164826) and dt_of_issue = DATE_SUB(CURRENT_DATE, INTERVAL 98 DAY) ),

delta as (
select
m2.revenue_7day - m8.revenue + m1.revenue as revenue_7day_yest,
m2.revenue_ytd + m1.revenue as revenue_ytd_yest
from
src_dM1 m1
inner join dst_dM2 as m2 on m1.P0003_skey = m2.P0003_skey
inner join dst_dM8 as m8 on m1.P0003_skey = m8.P0003_skey
)

select * from delta



