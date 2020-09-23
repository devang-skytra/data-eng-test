#!/bin/bash

cd code/index_NoGit/fx
#cd "code/index_NoGit/fx/"$FX_NAME

#deployment vars only
export REGION="europe-west1"
export FX_NAME="gcf_bkt_trg_kiwi_stats_check1"
export STG_BUCKET="sys_stg_fx_deploy"

# GCF vars
export TRG_BUCKET="ext-kiwi-excl-stat"
export TRG_FILE_PATTERN="-c000.csv"
#   get AIRFLOW CLI_ID using H:\git\index_NoGit\fx\fx_bkt_trg_kiwi_dag\dag_getAFclientID.py
export AF_CLI_ID='87722463182-mkjf18o8u9luur28o37se5odcaeq058a.apps.googleusercontent.com'
export AF_WEB_ID='y15b7b3139e36e1dc-tp'
export AF_DAG_NAME='kiwi_trigger_load'

start=`date +%s`

gcloud beta functions deploy $FX_NAME \
   --region=$REGION \
   --allow-unauthenticated \
   --entry-point=$FX_NAME \
   --memory 128MB \
   --runtime python37 \
   --source=$FX_NAME \
   --stage-bucket=$STG_BUCKET \
   --set-env-vars TRG_FILE_PATTERN=$TRG_FILE_PATTERN,AF_CLI_ID=$AF_CLI_ID,AF_WEB_ID=$AF_WEB_ID,AF_DAG_NAME=$AF_DAG_NAME \
   --trigger-bucket=$TRG_BUCKET 

end=`date +%s`
runtime=$((end-start))
# can also do  time yourscript.sh >> real, user and sys (want real time)
echo $runtime

#Allow unauthenticated invocations of new function [fx_load_fx_prices]? (y/N)?  N
#gcloud beta functions get-iam-policy $FX_NAME
#https://stackoverflow.com/questions/57122047/google-cloud-function-not-created-with-private-access


#Perms required iam.serviceAccounts.signBlob for d-dat-digitalaircrafttransport@appspot.gserviceaccount.com
gcloud iam service-accounts add-iam-policy-binding \
d-dat-digitalaircrafttransport@appspot.gserviceaccount.com \
--member=serviceAccount:d-dat-digitalaircrafttransport@appspot.gserviceaccount.com \
--role=roles/iam.serviceAccountTokenCreator

