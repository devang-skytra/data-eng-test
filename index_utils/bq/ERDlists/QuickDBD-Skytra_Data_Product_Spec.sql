-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/bvlTz3
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Skytra_Customised_Index_and_Volume_x6" (
    "Region_Pair" STRING  NOT NULL ,
    "ASASED__full_history_Daily" NUMERIC  NOT NULL ,
    "ASASEP__full_history_28DMA" NUMERIC  NOT NULL ,
    "ASASDV__full_history_RPK_Daily" NUMERIC  NOT NULL ,
    "ASASPV__full_history_RPK_28DMA" NUMERIC  NOT NULL 
)

GO

CREATE TABLE "Skytra_Customised_Future_Period" (
    "filter_Region_Pair" STRING  NOT NULL ,
    "filter_country_Pair" STRING  NOT NULL ,
    "filter_Airline" STRING  NOT NULL ,
    "filter_Travel_Period" STRING  NOT NULL ,
    "filter_FUTURE_CALENDAR_DATE" STRING  NOT NULL ,
    "Index_Date" DATE  NOT NULL ,
    "Yield_Matched_Running_Average_USD" NUMERIC  NOT NULL ,
    "Volume_Sold_(RPK)" NUMERIC  NOT NULL 
)

GO

CREATE TABLE "Skytra_Customised_Future_Settlement_x60" (
    "product__FUTURE_SETTLEMENT_PERIOD" STRING  NOT NULL ,
    "range__Month+2_to_Month+14" STRING  NOT NULL ,
    "filter_Region_Pair" STRING  NOT NULL ,
    "filter_Period" STRING  NOT NULL ,
    "Index_Date" DATE  NOT NULL ,
    "ASASExM__Yield_Matched_Running_Average_USD" NUMERIC  NOT NULL ,
    "ASASExV__Volume_Sold_(RPK)" NUMERIC  NOT NULL ,
    "ASASExMC__Yield_Running_Average_YoY_Pct_Change" NUMERIC  NOT NULL ,
    "ASASExVC__Volume_Sold_(RPK)_YoY_Pct_Change" NUMERIC  NOT NULL ,

    CONSTRAINT "uk_Skytra_Customised_Future_Settlement_x60_filter_Region_Pair" UNIQUE (
        "filter_Region_Pair"
    ),
    CONSTRAINT "uk_Skytra_Customised_Future_Settlement_x60_filter_Period" UNIQUE (
        "filter_Period"
    ),
    CONSTRAINT "uk_Skytra_Customised_Future_Settlement_x60_Index_Date" UNIQUE (
        "Index_Date"
    )
)

GO

CREATE TABLE "Skytra_Bespoke_Index_Data" (
    "as_per_ind_cust_req" STRING  NOT NULL 
)

GO

CREATE TABLE "X6" (
    "pl_id" INT64  NOT NULL ,
    "ticket_id" STRING  NOT NULL ,
    -- FK - I2.ticket_id
    "region_pair" STRING  NOT NULL ,
    "dt_of_issue" DATE  NOT NULL ,
    "nb_legs" INT64  NOT NULL ,
    "leadtime" INT64  NOT NULL ,
    "first_flight_date_utc" DATE  NOT NULL ,
    "journey_map" STRING  NOT NULL ,
    "classless_journey_map" STRING  NOT NULL ,
    "sumP" FLOAT64  NOT NULL ,
    "od_mile" FLOAT64  NOT NULL ,
    "leg_prices" STRING  NOT NULL ,
    "leg_miles" STRING  NOT NULL ,
    "mkt_carrier_code_list" STRING  NOT NULL ,
    "operating_carrier_list" STRING  NOT NULL ,
    "mkt_carrier" STRING  NOT NULL ,
    "op_carrier" STRING  NOT NULL ,
    "n_pkg" INT64  NOT NULL ,
    "price" FLOAT64  NOT NULL ,
    -- FK - X5b.price
    "key_type" STRING  NOT NULL ,
    "distribution_channel" STRING  NOT NULL ,
    "source_code" STRING  NOT NULL ,
    "ticket_document_amount" FLOAT64  NOT NULL ,
    "FILE_SOURCE" STRING  NOT NULL ,
    "skytra_search" FLOAT64  NOT NULL ,

    CONSTRAINT "uk_X6_region_pair" UNIQUE (
        "region_pair"
    ),
    CONSTRAINT "uk_X6_dt_of_issue" UNIQUE (
        "dt_of_issue"
    ),
    CONSTRAINT "uk_X6_first_flight_date_utc" UNIQUE (
        "first_flight_date_utc"
    )
)

