
# use cloudshell and indexproduction cloned direct from BitBucket 

# how skytra-benchmark-devandtest:scratch_PaD works
#-----------------------------
# scratch_PaD.log_sql_RECON is the key linking everything together for reveiwers - shows details of the test case and the # automated history of testing of new code vs as at time hotfix_production code linked to BitB branch
#   scratch_PaD.in127_X4_RECON - single parquet file for fast test iteration day results - empty = no effect SUCCESS
#   scratch_PaD.in127_full_X4_RECON - full day results - empty = no effect SUCCESS


# FIRST STEP GIT PULL
cd indexproduction
git pull origin
brnch="feature/IN-127-x2-rows-from-kiwi"
git checkout $brnch


# VARIABLES primary
dsTest="scratch_PaD"
dt="2020-04-01"
ds="kiwi"
tb="X4"
tpf="search_date"

inPrefix="in127_full_"
dtGCS="y=2020/m=04/d=01"
baseline="X4_20200401"
#inPrefix="in127_"
#dtGCS="y=2020/m=04/d=01/hr=01/part-00000"
#baseline="X4_20200401_00000_pq"

spfile="stat_sp.sp_metric_insert.sql"
spbfile="stat_sp.sp_metric_insertBash.sql"


# derived VARIABLES
ds_pref=$dsTest.$inPrefix
ds_tb=$ds_pref$tb
jfile="bq/t/"$ds.$tb".json"
mkPtn="--time_partitioning_field "$tpf" --require_partition_filter"

qfile=$tb".sql"
bfile=$tb"bash.sql"


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
sed -i -e 's/kiwi.X2{{ params.X2suffix }}/'$ds_pref'X2/g' -e 's/{{ params.date }}/'$dt'/g' $bfile


# Partition Purging if needed and  APPEND
bq rm -f -t 'skytra-benchmark-devandtest:'$ds_tb'$'"${dt//-/}"
bq query --location=europe-west2 --append_table --use_legacy_sql=false --destination_table $ds_tb "$(cat $bfile)"

# Delete temp $bfile so branch is kept clean
rm $bfile

#check results
sql="with x as (select sid, ind_sid from "$dsTest.$baseline" where search_date = '"$dt"'), xin as (select sid, ind_sid from "$ds_tb" where search_date = '"$dt"') SELECT x.sid, x.ind_sid, xin.sid as xin_sid, xin.ind_sid as xin_ind_sid from x full outer join xin on x.sid = xin.sid and x.ind_sid = xin.ind_sid where x.sid is null or xin.sid is null"

bq query --location=europe-west2 --append_table --use_legacy_sql=false --destination_table $ds_tb'_RECON' $sql 

# LOG $sql
#   scratch_PaD.log_sql_RECON(jira STRING, checked_out STRING, GCSfilter STRING, sql STRING, ts TIMESTAMP)
sqll=$(echo "$sql" | sed "s/'//g")
log="select '"$inPrefix"' jira,'"$brnch"' checked_out,'"$dtGCS"' GCSfilter,'"$sqll"' sql,CURRENT_TIMESTAMP() ts"

bq query --location=europe-west2 --append_table --use_legacy_sql=false --destination_table scratch_PaD.log_sql_RECON $log
 
# DEPLOY  then  CALL $dsTest.sp_metric_insert.sql
#   NB: ignore bigquery.jobs.list error, that's because cli attempts to return results for feedback
cd ~/indexproduction/bq/r/sp/
cp $spfile $spbfile
sed -i -e 's/'$ds.$tb' where search_date = tomorrow;/'$ds_tb' where search_date = tomorrow;/g' -e 's/stat_sp/'$dsTest'/g' $spbfile
bq query --location=europe-west2 --use_legacy_sql=false "$(cat $spbfile)"
bq query --location=europe-west2 --use_legacy_sql=false "CALL "$dsTest".sp_metric_insert('"$dsTest"', '"$inPrefix$tb"', '"$dt"');"

# Delete temp $bfile so branch is kept clean
rm $spbfile

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


