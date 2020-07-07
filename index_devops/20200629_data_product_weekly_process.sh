
# below working well (using sys tables)
#  another option in airflow would be get list .sql files in dags/sq/Dashboard subfolder
#  https://stackoverflow.com/questions/3207219/how-do-i-list-all-files-of-a-directory


bq cp index.X7 index.X7_run20200622
bq cp index.X7_IATA index.X7_IATA_run20200622
bq cp index.X7_composite_adjusted index.X7_composite_adjusted_run20200622


SELECT 
CONCAT( 'bq cp ', table_schema, '.', table_name, ' scratch_PaD_PreDeployBak_Expire14d.', table_name, '_20200629') as bq_bak 
FROM 
products_IN1139.
INFORMATION_SCHEMA.TABLES
--where table_name like 'P00%'
order by 1



cd indexproduction
git pull
git checkout feature/IN-1092-create-a-waterfall-pricing-mecha
cd bq/sq/Iata-revenue-pipeline/Products




SELECT 
CONCAT( 'cat ', table_name, '.sql | bq query --destination_table ', table_schema, '.', table_name, ' --replace --use_legacy_sql=false ') as bq_qry
FROM 
products_IN1139.
INFORMATION_SCHEMA.TABLES
--where table_name like 'P00%'
order by 1





# X7
select count(*) from index.X7             where first_flight_date between '2017-10-21' and '2020-06-17'
--29,065
select count(*) from index.X7             where first_flight_date > '2020-06-17'


select region_pair, count(*) from index.X7 where first_flight_date > '2020-06-17' group by 1 order by 2 desc  --only Africa-Latin America was done 1 row ie 209 rows should be 210
select * from index.X7_run20200622         where first_flight_date > '2020-06-17'


select count(*) from index.X7_run20200622 where first_flight_date between '2017-10-21' and '2020-06-17'
--29,066 vs 29,274 = 209 var


select 
region_pair, first_flight_date
--* EXCEPT(pl_id, metric_code,metric_value) 
from 
index.X7
--index.X7_run20200622 
where first_flight_date between '2017-10-21' and '2020-06-17'
EXCEPT DISTINCT (select region_pair, first_flight_date from index.X7_run20200622 where first_flight_date between '2017-10-21' and '2020-06-17')


select min(first_flight_date), max(first_flight_date), count(*) from index.X7 WHERE first_flight_date >= '2017-10-21' --2017-10-21 2020-06-24


# X7_IATA
--75532
--75726 
--select count(*) from index.X7_IATA_run20200622



),

uni2 AS ( select CAST( CAST( FORMAT_TIMESTAMP('%Y%m%d%H%M%E3S', CURRENT_TIMESTAMP) as NUMERIC) * 1000 as INT64) as iuid ),

  SELECT
  --it is not possible to pass airflow XCOM variables as a parameter as we do for standard python variables
  -- therefore have to take more direct task_instance-level approach (slightly inferior/less abstraction)
  iuid AS pl_id,

      ORDER BY first_flight_date, region_pair
  ), uni2



# X7_composite_adjusted
WITH 
vars as (
select
DATE'2020-03-09' italy_div_start,
DATE'2020-04-16' italy_div_end,
CAST(0.9824 as NUMERIC) EE_factor,
CAST(0.9917 as NUMERIC) EN_factor,
CAST(1.0060 as NUMERIC) AE_factor,
CAST(27 as INT64) rows_proceeding, --must hard-code x 2, BQL will only accept literal
DATE'2013-02-02' min_2013_date,
DATE'2017-10-19' min_2017_date,
DATE'2013-05-02' correl_2013_date
),

params AS (
  SELECT region_pair, intercept, slope, cut_date
  FROM generic.index_lin_reg_params_ext
  ORDER BY calibration_date
  LIMIT 6
),

modelled_iata_index as (
  SELECT x7.*, intercept+slope*IATA_RRPK_USD as modelled_skytra_index
  FROM index.X7_IATA x7
  INNER JOIN params
  ON x7.region_pair = params.region_pair
),

