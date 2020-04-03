#help avail at C:\Users\pdesmond\Documents\Schema Migration Utilities.xlsx

# 1. use cloudshell and   ** cd indexproduction **              which is joined direct to BitBucket and entire script assumes cwd is indexproduction
# 2. ensure you           ** git branch  then  git checkout <correct branch>  **  with changes you are testing
# 3. set correct var vals for test below

# VARIABLES
dsTest="scratch_PaD"
inPrefix="in127_"
dt="2020-01-01"
dtGCS="y=2020/m=01/d=01/hr=01/part-00000"

jfile="bq/t/kiwi.X4.json"
mkPtn="--time_partitioning_field search_date --require_partition_filter"

qfile="X4.sql"
qbfile="X4bash.sql"

# X2 load - if testing right from GCS load, then uncomment and load into $dsTest [IDEMPOTENT]
bq load --replace --source_format=PARQUET $dsTest.$inPrefix'X2' "gs://ext-kiwi-excl-data/data/"$dtGCS"*.gz.parquet"

# X4 [IDEMPOTENT] rm and mk in case new X4.json/.sh 
bq rm -t -f $dsTest.$inPrefix'X4'

cd index2/bq/sq

# IMPORTANT to use partitioning and test .sh/.json so rather than --append_table to create table, modify $jfile and partition expiry and do a bq mk table
bq mk --table $mkPtn --schema $jfile $dsTest.$inPrefix'X4'

# Use *bash.sql version, located in path above, to test pipeline query
#   below sample parameters indicate STRING is default so no need for '' in *bash.sql version?
#   --parameter=corpus::romeoandjuliet --parameter=min_word_count:INT64:250 
# Like procs, query gives error 'Query parameters cannot be used in place of table names at...'
#   so just sed the table name and in fact all params using af/sq

cp $qfile $bfile

# NB: sometimes add non-Airflow param at end of sed to reduce data volume further  
sed -i -e 's/kiwi.X2{{ params.X2suffix }}/'$dsTest.$inPrefix'X2/g' -e 's/{{ params.date }}/'$dt'/g' -e 's/list) < 7/list) < 2 AND ind_sid = 2/g' $bfile

# Partition Purging if needed
bq rm -f -t 'd-dat-digitalaircrafttransport:'$dsTest.$inPrefix'X4$'"${dt//-/}"
# echo above in case want to manually remove tomorrow partition where metrics hide
echo 'd-dat-digitalaircrafttransport:'$dsTest.$inPrefix'X4$'"${dt//-/}"

bq query --append_table --use_legacy_sql=false --destination_table $dsTest.$inPrefix'X4' "$(cat $bfile)"

#check results
SELECT * FROM `d-dat-digitalaircrafttransport.data_eng.in127_X4` WHERE search_date >= "2020-01-01" order by 2 desc




