-- delete ptn and clust
-- replace . with __
-- replace CREATE with CREATE

CREATE TABLE in1883_airtyx__A001_airline_dt_of_issue
(
  flight_op_carrier STRING,
  dt_of_issue DATE
)

CREATE TABLE in1883_airtyx__A002_region_dt_of_issue
(
  region_pair STRING,
  dt_of_issue DATE
)

CREATE TABLE in1883_airtyx__A004_region__airline_dt_of_issue
(
  flight_op_carrier STRING,
  dt_of_issue DATE,
  region_pair STRING
)

CREATE TABLE in1883_airtyx__A012_quarter_deliveries_region
(
  days DATE,
  quarter_delivery STRING,
  previous_year_date DATE,
  previous_quarter_delivery STRING,
  code_delivery STRING,
  region_pair STRING
)

CREATE TABLE in1883_airtyx__A013_quarter_deliveries_op_carrier
(
  days DATE,
  quarter_delivery STRING,
  previous_year_date DATE,
  previous_quarter_delivery STRING,
  code_delivery STRING,
  op_carrier STRING
)

CREATE TABLE in1883_airtyx__A018_month_deliveries_region
(
  days DATE,
  month_delivery STRING,
  previous_year_date DATE,
  previous_month_delivery STRING,
  code_delivery STRING,
  region_pair STRING
)

CREATE TABLE in1883_airtyx__A019_month_deliveries_op_carrier
(
  days DATE,
  month_delivery STRING,
  previous_year_date DATE,
  previous_month_delivery STRING,
  code_delivery STRING,
  op_carrier STRING
)

CREATE TABLE in1883_airtyx__A020_month_deliveries_op_carrier_region
(
  days DATE,
  month_delivery STRING,
  previous_year_date DATE,
  previous_month_delivery STRING,
  code_delivery STRING,
  op_carrier STRING,
  region_pair STRING
)

CREATE TABLE in1883_airtyx__A021_quarter_deliveries_op_carrier_region
(
  days DATE,
  quarter_delivery STRING,
  previous_year_date DATE,
  previous_quarter_delivery STRING,
  code_delivery STRING,
  op_carrier STRING,
  region_pair STRING
)

CREATE TABLE in1883_airtyx__R7_itineraries
(
  pl_id INT64,
  dt_of_issue DATE,
  od_cabin_class STRING,
  year_delivery STRING,
  month_delivery STRING,
  quarter STRING,
  month STRING,
  quarter_delivery STRING,
  lead_bucket STRING,
  od_pair STRING,
  op_carrier STRING,
  current_delay INT64,
  country_pair STRING,
  region_pair STRING,
  adjustment_received NUMERIC,
  revenue NUMERIC,
  revenue_iata NUMERIC,
  rpk NUMERIC,
  net_revenue NUMERIC,
  net_revenue_iata NUMERIC,
  net_rpk NUMERIC,
  passengers FLOAT64,
  net_passengers FLOAT64
)