GO

CREATE TABLE "X7" (
    "pl_id" INT64  NOT NULL ,
    "region_pair" STRING  NOT NULL ,
    "first_flight_date" DATE  NOT NULL ,
    "iata_index" FLOAT64  NOT NULL ,
    "skytra_index" FLOAT64  NOT NULL ,
    "iata_rpk" FLOAT64  NOT NULL ,
    "skytra_rpk" FLOAT64  NOT NULL ,
    "iata_tickets" INT64  NOT NULL ,
    "skytra_tickets" INT64  NOT NULL ,
    "skytra_coverage" FLOAT64  NOT NULL ,
    "metric_code" STRING  NOT NULL ,
    "metric_value" NUMERIC  NOT NULL ,
    CONSTRAINT "pk_X7" PRIMARY KEY (
        "region_pair","first_flight_date"
    )
)

GO

CREATE TABLE "X7_IATA_2013_2020" (
    "pl_id" INT64  NOT NULL ,
    "region_pair" STRING  NOT NULL ,
    "first_flight_date" DATE  NOT NULL ,
    "IATA_RRPK_USD" FLOAT64  NOT NULL ,
    "IATA_TOT_RPK" FLOAT64  NOT NULL ,
    "iata_tickets" INT64  NOT NULL ,
    "metric_code" STRING  NOT NULL ,
    "metric_value" NUMERIC  NOT NULL ,
    CONSTRAINT "pk_X7_IATA_2013_2020" PRIMARY KEY (
        "region_pair","first_flight_date"
    )
)

GO

CREATE TABLE "X7_IATA_dt_of_issue" (
    "pl_id" INT64  NOT NULL ,
    "region_pair" STRING  NOT NULL ,
    "dt_of_issue" DATE  NOT NULL ,
    "iata_index" FLOAT64  NOT NULL ,
    "skytra_index" FLOAT64  NOT NULL ,
    "iata_rpk" FLOAT64  NOT NULL ,
    "skytra_rpk" FLOAT64  NOT NULL ,
    "iata_tickets" INT64  NOT NULL ,
    "skytra_tickets" INT64  NOT NULL ,
    "skytra_coverage" FLOAT64  NOT NULL ,
    "metric_code" STRING  NOT NULL ,
    "metric_value" NUMERIC  NOT NULL ,
    CONSTRAINT "pk_X7_IATA_dt_of_issue" PRIMARY KEY (
        "region_pair","dt_of_issue"
    )
)

GO

CREATE TABLE "X7_RL_4_4" (
    "pl_id" INT64  NOT NULL ,
    "date" DATE  NOT NULL ,
    "region_pair" STRING  NOT NULL ,
    "skytra_index" FLOAT64  NOT NULL ,
    "skytra_benchmark" FLOAT64  NOT NULL ,
    "skytra_issued_index" FLOAT64  NOT NULL ,
    "skytra_issued_benchmark" FLOAT64  NOT NULL ,
    "metric_code" STRING  NOT NULL ,
    "metric_value" NUMERIC  NOT NULL ,
    CONSTRAINT "pk_X7_RL_4_4" PRIMARY KEY (
        "date","region_pair"
    )
)

GO

CREATE TABLE "R1" (

)

GO

CREATE TABLE "R5" (

)

GO

CREATE TABLE "R6" (
    "pl_id" INT64  NOT NULL ,
    "ticket_id" STRING  NOT NULL ,
    "dt_of_issue" DATE  NOT NULL ,
    "first_flight_date_utc" DATE  NOT NULL ,
    "leadtime" INT64  NOT NULL ,
    "od_pair" STRING  NOT NULL ,
    "country_pair" STRING  NOT NULL ,
    "region_pair" STRING  NOT NULL ,
    "ticket_op_carrier" STRING  NOT NULL ,
    "ticket_mkt_carrier" STRING  NOT NULL ,
    "flight_datetime_utc" TIMESTAMP  NOT NULL ,
    "flyFrom_leg" STRING  NOT NULL ,
    "flyTo_leg" STRING  NOT NULL ,
    "flight_op_carrier" STRING  NOT NULL ,
    "flight_mkt_carrier" STRING  NOT NULL ,
    "dist_km" FLOAT64  NOT NULL ,
    "waterfall_rrpk" FLOAT64  NOT NULL ,
    "leg_revenue" FLOAT64  NOT NULL ,
    "transaction_code" STRING  NOT NULL ,
    "od_cabin_class" STRING  NOT NULL ,
    "FILE_SOURCE" STRING  NOT NULL ,

    CONSTRAINT "uk_R6_dt_of_issue" UNIQUE (
        "dt_of_issue"
    )
)

