# receive passed in 
#   baseDAG parameter - filename only, no path, no .py
#   def indicating default git dags path
# cd ~/dataeng/index_utils/af/dagDevOps
# bash dagDevOps.sh test_PyOpTime_to_2bqTables ~/ops/af/dags/
# bash dagDevOps.sh dag_IATA_Weekly def


baseDAG=$1
if [ $2 = "def" ]
then
	gitDAG_p=~/indexproduction/af/dags/
else
	gitDAG_p=$2
fi
#   baseDAG=test_PyOpTime_to_2bqTables 
#   gitDAG_p=~/ops/af/dags/

# static vars
opsDAG_p=~/ops/af/dags/

#prj=skytra-benchmark-devandtest
#af_env=benchmark-devtest-composer-3
#af_loc=europe-west2
#af_svc=cloud-composer@skytra-benchmark-devandtest.iam.gserviceaccount.com
#gccDAG_p=gs://europe-west2-benchmark-devt-6ca0db0f-bucket/dags

prj=d-dat-digitalaircrafttransport
af_env=af-kiwi-2019
af_loc=europe-west2
af_svc=156629557333-compute@developer.gserviceaccount.com
gccDAG_p=gs://europe-west2-af-kiwi-2019-336f8a73-bucket/dags

# var ts
start=`date +%s`
start_human=`date -d @$start +'%y%m%d_%H%M'`
baseDAG_suf=$baseDAG'_'$start_human
gitDAG=$gitDAG_p$baseDAG
sufDAG=$opsDAG_p$baseDAG_suf
sufDAG_py=$sufDAG.py

# CONSIDER DOING   GIT PULL 
#   IN CASE DEV DONE ELSEWHERE? 
#   WOULD NEED cd ~/indexproduction and CORRECT BRANCH already checked out or could cater for that

# copy base dag - suffix with _ts
cp $gitDAG.py $sufDAG_py

# sed dag_id    - suffix with _ts 
sed -i  -e 's/'$baseDAG'/'$baseDAG_suf'/g' \
        -e 's/'@yearly'/'@once'/g' $sufDAG_py

# deploy
gsutil cp $sufDAG_py $gccDAG_p

echo $baseDAG_suf
# wait X minutes
#echo "sleep 5m"
#sleep 5m

# run dag -> should receive notf in SLACK
# https://cloud.google.com/composer/docs/how-to/using/testing-dags
echo "gcloud beta composer environments run $af_env --location $af_loc trigger_dag --verbosity=critical -- $baseDAG_suf"
gcloud beta composer environments run $af_env --location $af_loc trigger_dag --verbosity=critical -- $baseDAG_suf
#--project=$prj --impersonate-service-account=$af_svc