skytra_index_filt AS (
  SELECT x7.*, cut_date
  FROM index.X7 x7
  INNER JOIN params
  ON params.region_pair = x7.region_pair
),


skytra_date_cut AS (
  -- set skytra_index to NULL < date_cut
  SELECT first_flight_date, region_pair,
  IF(first_flight_date < cut_date, NULL, skytra_index) AS skytra_index
  FROM skytra_index_filt
),

modelled_skytra_index AS (
  SELECT 
    IFNULL(imod.first_flight_date, itrue.first_flight_date) AS first_flight_date,
    IFNULL(imod.region_pair, itrue.region_pair) AS region_pair,
    IFNULL(skytra_index, modelled_skytra_index) AS skytra_index
  FROM modelled_iata_index  imod
  FULL OUTER JOIN  skytra_date_cut  itrue
  ON imod.region_pair =  itrue.region_pair
  AND imod.first_flight_date =  itrue.first_flight_date
),

modelled_skytra_index_with_divisor AS (
  SELECT
    region_pair,
    first_flight_date,
    ---this introduces the divisor for the lack of italian airports
    CASE
        WHEN region_pair = 'Europe-Europe' AND first_flight_date > vars.italy_div_start AND first_flight_date < vars.italy_div_end THEN skytra_index * vars.EE_factor
        WHEN region_pair = 'Europe-North America' AND first_flight_date > vars.italy_div_start AND first_flight_date < vars.italy_div_end THEN skytra_index * vars.EN_factor
        WHEN region_pair = 'Asia/Pacific-Europe' AND first_flight_date > vars.italy_div_start AND first_flight_date < vars.italy_div_end THEN skytra_index * vars.AE_factor
        ELSE skytra_index
    END AS skytra_index
  FROM modelled_skytra_index, vars
),

final_skytra_index AS (
  SELECT
    *,
    AVG(skytra_index) OVER (PARTITION BY region_pair ORDER BY first_flight_date ROWS BETWEEN 27 PRECEDING AND CURRENT ROW) AS skytra_benchmark
  FROM modelled_skytra_index_with_divisor
),

trimmed_final_skytra_index AS (
  SELECT region_pair, first_flight_date, skytra_index,
    IF(DATE_SUB(first_flight_date, INTERVAL 27 DAY) < vars.min_2013_date, NULL, skytra_benchmark) as skytra_benchmark
  FROM final_skytra_index, vars
),

issued_modelled_iata_index as (
  SELECT x7.*, (intercept + slope * iata_index) as modelled_skytra_index, cut_date
  FROM index.X7_DOI_no_spot x7
  INNER JOIN params
  ON x7.region_pair = params.region_pair
),

issued_skytra_index_filt AS (
  SELECT * EXCEPT(modelled_skytra_index)
  FROM issued_modelled_iata_index
),


issued_skytra_date_cut AS (
  -- set skytra_index to NULL < date_cut
  SELECT dt_of_issue, region_pair,
  IF(dt_of_issue < cut_date, NULL, skytra_index) AS skytra_index
  FROM issued_skytra_index_filt
),

issued_modelled_skytra_index AS (
  SELECT 
    IFNULL(imod.dt_of_issue, itrue.dt_of_issue) AS dt_of_issue,
    IFNULL(imod.region_pair, itrue.region_pair) AS region_pair,
    IFNULL(itrue.skytra_index, modelled_skytra_index) AS skytra_index
  FROM issued_modelled_iata_index  imod
  FULL OUTER JOIN  issued_skytra_date_cut  itrue
  ON imod.region_pair =  itrue.region_pair
  AND imod.dt_of_issue =  itrue.dt_of_issue
),

final_issued_skytra_index AS (
  SELECT *, 
  AVG(skytra_index) OVER 
          (PARTITION BY region_pair ORDER BY dt_of_issue ROWS BETWEEN 27 PRECEDING AND CURRENT ROW) as skytra_benchmark
  FROM issued_modelled_skytra_index
),

trimmed_final_issued_skytra_index AS (
SELECT region_pair, dt_of_issue, skytra_index,
  IF(DATE_SUB(dt_of_issue, INTERVAL 27 DAY) < vars.min_2017_date, NULL, skytra_benchmark) as skytra_benchmark
FROM final_issued_skytra_index, vars
),

