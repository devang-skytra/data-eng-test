-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/EreLjZ
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

CREATE TABLE "P003_Revenue_yield_per_country_pair_airline" (
    -- FK - P3h.snapshot_date
    "dt_of_issue" DATE  NOT NULL ,
    -- FK - P3h.country_pair
    "country_pair" STRING  NOT NULL ,
    -- PK FK - P3h.flight_op_carrier
    "flight_op_carrier" STRING  NOT NULL ,
    "revenue" NUMERIC  NOT NULL ,
    "rpk" NUMERIC  NOT NULL ,
    "net_revenue" NUMERIC  NOT NULL ,
    "net_rpk" NUMERIC  NOT NULL ,
    "revenue_7day" NUMERIC  NOT NULL ,
    "rpk_7day" NUMERIC  NOT NULL ,
    "net_revenue_7day" NUMERIC  NOT NULL ,
    "net_rpk_7day" NUMERIC  NOT NULL ,
    "yield" NUMERIC  NOT NULL ,
    CONSTRAINT "pk_P003_Revenue_yield_per_country_pair_airline" PRIMARY KEY (
        "dt_of_issue","country_pair"
    )
)

GO

-- calc this in view join P3 to P3h
-- yoy_yield NUMERIC
-- yoy_revenue_7day NUMERIC
-- yoy_rpk_7day NUMERIC
-- yoy_net_revenue_7day NUMERIC
-- yoy_net_rpk_7day NUMERIC
CREATE TABLE "P0003" (
    "P0003_skey" INT64  NOT NULL ,
    "country_pair" STRING  NOT NULL ,
    "op_carrier" STRING  NOT NULL ,
    "dt_of_issue" DATE  NOT NULL ,
    "revenue" NUMERIC  NOT NULL ,
    "rpk" NUMERIC  NOT NULL ,
    "net_revenue" NUMERIC  NOT NULL ,
    "net_rpk" NUMERIC  NOT NULL ,
    "revenue_7day" NUMERIC  NOT NULL ,
    "rpk_7day" NUMERIC  NOT NULL ,
    "net_revenue_7day" NUMERIC  NOT NULL ,
    "net_rpk_7day" NUMERIC  NOT NULL ,
    "revenue_ytd" NUMERIC  NOT NULL ,
    "rpk_ytd" NUMERIC  NOT NULL ,
    "net_revenue_ytd" NUMERIC  NOT NULL ,
    "net_rpk_ytd" NUMERIC  NOT NULL ,
    CONSTRAINT "pk_P0003" PRIMARY KEY (
        "country_pair","op_carrier","dt_of_issue"
    ),
    CONSTRAINT "uk_P0003_P0003_skey" UNIQUE (
        "P0003_skey"
    )
)

GO

-- calc this in view join P3 to P3h
-- yoy_yield NUMERIC
-- yoy_revenue_7day NUMERIC
-- yoy_rpk_7day NUMERIC
-- yoy_net_revenue_7day NUMERIC
-- yoy_net_rpk_7day NUMERIC
CREATE TABLE "P0003_hist" (
    "P0003_skey" INT64  NOT NULL ,
    "country_pair" STRING  NOT NULL ,
    "op_carrier" STRING  NOT NULL ,
    "dt_of_issue" DATE  NOT NULL ,
    "revenue" NUMERIC  NOT NULL ,
    "rpk" NUMERIC  NOT NULL ,
    "net_revenue" NUMERIC  NOT NULL ,
    "net_rpk" NUMERIC  NOT NULL ,
    "revenue_7day" NUMERIC  NOT NULL ,
    "rpk_7day" NUMERIC  NOT NULL ,
    "net_revenue_7day" NUMERIC  NOT NULL ,
    "net_rpk_7day" NUMERIC  NOT NULL ,
    "revenue_ytd" NUMERIC  NOT NULL ,
    "rpk_ytd" NUMERIC  NOT NULL ,
    "net_revenue_ytd" NUMERIC  NOT NULL ,
    "net_rpk_ytd" NUMERIC  NOT NULL ,

    CONSTRAINT "uk_P0003_hist_P0003_skey" UNIQUE (
        "P0003_skey"
    ),
    CONSTRAINT "uk_P0003_hist_dt_of_issue" UNIQUE (
        "dt_of_issue"
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

ALTER TABLE "P0003" ADD CONSTRAINT "fk_P0003_country_pair_op_carrier_dt_of_issue" FOREIGN KEY("country_pair", "op_carrier", "dt_of_issue")
REFERENCES "P0003_hist" ("country_pair", "op_carrier", "dt_of_issue")
GO

