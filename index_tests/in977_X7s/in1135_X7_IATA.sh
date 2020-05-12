
#gcloud config set core/project skytra-benchmark-rnd
#gcloud config set core/project d-dat-digitalaircrafttransport

gcloud config set core/project skytra-benchmark-devandtest

cd indexproduction
git pull origin
brnch="IN-1091-update-af-dags-sq-for-logging-pa"
git checkout $brnch

bucket=fxrates
src='gs://'$bucket'/to/*.csv'
dst='gs://bq-generic-dev/'$bucket'/'
gsutil cp $src $dst


# VARIABLES primary
ds="d-dat-digitalaircrafttransport:index"
dsTest="scratch_PaD_EU"
inPrefix="in113B_"
dt="2020-04-01"

# X7
#=================================================================
tb="X7_IATA_index_2013_2020"
tbd="X7_IATA"
ds_pref=$dsTest.$inPrefix
ds_tb=$ds_pref$tbd

#jfile="bq/t/"$ds.$tb".json"
#jfile="bq/t/index.X7.json"

qfile="X7_IATA.sql"
bfile="X7_IATAbash.sql"

cd ~/indexproduction/af/dags/sq
cp $qfile $bfile

sed -i  -e "s/{{ ti.xcom_pull('Get-TsX7i')[0] }} AS pl_id/0 AS pl_id/g" \
$bfile

bq query --location=EU --replace --allow_large_results --use_legacy_sql=false --destination_table $ds_tb "$(cat $bfile)"

# Delete temp $bfile so branch is kept clean
rm $bfile





#fp="CONCAT( ROUND(iata_index,4), ROUND(skytra_index,4), ROUND(iata_rpk,1), ROUND(skytra_rpk,1), ROUND(iata_tickets,4), ROUND(skytra_tickets,4), ROUND(skytra_coverage,4) )"

dsdot=$(echo "$ds" | sed "s/:/./g")

uk="CONCAT( ifnull(region_pair,'null_rp'), '|', ifnull(first_flight_date,'2000-01-01') )"
fp="IFNULL ( CONCAT( round(IATA_RRPK_USD,4),'|',round(IATA_TOT_RPK,0),'|',iata_tickets), 'null_attr')"

sql="with 
x   as (select "$uk" as uk, "$fp" as attr, FARM_FINGERPRINT( "$fp" ) as fp 
from "$dsdot"."$tb"), 

xin as (select "$uk" as uk, "$fp" as attr, FARM_FINGERPRINT( "$fp" ) as fp 
from "$ds_tb") 

SELECT 
x.uk   as orig_ukey,   x.attr as orig_attr,   x.fp as orig_rowHash,
xin.uk as test_ukey, xin.attr as test_attr, xin.fp as test_rowHash, 
if(x.fp is null,0,x.fp) = if(xin.fp is null,0,xin.fp) as match
from x full outer join xin on x.uk = xin.uk"

bq query --location=EU --replace --use_legacy_sql=false --destination_table $ds_tb'_RECON' $sql 

# LOG $sql
#   scratch_PaD.log_sql_RECON(jira STRING, checked_out STRING, GCSfilter STRING, sql STRING, ts TIMESTAMP)
sqll=$(echo "$sql" | sed "s/'//g")
log="select '"$inPrefix"' jira,'"$brnch"' checked_out,'NA' GCSfilter,'"$sqll"' sql,CURRENT_TIMESTAMP() ts"

bq query --location=EU --append_table --use_legacy_sql=false --destination_table scratch_PaD_EU.log_sql_RECON $log

 

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






















