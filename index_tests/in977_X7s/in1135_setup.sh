
#gcloud config set core/project skytra-benchmark-rnd
#gcloud config set core/project d-dat-digitalaircrafttransport

gcloud config set core/project skytra-benchmark-devandtest

cd indexproduction
git pull origin
brnch="IN-1091-update-af-dags-sq-for-logging-pa"
git checkout $brnch


# VARIABLES primary
ds="d-dat-digitalaircrafttransport:index"
dsTest="scratch_PaD_EU"
inPrefix="in113B_"

# derived VARIABLES
ds_tb=$ds_pref$tb
ds_pref=$dsTest.$inPrefix



# SETUP
#=================================================================
tb="X7_new"
tbd="X7"
bq cp $ds.$tb $ds_pref$tbd

tb="X7_DOI_no_spot"
tbd=$tb
bq cp $ds.$tb $ds_pref$tbd

tb="X7_IATA"
tbd=$tb
bq cp $ds.$tb $ds_pref$tbd

tb="X7_IATA_DOI_no_spot"
tbd=$tb
bq cp $ds.$tb $ds_pref$tbd

tb="X7_RL_4_4"
tbd=$tb
bq cp $ds.$tb $ds_pref$tbd


gcloud config set core/project skytra-benchmark-devandtest


x6=matching.X6
bq rm -t -f $x6
bq cp d-dat-digitalaircrafttransport:$x6 $x6

i2=iata.I2
bq rm -t -f $i2
bq cp d-dat-digitalaircrafttransport:$i2 $i2


# X7
#=================================================================
tb="X7_new"
tbd="X7"
ds_tb=$ds_pref$tbd


#check results - X7


#fp="CONCAT( ROUND(iata_index,4), ROUND(skytra_index,4), ROUND(iata_rpk,4), ROUND(skytra_rpk,4), ROUND(iata_tickets,4), ROUND(skytra_tickets,4), ROUND(skytra_coverage,4) )"
uk="CONCAT( region_pair, '|', first_flight_date )"
fp="CONCAT( iata_index, skytra_index, iata_rpk, skytra_rpk, iata_tickets, skytra_tickets, skytra_coverage )"

sql="with 
x   as (select "$uk" as uk, FARM_FINGERPRINT( "$fp" ) as fp 
from "$ds"."$tb"), 

xin as (select "$uk" as uk, FARM_FINGERPRINT( "$fp" ) as fp 
from "$ds_tb") 

SELECT 
x.uk   as orig_ukey,   x.fp as orig_rowHash,
xin.uk as test_ukey, xin.fp as orig_rowHash, x.fp = xin.fp as match
from x full outer join xin on x.uk = xin.uk"

bq query --location=EU --append_table --use_legacy_sql=false --destination_table $ds_tb'_RECON' $sql 

# LOG $sql
#   scratch_PaD.log_sql_RECON(jira STRING, checked_out STRING, GCSfilter STRING, sql STRING, ts TIMESTAMP)
sqll=$(echo "$sql" | sed "s/'//g")
log="select '"$inPrefix"' jira,'"$brnch"' checked_out,'NA' GCSfilter,'"$sqll"' sql,CURRENT_TIMESTAMP() ts"

bq query --location=EU --append_table --use_legacy_sql=false --destination_table scratch_PaD_EU.log_sql_RECON $log

 

#check results - X7_RL_4_4
#=================================================================
tb="X7_new"
tbd="X7"
ds_tb=$ds_pref$tbd
dt="2020-05-11"

uk="CONCAT( region_pair, '|', date )"
fp="CONCAT( skytra_index, skytra_benchmark, skytra_issued_index, skytra_issued_benchmark )"

sql="with 
x   as (select "$uk" as uk, FARM_FINGERPRINT( "$fp" ) as fp 
from "$ds"."$tb" where date = '"$dt"'), 

xin as (select "$uk" as uk, FARM_FINGERPRINT( "$fp" ) as fp 
from "$ds_tb"    where date = '"$dt"')

SELECT 
x.uk   as orig_ukey,   x.fp as orig_rowHash,
xin.uk as test_ukey, xin.fp as orig_rowHash, x.fp = xin.fp as match
from x full outer join xin on x.uk = xin.uk"

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