GO

CREATE TABLE "R7" (
    "pl_id" INT64  NOT NULL ,
    "dt_of_issue" DATE  NOT NULL ,
    "month_delivery" STRING  NOT NULL ,
    "lead_bucket" STRING  NOT NULL ,
    "od_pair" STRING  NOT NULL ,
    "country_pair" STRING  NOT NULL ,
    "region_pair" STRING  NOT NULL ,
    "op_carrier" STRING  NOT NULL ,
    "revenue" FLOAT64  NOT NULL ,
    "rpk" FLOAT64  NOT NULL ,
    "net_revenue" FLOAT64  NOT NULL ,
    "net_rpk" FLOAT64  NOT NULL 
)

GO

CREATE TABLE "R7_countries_op_carrier" (
    "country_pair" STRING  NOT NULL ,
    "operating_carrier" STRING  NOT NULL ,
    "dt_of_issue" DATE  NOT NULL ,
    "yield" FLOAT64  NOT NULL ,
    "revenue" FLOAT64  NOT NULL ,
    "rpk" FLOAT64  NOT NULL ,
    "net_revenue" FLOAT64  NOT NULL ,
    "net_rpk" FLOAT64  NOT NULL ,

    CONSTRAINT "uk_R7_countries_op_carrier_dt_of_issue" UNIQUE (
        "dt_of_issue"
    )
)

GO

CREATE TABLE "R7_flights" (
    "pl_id" INT64  NOT NULL ,
    "dt_of_issue" DATE  NOT NULL ,
    "month_delivery" STRING  NOT NULL ,
    "lead_bucket" STRING  NOT NULL ,
    "op_carrier" STRING  NOT NULL ,
    -- AIRPORT GRAIN
    "flyFrom_leg_(AIRPORT)" STRING  NOT NULL ,
    "flyTo_leg_(AIRPORT)" STRING  NOT NULL ,
    "flyFrom_country" STRING  NOT NULL ,
    "flyTo_country" STRING  NOT NULL ,
    "flyFrom_region" STRING  NOT NULL ,
    "flyTo_region" STRING  NOT NULL ,
    "flight_type_(DOM_or_INT)" STRING  NOT NULL ,
    "revenue" FLOAT64  NOT NULL ,
    "rpk" FLOAT64  NOT NULL ,
    "net_revenue" FLOAT64  NOT NULL ,
    "net_rpk" FLOAT64  NOT NULL 
)

GO

CREATE TABLE "R7_itineraries" (
    "pl_id" INT64  NOT NULL ,
    "dt_of_issue" DATE  NOT NULL ,
    "month_delivery" STRING  NOT NULL ,
    "lead_bucket" STRING  NOT NULL ,
    "od_pair" STRING  NOT NULL ,
    "country_pair" STRING  NOT NULL ,
    "region_pair" STRING  NOT NULL ,
    "op_carrier" STRING  NOT NULL ,
    "revenue" FLOAT64  NOT NULL ,
    "rpk" FLOAT64  NOT NULL ,
    "net_revenue" FLOAT64  NOT NULL ,
    "net_rpk" FLOAT64  NOT NULL ,

    CONSTRAINT "uk_R7_itineraries_dt_of_issue" UNIQUE (
        "dt_of_issue"
    )
)

GO

CREATE TABLE "R7_regions_op_carrier" (
    "region_pair" STRING  NOT NULL ,
    "operating_carrier" STRING  NOT NULL ,
    "dt_of_issue" DATE  NOT NULL ,
    "yield" FLOAT64  NOT NULL ,
    "revenue" FLOAT64  NOT NULL ,
    "rpk" FLOAT64  NOT NULL ,
    "net_revenue" FLOAT64  NOT NULL ,
    "net_rpk" FLOAT64  NOT NULL ,

    CONSTRAINT "uk_R7_regions_op_carrier_dt_of_issue" UNIQUE (
        "dt_of_issue"
    )
)

GO

