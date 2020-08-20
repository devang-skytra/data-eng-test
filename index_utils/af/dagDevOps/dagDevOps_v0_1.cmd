@echo off
REM receive passed in 
REM  baseDAG parameter - filename only, no path, no .py
REM  def/path indicating default git dags path otherwise receive another path
REM  DEV/PROD indicating Airflow env
REM  False/True DEBUG_MODE to set in DAG
REM  False/True indicating whether deploy eg. after sed changes, 
REM   ie. can be good to check sed result before deploying

REM C:\git\DataEng\index_utils\af\dagDevOps\dagDevOps_v0_1.cmd dag_X7multi_Weekly def DEV True True

REM bash dagDevOps.sh dag_IATA_Weekly def DEV True False
REM cp ~/ops/af/dags/sample*.py ~/dataeng/index_tests/cloudshell_ops_copy/af/dags/
REM cp ~/ops/af/dags/watch*.py ~/dataeng/index_tests/cloudshell_ops_copy/af/dags/

SET baseDAG=%1

IF [%2]=="def" (
    SET gitDAG_p=c:\git\index2\af\dags\
) ELSE ( 
    SET gitDAG_p=%2
)

IF [%2]=="DEV" (
    SET gitDAG_p=c:\git\index2\af\dags\
) ELSE ( 
    SET gitDAG_p=%2
)

IF [%3]=="DEV" (
    SET prj=skytra-benchmark-devandtest
    SET af_env=benchmark-devtest-composer-3
    SET af_loc=europe-west2
    SET af_svc=cloud-composer@skytra-benchmark-devandtest.iam.gserviceaccount.com
    SET gccDAG_p=gs://europe-west2-benchmark-devt-6ca0db0f-bucket/dags
) ELSE ( 
    SET prj=d-dat-digitalaircrafttransport
    SET af_env=af-kiwi-2019
    SET af_loc=europe-west2
    SET af_svc=156629557333-compute@developer.gserviceaccount.com
    SET gccDAG_p=gs://europe-west2-af-kiwi-2019-336f8a73-bucket/dags
)


REM static vars
REM - opsDAG_p is where testing copies are put so not mixed in with bitB
SET opsDAG_p=C:\dvops\af\dags

REM var ts
SET start_human=%date:~6,4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%
SET baseDAG_suf=%baseDAG%'_'%start_human%
SET gitDAG=%gitDAG_p%%baseDAG%
SET sufDAG=%opsDAG_p%%baseDAG_suf%


IF [%3]=="DEV" (
then
    SET sufDAG_py=%sufDAG%.py
) ELSE ( 
    SET sufDAG_py=%opsDAG_p%%baseDAG%.py
)

REM copy base dag - suffix with _ts
copy %gitDAG%.py %sufDAG_py%

EXIT /B


REM https://stackoverflow.com/questions/39755684/sed-equivalent-in-a-bat-file?rq=1
REM sed -i '$ s/,/;/g' abc.java
REM https://www.dostips.com/forum/viewtopic.php?t=6044
REM call jrepl "," ";" /inc -1 /f abc.java /o -			NB: overwrites file like sed does so copy first

if [ $3 = "DEV" ]
then
    sed -i  -e 's/'$baseDAG'/'$baseDAG_suf'/g' \
            -e 's/DEBUG_MODE = False/DEBUG_MODE = '$4'/g' \
        $sufDAG_py
fi


REM deploy
if [ $5 = "True" ]
then
    gsutil cp $sufDAG_py $gccDAG_p
    REMif EXPORT of vars doesn't work can use this
    REMgsutil cp ~/ops/af/dags/*_nonEU.py gs://europe-west2-benchmark-devt-6ca0db0f-bucket/dags
fi

echo $sufDAG_py
REM -> should receive notf in SLACK
REM -> also can use AF Tasks url bookmark to check status


REM ======================================================================
REM BELOW NOT REQ (sleep and trigger_dag) now that we have
REM   1) 'start_date': days_ago(1)  and  catchup = True in DAG 
REM   2) sed None/'@once' above

    REM wait X minutes
    REMecho "sleep 5m"
    REMsleep 5m

    REM https://cloud.google.com/composer/docs/how-to/using/testing-dags
    REMecho "gcloud beta composer environments run $af_env --location $af_loc trigger_dag --verbosity=critical -- $baseDAG_suf"
    REMgcloud beta composer environments run $af_env --location $af_loc trigger_dag --verbosity=critical -- $baseDAG_suf
    REM--project=$prj --impersonate-service-account=$af_svc
