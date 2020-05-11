
gcloud config set core/project skytra-benchmark-rnd
gcloud config set core/project skytra-benchmark-devandtest
#gcloud config set core/project d-dat-digitalaircrafttransport


# VARIABLES primary
dsTest="scratch_PaD_EU"
ds="d-dat-digitalaircrafttransport.index"
tb="X7_composite_adjusted_v4_4"
inPrefix="in1135_"

# derived VARIABLES
ds_pref=$dsTest.$inPrefix
ds_tb=$ds_pref$tb


#check results -  X7_composite_adjusted
#=================================================================
sql="with 
x   as (select region_pair, date as first_flight_date, FARM_FINGERPRINT( CONCAT(skytra_index, skytra_benchmark, skytra_issued_index, skytra_issued_benchmark) ) AS row_fingerprint 
from d-dat-digitalaircrafttransport.index.X7_composite_adjusted where date = '"$dt"'), 

xin as (select region_pair, first_flight_date, FARM_FINGERPRINT( CONCAT(skytra_index, skytra_benchmark, skytra_issued_index, skytra_issued_benchmark) ) AS row_fingerprint 
from "$ds_tb" where first_flight_date = '"$dt"') 

SELECT 
x.region_pair, x.first_flight_date, x.row_fingerprint,
xin.region_pair as xin_region_pair, xin.first_flight_date as xin_first_flight_date, xin.row_fingerprint as xin_row_fingerprint, x.row_fingerprint = xin.row_fingerprint as match
from x full outer join xin on x.region_pair = xin.region_pair and x.first_flight_date = xin.first_flight_date"

bq query --location=EU --append_table --use_legacy_sql=false --destination_table $ds_tb'_RECON' $sql 

# LOG $sql
#   scratch_PaD.log_sql_RECON(jira STRING, checked_out STRING, GCSfilter STRING, sql STRING, ts TIMESTAMP)
sqll=$(echo "$sql" | sed "s/'//g")
log="select '"$inPrefix"' jira,'"$brnch"' checked_out,'NA' GCSfilter,'"$sqll"' sql,CURRENT_TIMESTAMP() ts"

bq query --location=EU --append_table --use_legacy_sql=false --destination_table scratch_PaD_EU.log_sql_RECON $log


#check results -  X7
#=================================================================
tb="X7"
ds_pref=$dsTest.$inPrefix
ds_tb=$ds_pref$tb
 
sql="with 
x   as (select region_pair, first_flight_date, FARM_FINGERPRINT( CONCAT( ROUND(iata_index,4), ROUND(skytra_index,4), ROUND(iata_rpk,1), ROUND(skytra_rpk,1), ROUND(iata_tickets,4), ROUND(skytra_tickets,4), ROUND(skytra_coverage,4) ) ) AS row_fingerprint 
from "$ds"."$tb"), 

xin as (select region_pair, first_flight_date, FARM_FINGERPRINT( CONCAT( ROUND(iata_index,4), ROUND(skytra_index,4), ROUND(iata_rpk,1), ROUND(skytra_rpk,1), ROUND(iata_tickets,4), ROUND(skytra_tickets,4), ROUND(skytra_coverage,4) ) ) AS row_fingerprint 
from "$ds_tb") 

SELECT 
x.region_pair, x.first_flight_date, x.row_fingerprint,
xin.region_pair as xin_region_pair, xin.first_flight_date as xin_first_flight_date, xin.row_fingerprint as xin_row_fingerprint, x.row_fingerprint = xin.row_fingerprint as match
from x full outer join xin on x.region_pair = xin.region_pair and x.first_flight_date = xin.first_flight_date"

bq query --location=EU --append_table --use_legacy_sql=false --destination_table $ds_tb'_RECON' $sql 

# LOG $sql
#   scratch_PaD.log_sql_RECON(jira STRING, checked_out STRING, GCSfilter STRING, sql STRING, ts TIMESTAMP)
sqll=$(echo "$sql" | sed "s/'//g")
log="select '"$inPrefix"' jira,'"$brnch"' checked_out,'NA' GCSfilter,'"$sqll"' sql,CURRENT_TIMESTAMP() ts"

bq query --location=EU --append_table --use_legacy_sql=false --destination_table scratch_PaD_EU.log_sql_RECON $log

 



#-------------------------
source of truth = d-dat-digitalaircrafttransport.index.X7_composite_adjusted

**test successful  in skytra-benchmark-rnd:**

test details   = scratch_PaD.log_sql_RECON



# MANUAL TABLES, NUMERIC MIGRATION
#=================================================================

suffix="_pre_NUM_migrate"

ds="index"
tb="X7"
tbd=$tb$suffix
bq cp $ds.$tb $ds.$tbd

tb="X7_IATA_index_2013_2020"
tbd="X7_IATA_2013_2020"$suffix
bq cp $ds.$tb $ds.$tbd

tb="X7_dt_of_issue"
tbd="X7_IATA_dt_of_issue"$suffix
bq cp $ds.$tb $ds.$tbd

tb="X7_composite_adjusted"
tbd="X7_composite_adjusted_v4_4"$suffix
bq cp $ds.$tb $ds.$tbd




