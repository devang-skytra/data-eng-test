declare sd DATE DEFAULT DATE'2021-04-18';
declare ed DATE DEFAULT DATE'2021-04-28';

declare sd_doi DATE DEFAULT DATE'2021-04-16';
declare ed_doi DATE DEFAULT DATE'2021-04-26';

declare fileString STRING DEFAULT 'IATA_daily_api_20210418,IATA_daily_api_20210419,IATA_daily_api_20210420,IATA_daily_api_20210421,IATA_daily_api_20210422,IATA_daily_api_20210423,IATA_daily_api_20210424,IATA_daily_api_20210425,';
SET fileString = CONCAT(fileString,'IATA_daily_api_20210426,IATA_daily_api_20210427,IATA_daily_api_20210428');

--select fileString;
/*
CALL iata_sp.sp_process_R1(fileString);
CALL iata_sp.sp_process_R2(fileString);
CALL iata_sp.sp_process_R3I3(fileString);


CALL matching_sp.sp_process_X6(fileString);
CALL matching_sp.sp_process_X7(sd, ed);


select FILE_SOURCE, COUNT(*) from matching.X6 where FIRST_FLIGHT_DATE_UTC >= '2021-04-18' GROUP BY 1 ORDER BY 1 DESC
select FILE_SOURCE, COUNT(*) from iata.X3 where dt_of_issue >'2021-04-24' GROUP BY 1 ORDER BY 1 DESC 
*/

CALL index_sp.sp_process_X8(sd, ed);
CALL index_sp.sp_process_X9(sd, ed);
CALL index_sp.sp_process_X11( ['2021-04-18','2021-04-19','2021-04-20','2021-04-21','2021-04-22','2021-04-23','2021-04-24','2021-04-25','2021-04-26','2021-04-27','2021-04-28'], 'index_models', 'index', 'index', 'index', FALSE );
--X11CheckAppend
    insert into airflow.af_check_X11
    select 20210429 ExecDate_INT,
    max(first_flight_date_utc) as first_flight_date_max,
    countif(first_flight_date_utc is null) as null_cnt,
    CURRENT_TIMESTAMP ts
    FROM index.X11
    WHERE first_flight_date_utc >= DATE_SUB(DATE'2021-04-29', INTERVAL 11 DAY);
--X11CheckOp 
        select 
        first_flight_date_max = DATE_SUB(DATE'2021-04-29', INTERVAL 1 DAY) ,
        null_cnt = 0 
        from airflow.af_check_X11 where ExecDate_INT = 20210429 and DATE(ts) = CURRENT_DATE() order by ts desc LIMIT 1;
--X12 is full rebuild so just run the sql from Airflow Rendered Output


CALL index_sp.sp_process_X8_doi_based(sd_doi, ed_doi);
CALL index_sp.sp_process_X9_doi(sd_doi, ed_doi);
CALL index_sp.sp_process_X11_doi( ['2021-04-16','2021-04-17','2021-04-18','2021-04-19','2021-04-20','2021-04-21','2021-04-22','2021-04-23','2021-04-24','2021-04-25','2021-04-26'], 'index_models', 'index', 'index', 'index', FALSE );
--X11_DOICheckAppend 
    insert into airflow.af_check_X11_DOI
    select 20210429 ExecDate_INT,
    max(dt_of_issue) as dt_of_issue_max,
    countif(dt_of_issue is null) as null_cnt,
    CURRENT_TIMESTAMP ts
    FROM index.X11_doi
    WHERE 
    dt_of_issue >= DATE_SUB(DATE'2021-04-29', INTERVAL 14 DAY);
--X11_DOICheckOp 
        select 
        dt_of_issue_max >= DATE_SUB(DATE'2021-04-29', INTERVAL 3 DAY) ,
        null_cnt = 0 
        from airflow.af_check_X11_DOI where ExecDate_INT = 20210429 and DATE(ts) = CURRENT_DATE() order by ts desc LIMIT 1;
--X11_max_flight_dateCheckAppend
    insert into airflow.af_check_X11_max_flight_date
    select 20210429 ExecDate_INT,
    max(first_flight_date_utc) as first_flight_date_max,
    count(*) as row_cnt,
    CURRENT_TIMESTAMP ts
    FROM index.X11
    WHERE 
    first_flight_date_utc >= DATE_SUB(DATE'2021-04-29', INTERVAL 14 DAY) ;
--X11_max_flight_dateCheckOp
        select 
        first_flight_date_max >= DATE_SUB(DATE'2021-04-29', INTERVAL 1 DAY) 
        --, row_cnt = 0 
        from airflow.af_check_X11_max_flight_date where ExecDate_INT = 20210429 and DATE(ts) = CURRENT_DATE() order by ts desc LIMIT 1;
--X11_missing_flight_dateCheckAppend 
    insert into airflow.af_checkX11_missing_flight_date
    with first as (select 20210429 ExecDate_INT, 
    DATE_DIFF(current_date()-1, DATE '2013-02-01', DAY) as days_diff, count(distinct first_flight_date_utc) as mycount 
    from index.X11 where first_flight_date_utc is not null)
    Select case (days_diff - mycount) WHEN 0 THEN True else False end as diff, ExecDate_INT, CURRENT_TIMESTAMP ts from first;
--X11_missing_flight_dateCheckOp 
        select diff 
        from airflow.af_checkX11_missing_flight_date where ExecDate_INT = 20210429 and DATE(ts) = CURRENT_DATE() order by ts desc LIMIT 1;
--X11_doi_missing_date_of_issueCheckAppend 
    insert into airflow.af_checkX11_doi_missing_date_of_issue
    with first as (select 20210429 ExecDate_INT, 
    DATE_DIFF(current_date()-3, DATE '2018-10-31', DAY) as days_diff, count(distinct dt_of_issue) as mycount 
    from index.X11_doi where dt_of_issue is not null)
    Select case (days_diff - mycount) WHEN 0 THEN True else False end as diff, ExecDate_INT, CURRENT_TIMESTAMP ts from first;
--X11_doi_missing_date_of_issueCheckOp 
        select diff 
        from airflow.af_checkX11_doi_missing_date_of_issue where ExecDate_INT = 20210429 and DATE(ts) = CURRENT_DATE() order by ts desc LIMIT 1;
--X12_doi is full rebuild so just run the sql from Airflow Rendered Output        


-- RESET  bq update --time_partitioning_expiration 432000 kiwi.X5a 