trimmed_final_iata_index AS (
  SELECT *,
  IF(DATE_SUB(first_flight_date, INTERVAL 27 DAY) < vars.min_2013_date, NULL, 
    AVG(IATA_RRPK_USD) OVER 
          (PARTITION BY region_pair ORDER BY first_flight_date ROWS BETWEEN 27 PRECEDING AND CURRENT ROW)) as iata_benchmark
  FROM index.X7_IATA, vars
),

final_index AS (
  SELECT
  ffd.region_pair, 
  ffd.first_flight_date, 
  ffd.skytra_index, 
  ffd.skytra_benchmark,
  doi.skytra_index as skytra_issued_index, 
  doi.skytra_benchmark as skytra_issued_benchmark,
  fii. IATA_RRPK_USD as iata_index, 
  fii.iata_benchmark
  FROM trimmed_final_skytra_index as ffd
  LEFT JOIN trimmed_final_issued_skytra_index as doi
  ON ffd.first_flight_date=doi.dt_of_issue AND ffd.region_pair=doi.region_pair
  LEFT JOIN trimmed_final_iata_index as fii
  ON ffd.first_flight_date=fii.first_flight_date AND ffd.region_pair=fii.region_pair
),

final_correlation AS (
  SELECT *,
  CORR(skytra_index, iata_index) OVER 
          (PARTITION BY region_pair ORDER BY first_flight_date ROWS BETWEEN 89 PRECEDING AND CURRENT ROW) as index_correl,
  CORR(skytra_benchmark, iata_benchmark) OVER 
          (PARTITION BY region_pair ORDER BY first_flight_date ROWS BETWEEN 89 PRECEDING AND CURRENT ROW) as benchmark_correl
  FROM final_index
),

trimmed_final_correlation AS (
  SELECT * EXCEPT(index_correl, benchmark_correl),
  IF(DATE_SUB(first_flight_date, INTERVAL 89 DAY) < vars.correl_2013_date, NULL, index_correl) as index_correl,
  IF(DATE_SUB(first_flight_date, INTERVAL 89 DAY) < vars.correl_2013_date, NULL, benchmark_correl) as benchmark_correl
  FROM final_correlation, vars
)

--uni2 AS ( select CAST( CAST( FORMAT_TIMESTAMP('%Y%m%d%H%M%E3S', CURRENT_TIMESTAMP) as NUMERIC) * 1000 as INT64) as iuid )
--ptn  AS ( select DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) as tomoz )

