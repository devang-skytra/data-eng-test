bq query --location=EU --use_legacy_sql=false """
IF ( SELECT IFNULL(
        (SELECT creation_time < TIMESTAMP_SUB( CURRENT_TIMESTAMP, INTERVAL 
        {{ dag_run.conf['replacement_age_interval'] if dag_run else '1 DAY' }} ) 
        FROM {{ dag_run.conf['dset'] if dag_run else 'iata' }}.INFORMATION_SCHEMA.TABLES 
        WHERE table_name = 'ext_data'),
      TRUE) 
) THEN

    CREATE OR REPLACE EXTERNAL TABLE {{ dag_run.conf['dset'] if dag_run else 'iata' }}.ext_data 
    (
    TICKET_ID STRING,
    TICKETING_CARRIER STRING,
    TRANSACTION_CODE STRING,
    DT_OF_ISSUE STRING,
    CONJUNCTION_COMPANION STRING,
    E_TICKET_IND STRING,
    REG_SEG_FARE STRING,
    REG_FULL_FARE STRING,
    CLASS_OF_SERVICE STRING,
    CABIN_CLASS STRING,
    OD_CABIN_CLASS STRING,
    SIGN_AMT STRING,
    OLD_TICKET_ID STRING,
    EXCHANGE_DOC_NBR STRING,
    COUNTRY_CODE STRING,
    SEGMENT_ID STRING,
    TOT_COUPN2 STRING,
    COUPON_NUMBER STRING,
    ORIGIN_AIRPORT_CITY_CODE STRING,
    DESTINATION_AIRPORT_CITY_CODE STRING,
    STOPOVER_CODE STRING,
    FLIGHT_DATE STRING,
    FLIGHT_DEPART_TIME STRING,
    FLIGHT_ARRIVAL_DATE STRING,
    FLIGHT_ARRIVAL_TIME STRING,
    MKT_CARRIER_CODE STRING,
    MKT_CARRIER_FLT_NBR STRING,
    ORIGINAL_CURR_CODE STRING,
    CARRIER_TYPE STRING,
    FIRST_CLASS_SEAT_CNT STRING,
    BUSINESS_CLASS_SEAT_CNT STRING,
    ECONOMY_CLASS_SEAT_CNT STRING,
    OPERATING_CARRIER STRING,
    TRUE_ORIGIN STRING,
    BASE_FARE STRING,
    FARE_TYPE_INDICATOR STRING,
    SEGMENT_MILE STRING,
    OD_MILE STRING,
    DISTRIBUTION_CHANNEL STRING,
    SOURCE_CODE STRING,
    TICKET_DOCUMENT_AMOUNT STRING,
    DOC_AMOUNT_TYPE_INDICATOR STRING
    )
    OPTIONS(
    format = 'CSV',
    uris = ['gs://ext-iata-excl-data/data/*.csv'],
    skip_leading_rows = 1
    );
END IF;


IF ( SELECT IFNULL(
        (SELECT creation_time < TIMESTAMP_SUB( CURRENT_TIMESTAMP, INTERVAL 
        {{ dag_run.conf['replacement_age_interval'] if dag_run else '1 DAY' }} ) 
        FROM {{ dag_run.conf['dset'] if dag_run else 'iata' }}.INFORMATION_SCHEMA.TABLES 
        WHERE table_name = 'ext_data_gz_autodetect'),
      TRUE) 
) THEN

    CREATE OR REPLACE EXTERNAL TABLE {{ dag_run.conf['dset'] if dag_run else 'iata' }}.ext_data_gz_autodetect 
    (
    TICKET_ID STRING,
    TICKETING_CARRIER STRING,
    TRANSACTION_CODE STRING,
    DT_OF_ISSUE STRING,
    CONJUNCTION_COMPANION STRING,
    E_TICKET_IND STRING,
    REG_SEG_FARE STRING,
    REG_FULL_FARE STRING,
    CLASS_OF_SERVICE STRING,
    CABIN_CLASS STRING,
    OD_CABIN_CLASS STRING,
    SIGN_AMT STRING,
    OLD_TICKET_ID STRING,
    EXCHANGE_DOC_NBR STRING,
    COUNTRY_CODE STRING,
    SEGMENT_ID STRING,
    TOT_COUPN2 STRING,
    COUPON_NUMBER STRING,
    ORIGIN_AIRPORT_CITY_CODE STRING,
    DESTINATION_AIRPORT_CITY_CODE STRING,
    STOPOVER_CODE STRING,
    FLIGHT_DATE STRING,
    FLIGHT_DEPART_TIME STRING,
    FLIGHT_ARRIVAL_DATE STRING,
    FLIGHT_ARRIVAL_TIME STRING,
    MKT_CARRIER_CODE STRING,
    MKT_CARRIER_FLT_NBR STRING,
    ORIGINAL_CURR_CODE STRING,
    CARRIER_TYPE STRING,
    FIRST_CLASS_SEAT_CNT STRING,
    BUSINESS_CLASS_SEAT_CNT STRING,
    ECONOMY_CLASS_SEAT_CNT STRING,
    OPERATING_CARRIER STRING,
    TRUE_ORIGIN STRING,
    BASE_FARE STRING,
    FARE_TYPE_INDICATOR STRING,
    SEGMENT_MILE STRING,
    OD_MILE STRING,
    DISTRIBUTION_CHANNEL STRING,
    SOURCE_CODE STRING,
    TICKET_DOCUMENT_AMOUNT STRING,
    DOC_AMOUNT_TYPE_INDICATOR STRING
    )
    OPTIONS(
    format = 'CSV',
    compression= 'GZIP',
    uris = ['gs://ext-iata-excl-data/data/*.csv.gz'],
    skip_leading_rows = 1
    );
END IF;


IF ( SELECT IFNULL(
        (SELECT creation_time < TIMESTAMP_SUB( CURRENT_TIMESTAMP, INTERVAL 
        {{ dag_run.conf['replacement_age_interval'] if dag_run else '1 DAY' }} ) 
        FROM {{ dag_run.conf['dset'] if dag_run else 'stat' }}.INFORMATION_SCHEMA.TABLES 
        WHERE table_name = 'iata_stats'),
      TRUE) 
) THEN

    CREATE OR REPLACE EXTERNAL TABLE {{ dag_run.conf['dset'] if dag_run else 'stat' }}.iata_stats 
    OPTIONS(
    format = 'CSV',
    uris = ['gs://ext-iata-excl-stat/stat/*.csv'],
    skip_leading_rows = 1
    );
END IF;


IF ( SELECT IFNULL(
        (SELECT creation_time < TIMESTAMP_SUB( CURRENT_TIMESTAMP, INTERVAL 
        {{ dag_run.conf['replacement_age_interval'] if dag_run else '1 DAY' }} ) 
        FROM {{ dag_run.conf['dset'] if dag_run else 'stat' }}.INFORMATION_SCHEMA.TABLES 
        WHERE table_name = 'kiwi_stats'),
      TRUE) 
) THEN

    CREATE OR REPLACE EXTERNAL TABLE {{ dag_run.conf['dset'] if dag_run else 'stat' }}.kiwi_stats 
    (
    metric_name STRING,
    metric_value INTEGER
    )
    OPTIONS(
    format = 'CSV',
    uris = ['gs://ext-kiwi-excl-stat/stats/*.csv'],
    skip_leading_rows = 0
    );
END IF;
"""