ALTER TABLE "Skytra_Customised_Index_and_Volume_x6" ADD CONSTRAINT "fk_Skytra_Customised_Index_and_Volume_x6_Region_Pair" FOREIGN KEY("Region_Pair")
REFERENCES "X7" ("first_flight_date")
GO

ALTER TABLE "Skytra_Customised_Future_Period" ADD CONSTRAINT "fk_Skytra_Customised_Future_Period_filter_Region_Pair" FOREIGN KEY("filter_Region_Pair")
REFERENCES "X7" ("first_flight_date")
GO

ALTER TABLE "Skytra_Customised_Future_Settlement_x60" ADD CONSTRAINT "fk_Skytra_Customised_Future_Settlement_x60_filter_Region_Pair" FOREIGN KEY("filter_Region_Pair")
REFERENCES "X7" ("first_flight_date")
GO

ALTER TABLE "Skytra_Bespoke_Index_Data" ADD CONSTRAINT "fk_Skytra_Bespoke_Index_Data_as_per_ind_cust_req" FOREIGN KEY("as_per_ind_cust_req")
REFERENCES "X7" ("first_flight_date")
GO

ALTER TABLE "X7" ADD CONSTRAINT "fk_X7_region_pair_first_flight_date" FOREIGN KEY("region_pair", "first_flight_date")
REFERENCES "X6" ("region_pair", "first_flight_date_utc")
GO

ALTER TABLE "X7_IATA_2013_2020" ADD CONSTRAINT "fk_X7_IATA_2013_2020_region_pair_first_flight_date" FOREIGN KEY("region_pair", "first_flight_date")
REFERENCES "X6" ("region_pair", "first_flight_date_utc")
GO

ALTER TABLE "X7_IATA_dt_of_issue" ADD CONSTRAINT "fk_X7_IATA_dt_of_issue_region_pair_dt_of_issue" FOREIGN KEY("region_pair", "dt_of_issue")
REFERENCES "X6" ("region_pair", "dt_of_issue")
GO

ALTER TABLE "X7_RL_4_4" ADD CONSTRAINT "fk_X7_RL_4_4_date_region_pair" FOREIGN KEY("date", "region_pair")
REFERENCES "X6" ("first_flight_date_utc", "region_pair")
GO

ALTER TABLE "R7" ADD CONSTRAINT "fk_R7_dt_of_issue_lead_bucket_od_pair_country_pair_region_pair_op_carrier" FOREIGN KEY("dt_of_issue", "lead_bucket", "od_pair", "country_pair", "region_pair", "op_carrier")
REFERENCES "R6" ("dt_of_issue", "leadtime", "od_pair", "country_pair", "region_pair", "flight_op_carrier")
GO

ALTER TABLE "R7_countries_op_carrier" ADD CONSTRAINT "fk_R7_countries_op_carrier_country_pair_operating_carrier_dt_of_issue" FOREIGN KEY("country_pair", "operating_carrier", "dt_of_issue")
REFERENCES "R6" ("country_pair", "flight_op_carrier", "dt_of_issue")
GO

ALTER TABLE "R7_flights" ADD CONSTRAINT "fk_R7_flights_dt_of_issue_lead_bucket_op_carrier_flyFrom_leg_(AIRPORT)_flyTo_leg_(AIRPORT)" FOREIGN KEY("dt_of_issue", "lead_bucket", "op_carrier", "flyFrom_leg_(AIRPORT)", "flyTo_leg_(AIRPORT)")
REFERENCES "R6" ("dt_of_issue", "leadtime", "flight_op_carrier", "flyFrom_leg", "flyTo_leg")
GO

ALTER TABLE "R7_itineraries" ADD CONSTRAINT "fk_R7_itineraries_dt_of_issue_lead_bucket_od_pair_country_pair_region_pair_op_carrier" FOREIGN KEY("dt_of_issue", "lead_bucket", "od_pair", "country_pair", "region_pair", "op_carrier")
REFERENCES "R6" ("dt_of_issue", "leadtime", "od_pair", "country_pair", "region_pair", "flight_op_carrier")
GO

ALTER TABLE "R7_regions_op_carrier" ADD CONSTRAINT "fk_R7_regions_op_carrier_region_pair_operating_carrier_dt_of_issue" FOREIGN KEY("region_pair", "operating_carrier", "dt_of_issue")
REFERENCES "R6" ("region_pair", "flight_op_carrier", "dt_of_issue")
GO