--SELECT iuid AS pl_id, * EXCEPT(iuid) FROM (
  SELECT
  --it is not possible to pass airflow XCOM variables as a parameter as we do for standard python variables
  -- therefore have to take more direct task_instance-level approach (slightly inferior/less abstraction) 
  --iuid AS pl_id,
  region_pair, 
  first_flight_date as date, 
  CAST( skytra_index as NUMERIC) as skytra_index, 
  CAST( skytra_benchmark as NUMERIC) as skytra_benchmark,
  CAST( skytra_issued_index as NUMERIC) as skytra_issued_index, 
  CAST( skytra_issued_benchmark as NUMERIC) as skytra_issued_benchmark,
  CAST( index_correl as NUMERIC) as index_correl, 
  CAST( benchmark_correl as NUMERIC) as benchmark_correl
  --, '' as metric_code, CAST(0.0 as NUMERIC) as metric_value
  FROM trimmed_final_correlation
  WHERE first_flight_date < '2020-06-25' 
  
  
  
  
# COMPLIANCE
#=======================================================================================

SELECT 
CONCAT( 'bq cp ', table_schema, '.', table_name, ' scratch_PaD_PreDeployBak_Expire14d.', table_name, '_20200629') as bq_bak 
FROM compliance_dashboard_IN1194.INFORMATION_SCHEMA.TABLES
where table_name like 'D%' or table_name like 'QC%'
order by 1


bq cp compliance_dashboard_IN1194.D_First_time_inbound_airport scratch_PaD_PreDeployBak_Expire14d.D_First_time_inbound_airport_20200629
bq cp compliance_dashboard_IN1194.D_First_time_itinerary scratch_PaD_PreDeployBak_Expire14d.D_First_time_itinerary_20200629
bq cp compliance_dashboard_IN1194.D_First_time_outbound_airport scratch_PaD_PreDeployBak_Expire14d.D_First_time_outbound_airport_20200629
bq cp compliance_dashboard_IN1194.D_Iata_X6_merge scratch_PaD_PreDeployBak_Expire14d.D_Iata_X6_merge_20200629
bq cp compliance_dashboard_IN1194.D_Matching_rate_per_OD scratch_PaD_PreDeployBak_Expire14d.D_Matching_rate_per_OD_20200629
bq cp compliance_dashboard_IN1194.D_Matching_rate_per_country scratch_PaD_PreDeployBak_Expire14d.D_Matching_rate_per_country_20200629
bq cp compliance_dashboard_IN1194.D_Matching_rate_per_op_carrier scratch_PaD_PreDeployBak_Expire14d.D_Matching_rate_per_op_carrier_20200629
bq cp compliance_dashboard_IN1194.D_flight_capacity scratch_PaD_PreDeployBak_Expire14d.D_flight_capacity_20200629
bq cp compliance_dashboard_IN1194.D_issues_refunds_canc_perflight scratch_PaD_PreDeployBak_Expire14d.D_issues_refunds_canc_perflight_20200629
bq cp compliance_dashboard_IN1194.QC_exchanges_issues_refunds scratch_PaD_PreDeployBak_Expire14d.QC_exchanges_issues_refunds_20200629




cd indexproduction
# git pull
git checkout Develop
cd bq/sq/Dashboards


# in fact i* queries are run before f* before m* and special order within these so order manually
#  and need to prefix with xxx_ anyway
SELECT 
CONCAT( 'cat ', table_name, '.sql | bq query --destination_table ', table_schema, '.', table_name, ' --replace --use_legacy_sql=false ') as bq_qry
FROM compliance_dashboard_IN1194.INFORMATION_SCHEMA.TABLES
where table_name like 'D%' or table_name like 'QC%'
order by 1



cat 001_D_Iata_X6_merge.sql | bq query --destination_table compliance_dashboard_IN1194.D_Iata_X6_merge --replace --use_legacy_sql=false 
cat 002_D_issues_refunds_canc_perflight.sql | bq query --destination_table compliance_dashboard_IN1194.D_issues_refunds_canc_perflight --replace --use_legacy_sql=false 
cat 003_D_First_time_itinerary.sql | bq query --destination_table compliance_dashboard_IN1194.D_First_time_itinerary --replace --use_legacy_sql=false 
cat 004_D_First_time_outbound_airport.sql | bq query --destination_table compliance_dashboard_IN1194.D_First_time_outbound_airport --replace --use_legacy_sql=false 
cat 005_D_First_time_inbound_airport.sql | bq query --destination_table compliance_dashboard_IN1194.D_First_time_inbound_airport --replace --use_legacy_sql=false 
cat 006_D_flight_capacity.sql | bq query --destination_table compliance_dashboard_IN1194.D_flight_capacity --replace --use_legacy_sql=false 
cat 007_QC_exchanges_issues_refunds.sql | bq query --destination_table compliance_dashboard_IN1194.QC_exchanges_issues_refunds --replace --use_legacy_sql=false 
# NB: had to rename, ie put . to make .sql
cat 008_D_Matching_rate_per_OD.sql | bq query --destination_table compliance_dashboard_IN1194.D_Matching_rate_per_OD --replace --use_legacy_sql=false 
cat 009_D_Matching_rate_per_op_carrier.sql | bq query --destination_table compliance_dashboard_IN1194.D_Matching_rate_per_op_carrier --replace --use_legacy_sql=false 
cat 010_D_Matching_rate_per_country.sql | bq query --destination_table compliance_dashboard_IN1194.D_Matching_rate_per_country --replace --use_legacy_sql=false 