X7.sql -> index.X7
X7_IATA.sql -> index.X7_IATA (was X7_IATA_index_2013_2020)
X7_IATA_dt_of_issue.sql -> index.X7_IATA_DOI_no_spot (NEW table, does not exist)
X7_dtissue_no_spot_window.sql (in DEV branch) -> index.X7_DOI_no_spot
X7_researchlicense_4_4_0.sql -> index.X7_RL_4_4
====================================================================================================


pfx=aaa_pre_NUM_migrate_

ds=index
tb=X7
tbd=$pfx'X7'
#bq cp $ds.$tb $ds.$tbd
bq rm -t -f $ds.$tb

tb=X7_IATA_index_2013_2020
tbd=$pfx'X7_IATA'
#bq cp $ds.$tb $ds.$tbd
bq rm -t -f $ds.$tb

#NEW table, does not exist

tb=X7_dt_of_issue
tbd=$pfx'X7_DOI_no_spot'
#bq cp $ds.$tb $ds.$tbd
bq rm -t -f $ds.$tb

tb=X7_composite_adjusted
tbd=$pfx'X7_RL_4_4'
#bq cp $ds.$tb $ds.$tbd
bq rm -t -f $ds.$tb


WITH tbls as ( 
SELECT table_schema, table_name FROM index.INFORMATION_SCHEMA.TABLES where table_name in ( 'X7', 'X7_IATA_index_2013_2020', 'X7_dt_of_issue', 'X7_composite_adjusted' )
),

cols as ( --INFORMATION_SCHEMA.TABLES INFORMATION_SCHEMA.COLUMNS INFORMATION_SCHEMA.COLUMN_FIELD_PATHS
SELECT * FROM index.INFORMATION_SCHEMA.COLUMNS WHERE table_name in(select table_name from tbls)
)

--select * from cols

select * from 
(
SELECT table_schema, table_name, CONCAT('bq query --location=EU --replace --use_legacy_sql=false --destination_table ', table_name, ' "select')  as c1, -1 as c2 FROM tbls
UNION ALL
SELECT table_schema, table_name, CONCAT('from ', table_name, '"')  as c1, 99 as c2 FROM tbls
UNION ALL
SELECT
table_schema, table_name, CONCAT( IF(data_type='FLOAT64',CONCAT('CAST(',column_name,' AS NUMERIC) as column_name'),column_name), ',' ) as c1, ordinal_position as c2
FROM cols
)
order by 1,2,4


#========APPEND

bq query --location=EU --append_table --use_legacy_sql=false --destination_table index.X7_new "select
pl_id,
region_pair,
first_flight_date,
CAST(iata_index AS NUMERIC) as iata_index,
CAST(skytra_index AS NUMERIC) as skytra_index,
CAST(iata_rpk AS NUMERIC) as iata_rpk,
CAST(skytra_rpk AS NUMERIC) as skytra_rpk,
iata_tickets,
skytra_tickets,
CAST(skytra_coverage AS NUMERIC) as skytra_coverage
from index.X7"

bq query --location=EU --append_table --use_legacy_sql=false --destination_table index.X7_IATA "select
region_pair,
first_flight_date,
CAST(IATA_RRPK_USD AS NUMERIC) as IATA_RRPK_USD,
CAST(IATA_TOT_RPK AS NUMERIC) as IATA_TOT_RPK,
iata_tickets
from index.X7_IATA_index_2013_2020"

bq query --location=EU --append_table --use_legacy_sql=false --destination_table index.X7_RL_4_4 "select
date,
region_pair,
CAST(skytra_index AS NUMERIC) as skytra_index,
CAST(skytra_benchmark AS NUMERIC) as skytra_benchmark,
CAST(skytra_issued_index AS NUMERIC) as skytra_issued_index,
CAST(skytra_issued_benchmark AS NUMERIC) as skytra_issued_benchmark
from index.X7_composite_adjusted"

bq query --location=EU --append_table --use_legacy_sql=false --destination_table index.X7_DOI_no_spot "select
region_pair,
dt_of_issue,
CAST(iata_index AS NUMERIC) as iata_index,
CAST(skytra_index AS NUMERIC) as skytra_index,
CAST(iata_rpk AS NUMERIC) as iata_rpk,
CAST(skytra_rpk AS NUMERIC) as skytra_rpk,
iata_tickets,
skytra_tickets,
CAST(skytra_coverage AS NUMERIC) as skytra_coverage
from index.X7_dt_of_issue"


# TO DO !!!!
bq cp index.X7_new index.X7






# ONE OFF DEV SETUP
#=================================================================
#=================================================================

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

























