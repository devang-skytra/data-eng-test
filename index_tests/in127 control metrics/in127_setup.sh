#help avail at C:\Users\pdesmond\Documents\Schema Migration Utilities.xlsx

# 1. use cloudshell and   ** cd indexproduction **              which is joined direct to BitBucket and entire script assumes cwd is indexproduction
# 2. ensure you           ** git branch  then  git checkout <correct branch>  **  with changes you are testing
# 3. set correct var vals for test below


# FIRST STEP GIT PULL
cd indexproduction
git pull origin

# VARIABLES
brnch="feature/IN-127-x2-rows-from-kiwi"
dsTest="scratch_PaD"
inPrefix="in127_"
dt="2020-04-01"
dtGCS="y=2020/m=04/d=01/hr=01/part-00000"

jfile="bq/t/kiwi.X4.json"
mkPtn="--time_partitioning_field search_date --require_partition_filter"

baseline="X4_20200401_00000_pq"
qfile="X4.sql"
bfile="X4bash.sql"

git checkout $brnch

# X2 load - if testing right from GCS load, then uncomment and load into $dsTest [IDEMPOTENT]
bq load --replace --source_format=PARQUET $dsTest.$inPrefix'X2' "gs://ext-kiwi-excl-dev-data/data/"$dtGCS"*.gz.parquet"

# X4 [IDEMPOTENT] rm and mk in case new X4.json/.sh 
bq rm -t -f $dsTest.$inPrefix'X4'

# If needed, manually create a baseline table using previous version of code
#   bq mk --table $mkPtn --schema $jfile $dsTest.'X4_20200401_00000_pq'

# IMPORTANT to use partitioning and test .sh/.json so rather than --append_table to create table, modify $jfile and do a bq mk table
#   exclude partition expiry from source because test data is old and would hide results
bq mk --table $mkPtn --schema $jfile $dsTest.$inPrefix'X4'


# IF .json fixed and needs re-apply, use this after git pull origin
#   bq update --schema $jfile $dsTest.$inPrefix'X4'

# Use *bash.sql version, located in path above, to test pipeline query
#   below sample parameters indicate STRING is default so no need for '' in *bash.sql version?
#   --parameter=corpus::romeoandjuliet --parameter=min_word_count:INT64:250 
# Like procs, query gives error 'Query parameters cannot be used in place of table names at...'
#   so just sed the table name and in fact all params using af/sq

cd ~/indexproduction/af/dags/sq
cp $qfile $bfile

# NB: sometimes add non-Airflow param at end of sed to reduce data volume further  
#   -e 's/list) < 7/list) < 2 AND ind_sid = 2/g'
sed -i -e 's/kiwi.X2{{ params.X2suffix }}/'$dsTest.$inPrefix'X2/g' -e 's/{{ params.date }}/'$dt'/g' $bfile


# Partition Purging if needed
#   bq rm -f -t 'skytra-benchmark-devandtest:'$dsTest.$inPrefix'X4$'"${dt//-/}"
# echo above in case want to manually remove tomorrow partition where metrics hide
#   echo 'skytra-benchmark-devandtest:'$dsTest.$inPrefix'X4$'"${dt//-/}"

bq query --location=europe-west2 --append_table --use_legacy_sql=false --destination_table $dsTest.$inPrefix'X4' "$(cat $bfile)"

# Delete temp $bfile so branch is kept clean
rm $bfile

#check results
sql="with x as (select sid, ind_sid from "$dsTest.$baseline" where search_date = '"$dt"'), xin as (select sid, ind_sid from "$dsTest.$inPrefix"X4 where search_date = '"$dt"') SELECT x.sid, x.ind_sid, xin.sid as xin_sid, xin.ind_sid as xin_ind_sid from x full outer join xin on x.sid = xin.sid and x.ind_sid = xin.ind_sid where x.sid is null or xin.sid is null"

bq query --location=europe-west2 --append_table --use_legacy_sql=false --destination_table $dsTest.$inPrefix'X4_RECON' $sql 

# LOG $sql
#   scratch_PaD.log_sql_RECON(jira STRING, checked_out STRING, GCSfilter STRING, sql STRING, ts TIMESTAMP)
sqll=$(echo "$sql" | sed "s/'//g")
log="select '"$inPrefix"' jira,'"$brnch"' checked_out,'"$dtGCS"' GCSfilter,'"$sqll"' sql,CURRENT_TIMESTAMP() ts"

bq query --location=europe-west2 --append_table --use_legacy_sql=false --destination_table scratch_PaD.log_sql_RECON $log
 
# NEXT STEP INTEGRATE  stat_sp.sp_metric_insert.sql




