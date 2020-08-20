-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/5vwJbu
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "P001_Revenue_per_region_pair" (
    "dt_of_issue" DATE  NOT NULL ,
    "region_pair" STRING  NOT NULL ,
    "revenue" NUMERIC  NOT NULL ,
    "rpk" NUMERIC  NOT NULL ,
    "net_revenue" NUMERIC  NOT NULL ,
    "net_rpk" NUMERIC  NOT NULL ,
    "revenue_7day" NUMERIC  NOT NULL ,
    "rpk_7day" NUMERIC  NOT NULL ,
    "net_revenue_7day" NUMERIC  NOT NULL ,
    "net_rpk_7day" NUMERIC  NOT NULL ,
    "yield" FLOAT64  NOT NULL ,
    "yoy_yield" FLOAT64  NOT NULL ,
    "yoy_revenue_7day" NUMERIC  NOT NULL ,
    "yoy_rpk_7day" NUMERIC  NOT NULL ,
    "yoy_net_revenue_7day" NUMERIC  NOT NULL ,
    "yoy_net_rpk_7day" NUMERIC  NOT NULL ,
    CONSTRAINT "pk_P001_Revenue_per_region_pair" PRIMARY KEY (
        "dt_of_issue","region_pair"
    )
)

GO

CREATE TABLE "P002_Revenue_yield_per_region_pair_airline" (
    "dt_of_issue" DATE  NOT NULL ,
    "region_pair" STRING  NOT NULL ,
    "flight_op_carrier" STRING  NOT NULL ,
    "revenue" NUMERIC  NOT NULL ,
    "rpk" NUMERIC  NOT NULL ,
    "net_revenue" NUMERIC  NOT NULL ,
    "net_rpk" NUMERIC  NOT NULL ,
    "revenue_7day" NUMERIC  NOT NULL ,
    "rpk_7day" NUMERIC  NOT NULL ,
    "net_revenue_7day" NUMERIC  NOT NULL ,
    "net_rpk_7day" NUMERIC  NOT NULL ,
    "yield" FLOAT64  NOT NULL ,
    "yoy_yield" FLOAT64  NOT NULL ,
    "yoy_revenue_7day" NUMERIC  NOT NULL ,
    "yoy_rpk_7day" NUMERIC  NOT NULL ,
    "yoy_net_revenue_7day" NUMERIC  NOT NULL ,
    "yoy_net_rpk_7day" NUMERIC  NOT NULL ,
    CONSTRAINT "pk_P002_Revenue_yield_per_region_pair_airline" PRIMARY KEY (
        "dt_of_issue","region_pair","flight_op_carrier"
    )
)

GO

CREATE TABLE "P003_Revenue_yield_per_country_pair_pair_airline" (
    "dt_of_issue" DATE  NOT NULL ,
    "country_pair" STRING  NOT NULL ,
    "flight_op_carrier" STRING  NOT NULL ,
    "revenue" NUMERIC  NOT NULL ,
    "rpk" NUMERIC  NOT NULL ,
    "net_revenue" NUMERIC  NOT NULL ,
    "net_rpk" NUMERIC  NOT NULL ,
    "revenue_7day" NUMERIC  NOT NULL ,
    "rpk_7day" NUMERIC  NOT NULL ,
    "net_revenue_7day" NUMERIC  NOT NULL ,
    "net_rpk_7day" NUMERIC  NOT NULL ,
    "yield" FLOAT64  NOT NULL ,
    "yoy_yield" FLOAT64  NOT NULL ,
    "yoy_revenue_7day" NUMERIC  NOT NULL ,
    "yoy_rpk_7day" NUMERIC  NOT NULL ,
    "yoy_net_revenue_7day" NUMERIC  NOT NULL ,
    "yoy_net_rpk_7day" NUMERIC  NOT NULL ,
    CONSTRAINT "pk_P003_Revenue_yield_per_country_pair_pair_airline" PRIMARY KEY (
        "dt_of_issue","country_pair","flight_op_carrier"
    )
)

GO

CREATE TABLE "P004_Forward_revenue_yield_per_region_pair_pair_airline" (
    "dt_of_issue" DATE  NOT NULL ,
    "region_pair" STRING  NOT NULL ,
    "flight_op_carrier" STRING  NOT NULL ,
    "lead_bucket" STRING  NOT NULL ,
    "revenue" NUMERIC  NOT NULL ,
    "rpk" NUMERIC  NOT NULL ,
    "net_revenue" NUMERIC  NOT NULL ,
    "net_rpk" NUMERIC  NOT NULL ,
    "revenue_7day" NUMERIC  NOT NULL ,
    "rpk_7day" NUMERIC  NOT NULL ,
    "net_revenue_7day" NUMERIC  NOT NULL ,
    "net_rpk_7day" NUMERIC  NOT NULL ,
    "yield" FLOAT64  NOT NULL ,
    "yoy_yield" FLOAT64  NOT NULL ,
    "yoy_revenue_7day" NUMERIC  NOT NULL ,
    "yoy_rpk_7day" NUMERIC  NOT NULL ,
    "yoy_net_revenue_7day" NUMERIC  NOT NULL ,
    "yoy_net_rpk_7day" NUMERIC  NOT NULL ,
    CONSTRAINT "pk_P004_Forward_revenue_yield_per_region_pair_pair_airline" PRIMARY KEY (
        "dt_of_issue","region_pair","flight_op_carrier","lead_bucket"
    )
)

GO

-- Rather than rebuild base P003 history every day
-- we can calc YTD to yesterday every day and append (snapshot fact)
-- vw_P0003 can join base P003 to here as reporting layer and if required do
-- SUM() OVER (PARTTION ORDER BY ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
CREATE TABLE "P003_Revenue_YoY_Snapshot" (
    "ts" TIMESTAMP  NOT NULL ,
    "snapshot_date" DATE  NOT NULL ,
    "country_pair" STRING  NOT NULL ,
    "flight_op_carrier" STRING  NOT NULL ,
    "yoy_yield" FLOAT64  NOT NULL ,
    "yoy_revenue_7day" NUMERIC  NOT NULL ,
    "yoy_rpk_7day" NUMERIC  NOT NULL ,
    "yoy_net_revenue_7day" NUMERIC  NOT NULL ,
    "yoy_net_rpk_7day" NUMERIC  NOT NULL ,
    CONSTRAINT "pk_P003_Revenue_YoY_Snapshot" PRIMARY KEY (
        "snapshot_date","country_pair","flight_op_carrier"
    )
)

GO

ALTER TABLE "P003_Revenue_yield_per_country_pair_pair_airline" ADD CONSTRAINT "fk_P003_Revenue_yield_per_country_pair_pair_airline_dt_of_issue_country_pair_flight_op_carrier" FOREIGN KEY("dt_of_issue", "country_pair", "flight_op_carrier")
REFERENCES "P003_Revenue_YoY_Snapshot" ("snapshot_date", "country_pair", "flight_op_carrier")
GO

