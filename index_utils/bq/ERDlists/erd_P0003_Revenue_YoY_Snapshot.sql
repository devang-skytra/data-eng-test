/*
https://app.quickdatabasediagrams.com/#/

WITH tbls as ( 
SELECT table_schema, table_name FROM 
--products_IN1139.
scratch_PaD_EU.
INFORMATION_SCHEMA.TABLES where table_name 
--like 'P%'
in('P0003','P0003_hist')
),


cols as ( --INFORMATION_SCHEMA.TABLES INFORMATION_SCHEMA.COLUMNS INFORMATION_SCHEMA.COLUMN_FIELD_PATHS
SELECT * FROM 
--products_IN1139.
scratch_PaD_EU.
INFORMATION_SCHEMA.COLUMNS      WHERE table_name in(select table_name from tbls) 
)

select * from 
(
SELECT table_schema, table_name, table_name as c1, -1 as c2 FROM tbls
UNION ALL
SELECT table_schema, table_name, '--' as c1, 0 as c2 FROM tbls
UNION ALL
SELECT table_schema, table_name, '' as c1, 99 as c2 FROM tbls
UNION ALL
SELECT
table_schema, table_name, CONCAT( column_name, ' ', data_type, ' ', IF(is_partitioning_column='YES','UNIQUE ',''), IF(clustering_ordinal_position > 0, 'UNIQUE','') ) as c1, ordinal_position as c2
FROM cols
)
order by 1,2,4
*/

P001_Revenue_per_region_pair
--
dt_of_issue DATE PK
region_pair STRING  PK
revenue NUMERIC 
rpk NUMERIC 
net_revenue NUMERIC 
net_rpk NUMERIC 
revenue_7day NUMERIC 
rpk_7day NUMERIC 
net_revenue_7day NUMERIC 
net_rpk_7day NUMERIC 
yield FLOAT64 
yoy_yield FLOAT64 
yoy_revenue_7day NUMERIC 
yoy_rpk_7day NUMERIC 
yoy_net_revenue_7day NUMERIC 
yoy_net_rpk_7day NUMERIC 

P002_Revenue_yield_per_region_pair_airline
--
dt_of_issue DATE  PK
region_pair STRING  PK
flight_op_carrier STRING  PK
revenue NUMERIC 
rpk NUMERIC 
net_revenue NUMERIC 
net_rpk NUMERIC 
revenue_7day NUMERIC 
rpk_7day NUMERIC 
net_revenue_7day NUMERIC 
net_rpk_7day NUMERIC 
yield FLOAT64 
yoy_yield FLOAT64 
yoy_revenue_7day NUMERIC 
yoy_rpk_7day NUMERIC 
yoy_net_revenue_7day NUMERIC 
yoy_net_rpk_7day NUMERIC 



P003_Revenue_yield_per_country_pair_airline
--
dt_of_issue DATE  PK #FK - P3h.snapshot_date
country_pair STRING  PK #FK - P3h.country_pair
flight_op_carrier STRING  #PK FK - P3h.flight_op_carrier
revenue NUMERIC 
rpk NUMERIC 
net_revenue NUMERIC 
net_rpk NUMERIC 
revenue_7day NUMERIC 
rpk_7day NUMERIC 
net_revenue_7day NUMERIC 
net_rpk_7day NUMERIC 
yield NUMERIC 
# calc this in view join P3 to P3h
#yoy_yield NUMERIC 
#yoy_revenue_7day NUMERIC 
#yoy_rpk_7day NUMERIC 
#yoy_net_revenue_7day NUMERIC 
#yoy_net_rpk_7day NUMERIC 

P0003 as P3
--
P0003_skey INT64 UNIQUE 
country_pair STRING  PK FK - P3h.country_pair
op_carrier STRING  PK FK - P3h.op_carrier
dt_of_issue DATE PK FK - P3h.dt_of_issue
revenue NUMERIC 
rpk NUMERIC 
net_revenue NUMERIC 
net_rpk NUMERIC 
revenue_7day NUMERIC 
rpk_7day NUMERIC 
net_revenue_7day NUMERIC 
net_rpk_7day NUMERIC 
revenue_ytd NUMERIC 
rpk_ytd NUMERIC 
net_revenue_ytd NUMERIC 
net_rpk_ytd NUMERIC 
# Rather than rebuild P003 history every day
#  we can calc YTD and join to P0003_hist (append prior year to hist, once prior year is static)
#
#  create or replace view vw_P0003 as --reporting layer
#  select P3.*,
#  ( SUM() OVER (PARTITION BY P0003_skey, EXTRACT(YEAR FROM dt_of_issue)  ORDER BY dt_of_issue ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) ) / P3h.net_revenue_ytd AS net_rpk_YoY
#  from P0003 p3 inner join P0003_hist p3h on p3.P0003_skey = p3h.P0003_skey 
#   and p3.dt_of_issue = DATE_SUB(p3h.dt_of_issue INTERVAL 1 YEAR)
#yoy_yield NUMERIC 
#yoy_revenue_7day NUMERIC 
#yoy_rpk_7day NUMERIC 
#yoy_net_revenue_7day NUMERIC 
#yoy_net_rpk_7day NUMERIC 

P0003_hist as P3h
--
P0003_skey INT64 UNIQUE 
country_pair STRING 
op_carrier STRING 
dt_of_issue DATE UNIQUE
revenue NUMERIC 
rpk NUMERIC 
net_revenue NUMERIC 
net_rpk NUMERIC 
revenue_7day NUMERIC 
rpk_7day NUMERIC 
net_revenue_7day NUMERIC 
net_rpk_7day NUMERIC 
revenue_ytd NUMERIC 
rpk_ytd NUMERIC 
net_revenue_ytd NUMERIC 
net_rpk_ytd NUMERIC 



P004_Forward_revenue_yield_per_region_pair_pair_airline
--
dt_of_issue DATE  PK
region_pair STRING  PK
flight_op_carrier STRING  PK
lead_bucket STRING  PK
revenue NUMERIC 
rpk NUMERIC 
net_revenue NUMERIC 
net_rpk NUMERIC 
revenue_7day NUMERIC 
rpk_7day NUMERIC 
net_revenue_7day NUMERIC 
net_rpk_7day NUMERIC 
yield FLOAT64 
yoy_yield FLOAT64 
yoy_revenue_7day NUMERIC 
yoy_rpk_7day NUMERIC 
yoy_net_revenue_7day NUMERIC 
yoy_net_rpk_7day NUMERIC 

















