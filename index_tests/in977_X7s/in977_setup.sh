
# use cloudshell and indexproduction cloned direct from BitBucket 

# how skytra-benchmark-devandtest:scratch_PaD works
#-----------------------------
# scratch_PaD.log_sql_RECON is the key linking everything together for reveiwers - shows details of the test case and the # automated history of testing of new code vs as at time hotfix_production code linked to BitB branch
#   scratch_PaD.in127_X4_RECON - single parquet file for fast test iteration day results - empty = no effect SUCCESS
#   scratch_PaD.in127_full_X4_RECON - full day results - empty = no effect SUCCESS

gcloud config set core/project skytra-benchmark-rnd
#gcloud config set core/project d-dat-digitalaircrafttransport

# FIRST STEP GIT PULL
cd indexproduction
git pull origin
brnch="IN-1091-update-x7-research-license-4.4.0"
git checkout $brnch


# VARIABLES primary
dsTest="scratch_PaD"
dt="2020-04-01"
ds="index"
tb="X7_composite_adjusted_v4_4"
tpf=""

inPrefix="in977_"

spfile="stat_sp.sp_metric_insert.sql"
spbfile="stat_sp.sp_metric_insertBash.sql"

# derived VARIABLES
ds_pref=$dsTest.$inPrefix
ds_tb=$ds_pref$tb
jfile="bq/t/"$ds.$tb".json"
mkPtn=""

qfile="X7_researchlicense_4_4.sql"
bfile="X7_researchlicense_4_4bash.sql"


# X2 load - if testing right from GCS load, then uncomment and load into $dsTest [IDEMPOTENT]
#bq load --replace --source_format=PARQUET $dsTest.$inPrefix'X2' "gs://ext-kiwi-excl-dev-data/data/"$dtGCS"*.gz.parquet"

# X4 [IDEMPOTENT] rm and mk in case new X4.json/.sh 
bq rm -t -f $dsTest.$inPrefix$tb

# If needed, manually create a baseline table using previous version of code
#   bq mk --table $mkPtn --schema $jfile $dsTest.$baseline

# IMPORTANT to use partitioning and test .sh/.json so rather than --append_table to create table, modify $jfile and do a bq mk table
#   exclude partition expiry from source because test data is old and would hide results
bq mk --table $mkPtn --schema $jfile $ds_tb


# IF .json fixed and needs re-apply, use this after git pull origin
#   bq update --schema $jfile $ds_tb

# Use *bash.sql version, located in path above, to test pipeline query
#   below sample parameters indicate STRING is default so no need for '' in *bash.sql version?
#   --parameter=corpus::romeoandjuliet --parameter=min_word_count:INT64:250 
# Like procs, query gives error 'Query parameters cannot be used in place of table names at...'
#   so just sed the table name and in fact all params using af/sq

cd ~/indexproduction/af/dags/sq
cp $qfile $bfile

# NB: sometimes add non-Airflow param at end of sed to reduce data volume further  
#   -e 's/list) < 7/list) < 2 AND ind_sid = 2/g'
sed -i  -e 's/FROM index/FROM d-dat-digitalaircrafttransport.index/g' \
        -e 's/FROM generic/FROM d-dat-digitalaircrafttransport.generic/g' \
        -e 's/{{ params.date }}/'$dt'/g' \
$bfile


# Partition Purging if needed and  APPEND
#bq rm -f -t 'skytra-benchmark-devandtest:'$ds_tb'$'"${dt//-/}"
bq query --location=EU --append_table --use_legacy_sql=false --destination_table $ds_tb "$(cat $bfile)"

# Delete temp $bfile so branch is kept clean
rm $bfile

#check results
sql="with 
x   as (select region_pair, date as first_flight_date, FARM_FINGERPRINT( CONCAT(skytra_index, skytra_benchmark, skytra_issued_index, skytra_issued_benchmark) ) AS row_fingerprint 
from d-dat-digitalaircrafttransport.index.X7_composite_adjusted where date = '"$dt"'), 

xin as (select region_pair, first_flight_date, FARM_FINGERPRINT( CONCAT(skytra_index, skytra_benchmark, skytra_issued_index, skytra_issued_benchmark) ) AS row_fingerprint 
from "$ds_tb" where first_flight_date = '"$dt"') 

SELECT 
x.region_pair, x.first_flight_date, x.row_fingerprint,
xin.region_pair as xin_region_pair, xin.first_flight_date as xin_first_flight_date, xin.row_fingerprint as xin_row_fingerprint, x.row_fingerprint = xin.row_fingerprint as match
from x full outer join xin on x.region_pair = xin.region_pair"

bq query --location=EU --append_table --use_legacy_sql=false --destination_table $ds_tb'_RECON' $sql 

# LOG $sql
#   scratch_PaD.log_sql_RECON(jira STRING, checked_out STRING, GCSfilter STRING, sql STRING, ts TIMESTAMP)
sqll=$(echo "$sql" | sed "s/'//g")
log="select '"$inPrefix"' jira,'"$brnch"' checked_out,'"$dtGCS"' GCSfilter,'"$sqll"' sql,CURRENT_TIMESTAMP() ts"

bq query --location=EU --append_table --use_legacy_sql=false --destination_table scratch_PaD.log_sql_RECON $log
 
 
# DEPLOY  then  CALL $dsTest.sp_metric_insert.sql
#   NB: ignore bigquery.jobs.list error, that's because cli attempts to return results for feedback
cd ~/indexproduction/bq/r/sp/
cp $spfile $spbfile
#-e 's/'$ds.$tb' where first_flight_date = tomorrow;/'$ds_tb' where first_flight_date = tomorrow;/g' 
sed -i  -e 's/'$ds'/'$dsTest'/g' \
        -e 's/'$tb'/'$inPrefix$tb'/g' \
        -e 's/stat_sp/'$dsTest'/g' \
$spbfile

bq query --location=EU --use_legacy_sql=false "$(cat $spbfile)"
bq query --location=EU --use_legacy_sql=false "CALL "$dsTest".sp_metric_insert('"$dsTest"', '"$inPrefix$tb"', '"$dt"');"

# Delete temp $bfile so branch is kept clean
rm $spbfile

#-------------------------
source of truth = d-dat-digitalaircrafttransport.index.X7_composite_adjusted

**test successful  in skytra-benchmark-rnd:**

test details   = scratch_PaD.log_sql_RECON
logging        = log.proc_log

test output    = scratch_PaD.in977_X7_composite_adjusted_v4_4

no effect test = scratch_PaD.in977_X7_composite_adjusted_v4_4_RECON
                (look for match = true and no blank cells from outer join)
                
attach screenshot of no effect test table                
                
#-------------------------                
                
"""
SELECT * FROM `skytra-benchmark-devandtest.log.proc_load` WHERE DATE(_PARTITIONTIME) = '2020-04-13' order by 1 desc

select 
md.metric_name, m.*
from 
stat.metric m
inner join stat.metric_dim md on m.metric_id = md.metric_id
where md.metric_name like '%X2%' and m.metric_tx_date = '2020-04-13' 
order by m.pl_id desc, md.metric_id
"""


