
REM deployment vars only
REM *****************************https://cloud.google.com/sdk/gcloud/reference/functions/deploy

REM SET PROJECT=skytra-benchmark-devandtest
SET PROJECT=d-dat-digitalaircrafttransport
SET REGION=europe-west1

REM SET FX_NAME=gcf_arc_api_v1_5
SET FX_NAME=gcf_arc_api_v1_5_New
SET SRC_DIR=api_iata

SET STG_BUCKET_PREFIX=-new
SET STG_BUCKET=sys_stg_fx_deploy 
REM SET STG_BUCKET=sys_stg_fx_deploy %STG_BUCKET_PREFIX%
SET TRG_BUCKET=ext-iata-trig%STG_BUCKET_PREFIX%

cd c:\git\index2\gcf

REM start=`date +%s`

gcloud functions deploy %FX_NAME% ^
   --project=%PROJECT% ^
   --region=%REGION% ^
   --allow-unauthenticated ^
   --entry-point=main ^
   --memory=2048MB ^
   --runtime=python37 ^
   --source=%SRC_DIR% ^
   --stage-bucket=%STG_BUCKET% ^
   --timeout=540 ^
   --trigger-bucket=%TRG_BUCKET%

REM --set-env-vars TRG_FILE_PATTERN=%TRG_FILE_PATTERN%,AF_CLI_ID=%AF_CLI_ID%,AF_WEB_ID=%AF_WEB_ID%,AF_DAG_NAME=%AF_DAG_NAME% ^

REM echo 'new data' | gsutil cp - gs://ext-iata-trig/prod-20200903-data.txt && sleep 2m
REM echo 'new data' | gsutil cp - gs://ext-iata-trig-new/prod-20172020-file_1aa.txt

REM end=`date +%s`
REM runtime=$((end-start))
REM can also do  time yourscript.sh >> real, user and sys (want real time)
REM echo %runtime%

REM Allow unauthenticated invocations of new function [fx_load_fx_prices]? (y\N)?  N
REM gcloud beta functions get-iam-policy $FX_NAME
REM https:\\stackoverflow.com\questions\57122047\google-cloud-function-not-created-with-private-access


REM Perms required iam.serviceAccounts.signBlob for d-dat-digitalaircrafttransport@appspot.gserviceaccount.com
REM gcloud iam service-accounts add-iam-policy-binding ^
REM d-dat-digitalaircrafttransport@appspot.gserviceaccount.com ^
REM --member=serviceAccount:d-dat-digitalaircrafttransport@appspot.gserviceaccount.com ^
REM --role=roles\iam.serviceAccountTokenCreator

