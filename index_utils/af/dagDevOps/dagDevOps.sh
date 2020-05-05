# receive passed in 
#  baseDAG parameter - filename only, no path, no .py
#  def/path indicating default git dags path otherwise receive another path
#  DEV/PROD indicating Airflow env
#  False/True DEBUG_MODE to set in DAG
#  False/True indicating whether deploy eg. after sed changes, 
#   ie. can be goog to check sed result before deploying

'''
cd ~/dataeng/index_utils/af/dagDevOps  && \
 bash dagDevOps.sh dag_X7multi_Weekly def DEV True True

bash dagDevOps.sh dag_IATA_Weekly def DEV True False

cp ~/ops/af/dags/sample*.py ~/dataeng/index_tests/cloudshell_ops_copy/af/dags/
cp ~/ops/af/dags/watch*.py ~/dataeng/index_tests/cloudshell_ops_copy/af/dags/
'''

echo '1' && \
    echo '2'

baseDAG=$1

if [ $2 = "def" ]
then
	gitDAG_p=~/indexproduction/af/dags/
else
	gitDAG_p=$2
fi

if [ $3 = "DEV" ]
then
    prj=skytra-benchmark-devandtest
    af_env=benchmark-devtest-composer-3
    af_loc=europe-west2
    af_svc=cloud-composer@skytra-benchmark-devandtest.iam.gserviceaccount.com
    export gccDAG_p=gs://europe-west2-benchmark-devt-6ca0db0f-bucket/dags
else
    prj=d-dat-digitalaircrafttransport
    af_env=af-kiwi-2019
    af_loc=europe-west2
    af_svc=156629557333-compute@developer.gserviceaccount.com
    export gccDAG_p=gs://europe-west2-af-kiwi-2019-336f8a73-bucket/dags
fi

# static vars
# - opsDAG_p is where testing copies are put so not mixed in with bitB
export opsDAG_p=~/ops/af/dags/

# var ts
start=`date +%s`
start_human=`date -d @$start +'%y%m%d_%H%M'`
baseDAG_suf=$baseDAG'_'$start_human
gitDAG=$gitDAG_p$baseDAG
sufDAG=$opsDAG_p$baseDAG_suf
export sufDAG_py=$sufDAG.py

# copy base dag - suffix with _ts
cp $gitDAG.py $sufDAG_py

# sed dag_id NB: sed debug input:  sed "s/ones/one's/"<<<"ones thing"
sed -i  -e 's/'$baseDAG'/'$baseDAG_suf'/g' \
        -e 's/DEBUG_MODE = False/DEBUG_MODE = '$4'/g' \
        -e "s/None/'@once'/g"  \
    $sufDAG_py

# deploy
if [ $5 = "True" ]
then
    gsutil cp $sufDAG_py $gccDAG_p
    #if EXPORT of vars doesn't work can use this
    #gsutil cp $opsDAG_p'*1635.py' $gccDAG_p
fi

echo $baseDAG_suf
# -> should receive notf in SLACK
# -> also can use AF Tasks url bookmark to check status


#======================================================================
# BELOW NOT REQ (sleep and trigger_dag) now that we have
#   1) 'start_date': days_ago(1)  and  catchup = True in DAG 
#   2) sed None/'@once' above

    # wait X minutes
    #echo "sleep 5m"
    #sleep 5m

    # https://cloud.google.com/composer/docs/how-to/using/testing-dags
    #echo "gcloud beta composer environments run $af_env --location $af_loc trigger_dag --verbosity=critical -- $baseDAG_suf"
    #gcloud beta composer environments run $af_env --location $af_loc trigger_dag --verbosity=critical -- $baseDAG_suf
    #--project=$prj --impersonate-service-account=$af_svc
