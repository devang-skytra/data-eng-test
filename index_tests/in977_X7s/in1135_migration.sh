
1 Desmo - mc + mv fields check in PROD
--X7_IATA, X7  ** have these2 fields, 
--X7_RL_4_4, X7_DOI_no_spot ** do not (however neither of these are used)

2 
*********************************************
migrate table name (where required) and use NUMERIC and remove metric fields - then DELETE orig table
*********************************************
X7_composite_adjusted --> X7_RL_4_4 (truncate dest first OR --replace)
X7_dt_of_issue --> X7_DOI_no_spot (truncate dest first OR --replace)
X7 (use NUMERIC and remove metric fields)
X7_IATA (use NUMERIC and remove metric fields)


3 Paulo - in looks like no equivalent SQL for af/sq/X7 4x RL tables.sql in bq/sq?
Therefore Paulo, can I confirm you are using af/sq/X7s in your weekly process?
Also, there will be minor fixes to these, so you should pull these each week and use fresh

4 Desmo - check for explicit CAST()
small fixes required (do this first and then separate jira for .sql rename to synch with t name and hence small DAG changes for renamed sql)

5 Desmo - separate jira for .sql rename to synch with t name

6 Paulo  - please confirm if you are using X7_DOI_no_spot.sql  Our last conversation was... 
"X7_IATA_dt_of_issue.sql -> index.X7_IATA_DOI_no_spot (NEW table, does not exist)"
is that still the case?

7 Paulo - check if any unneeded tables in index? Any table that is not in bq/t should not be in a Production dataset. Better to put in something like "index_PreProd" 
Otherwise, gets very confusing come deployment time otherwise and not compatible with DevOps.

8 Desmo - confirm that as long as field names match during insert, field order does not matter


# Backup
#=================================================================

ds=index
dszzz=zzz_PreDeployBak_Expire14d
tb=X7
tbd=$pfx'X7'
bq cp $ds.$tb $dszzz.$tbd
#bq rm -t -f $ds.$tb

tb=X7_IATA_index_2013_2020
tbd=$pfx'X7_IATA'
bq cp $ds.$tb $dszzz.$tbd
#bq rm -t -f $ds.$tb

#NEW table, does not exist

tb=X7_dt_of_issue
tbd=$pfx'X7_DOI_no_spot'
bq cp $ds.$tb $dszzz.$tbd
#bq rm -t -f $ds.$tb

tb=X7_composite_adjusted
tbd=$pfx'X7_RL_4_4'
bq cp $ds.$tb $dszzz.$tbd
#bq rm -t -f $ds.$tb







# MANUAL TABLES, NUMERIC MIGRATION
#=================================================================

X7.sql -> index.X7
X7_IATA.sql -> index.X7_IATA (was X7_IATA_index_2013_2020)
X7_IATA_dt_of_issue.sql -> index.X7_IATA_DOI_no_spot (NEW table, does not exist)
X7_dtissue_no_spot_window.sql (in DEV branch) -> index.X7_DOI_no_spot
X7_researchlicense_4_4_0.sql -> index.X7_RL_4_4
====================================================================================================

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



#gcloud config set core/project skytra-benchmark-rnd
#gcloud config set core/project d-dat-digitalaircrafttransport
#gcloud config set core/project skytra-benchmark-devandtest

#cd indexproduction
#git pull origin
#brnch="IN-1091-update-af-dags-sq-for-logging-pa"
#git checkout $brnch

# VARIABLES primary
#ds="d-dat-digitalaircrafttransport:index"
#dsTest="scratch_PaD_EU"
#inPrefix="in113B_"

# derived VARIABLES
#ds_tb=$ds_pref$tb
#ds_pref=$dsTest.$inPrefix