# ADDITIONAL SETUP
#=================================================================
tb="X7"
tbd=$tb
bq cp $ds.$tb $dsTest.$tbd

tb="X7_IATA_index_2013_2020"
tbd="X7_IATA_2013_2020"
bq cp $ds.$tb $dsTest.$tbd

tb="X7_dt_of_issue"
tbd="X7_IATA_dt_of_issue"
bq cp $ds.$tb $dsTest.$tbd

tb="X7_composite_adjusted"
tbd="X7_composite_adjusted_v4_4"
bq cp $ds.$tb $dsTest.$tbd


t1=airflow_params_X7
t2=X7
t3=X7_IATA_dt_of_issue
t4=X7_IATA_2013_2020
t5=X7_composite_adjusted_v4_4


bq cp index.$t1 scratch_PaD_EU.in1135_$t1
bq cp index.$t2 scratch_PaD_EU.in1135_$t2
bq cp index.$t3 scratch_PaD_EU.in1135_$t3
bq cp index.$t4 scratch_PaD_EU.in1135_$t4
bq cp index.$t5 scratch_PaD_EU.in1135_$t5

x6=X6
bq cp d-dat-digitalaircrafttransport:matching.$x6 matching.$x6


# GENERIC TABLES

select CONCAT('bq cp generic.', table_id, ' generic_nonEU.', table_id) as cmd from generic.__TABLES__

bq cp d-dat-digitalaircrafttransport:generic.ext_EURUSD generic.ext_EURUSD
bq cp d-dat-digitalaircrafttransport:generic.index_lin_reg_params_ext generic.index_lin_reg_params_ext
bq cp d-dat-digitalaircrafttransport:generic.spot_window_regions_ext generic.spot_window_regions_ext
# etc

# GENERIC EXTERNAL TABLES

bucket=fxrates
src='gs://'$bucket'/to/*.csv'
dst='gs://bq-generic-dev/'$bucket'/'
gsutil cp $src $dst

bucket=spot-windows
src='gs://'$bucket'/*.csv'
dst='gs://bq-generic-dev/'$bucket'/'
gsutil cp $src $dst

bucket=regression_parameters
bucket2=regression-parameters
src='gs://'$bucket'/*.csv'
dst='gs://bq-generic-dev/'$bucket2'/'
gsutil cp $src $dst


# MIGRATE BUCKET AND CONTENTS TO EU

temp=ext-iata-temp

bkt=ext-iata-excl-dev-stat
src='gs://'$bkt'/'
dst='gs://'$temp
dstSlash=$dst'/'
gsutil -m cp -r $src'*' $dstSlash
gsutil -m rm -r $src
gsutil mb -b on -c standard -l EU $src
gsutil -m cp -r $dstSlash'*' $src
gsutil -m rm -r $dst


# IATA TABLES

select CONCAT('bq cp d-dat-digitalaircrafttransport:iata.', table_id, ' iata.', table_id) as cmd from d-dat-digitalaircrafttransport.iata.__TABLES__
where table_id not like '%ext%'

bq cp d-dat-digitalaircrafttransport:iata.I1 iata.I1
bq cp d-dat-digitalaircrafttransport:iata.I2 iata.I2
bq cp d-dat-digitalaircrafttransport:iata.I3 iata.I3
bq cp d-dat-digitalaircrafttransport:iata.X3 iata.X3
bq cp d-dat-digitalaircrafttransport:iata.int_X1_file_analysis iata.int_X1_file_analysis




CREATE OR REPLACE PROCEDURE index_sp.sp_airflow_params_X7_CREATE_TABLE()
BEGIN
--Proc purpose is to provide checks & indicators to Airflow automation that the pre-req data exists and X7 processing is needed and from which date

  -- CALL index_sp.sp_airflow_params_X7_CREATE_TABLE();
  
  CREATE OR REPLACE TABLE index.airflow_params_X7 as ( 
    SELECT 
      X6_doi_max, 
      X7_ffd_max,

    # X7_ffd_nextFromDate tells us the dateFrom for next X7 process
      DATE_ADD(X7_ffd_max, INTERVAL 1 DAY) as X7_ffd_nextFromDate, 

    # X6_gt_X7 indicates X6 processing is in advance of X7 
      X6_doi_max > X7_ffd_max as X6_gt_X7, 

    # X6_fresh indicates X6 processing is recent and the pipeline is active and probably healthy
      X6_doi_max >= DATE_SUB(CURRENT_DATE, INTERVAL 6 DAY) as X6_fresh

    FROM 
    ( SELECT DATE'2020-04-29' as X6_doi_max ) as x6, 
    ( SELECT DATE'2020-04-25' as X7_ffd_max ) as x7 
  );
  
END



bq cp -a -n 'd-dat-digitalaircrafttransport:kiwi.X4$20200415' kiwi.X4
bq cp -a -n 'd-dat-digitalaircrafttransport:kiwi.X5a$20200415' kiwi.X5a
bq cp -a -n 'd-dat-digitalaircrafttransport:kiwi.X5b$20200415' kiwi.X5b

























