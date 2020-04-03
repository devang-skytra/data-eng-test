
--https://skytra.atlassian.net/browse/IN-889

--in892
select EXTRACT(YEAR FROM dt_of_issue) as yr, FILE_SOURCE, count(*) FROM matching.X6 WHERE dt_of_issue >= "2000-01-01" group by 1,2 order by 1,2

--in890
bq mk --table --time_partitioning_field dt_of_issue --clustering_fields first_flight_date_utc,region_pair --schema ./matching.X6.json d-dat-digitalaircrafttransport:matching.X6_2020_bak

--conf results = those from above matching.X6 = TRUE
select EXTRACT(YEAR FROM dt_of_issue) as yr, FILE_SOURCE, count(*) FROM matching.X6_2020_bak WHERE dt_of_issue >= "2000-01-01" group by 1,2 order by 1,2

--in891
bq rm -f -t 'd-dat-digitalaircrafttransport:matching.X6$20200101'
--etc

--start in897
SELECT MIN(dt_of_issue), MAX(dt_of_issue) FROM iata.X1_2020_late_arriving_tickets

create iata_sp.sp_process_X3_MISSING
  iata_input AS(
    SELECT * EXCEPT(FILE_SOURCE), REPLACE(FILE_SOURCE, gcsPrefixRemove, '') AS FILE_SOURCE FROM iata.X1_2020_late_arriving_tickets


CALL iata_sp.sp_process_X3_MISSING('2015-03-06', '2019-12-21', 'FinalOutput_2020-01-01_w_2020-03-15_missing_tkts_Global', 'gs://ext-iata-excl-data/2020/unzipped/');

CALL iata_sp.sp_process_I1('2015-03-06', '2019-12-21', 'FinalOutput_2020-01-01_w_2020-03-15_missing_tkts_Global.csv');
etc

SELECT dt_of_issue, count(*) FROM iata.X1_2020_late_arriving_tickets group by 1 order by 1 desc	
--end in897

--in898
bq cp -a -n 'd-dat-digitalaircrafttransport:iata.X3$20200101' skytra-benchmark-prod:iata.X3

--in896 via airflow

--in900
paul_desmond@cloudshell:~ (d-dat-digitalaircrafttransport)$ bq cp -a -n 'd-dat-digitalaircrafttransport:iata.X3$20200101' skytra-benchmark-prod:iata.X3

BigQuery error in cp operation: Access Denied: Dataset skytra-benchmark-prod:iata: User does not have bigquery.tables.create permission for dataset skytra-benchmark-prod:iata.
