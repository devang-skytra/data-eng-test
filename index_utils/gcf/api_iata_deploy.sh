#!/bin/bash


#deployment vars only
#export REGION="europe-west1"
export REGION="us-central1"
export FX_NAME="simple-fx-test-sa-deploy-devT"
export STG_BUCKET="d-dat-data-eng-dev"
export TRG_BUCKET="ext-kiwi-excl-dev-stat"

# GCF vars

#export TRG_FILE_PATTERN="-c000.csv"
#   get AIRFLOW CLI_ID using H:\git\index_NoGit\fx\fx_bkt_trg_kiwi_dag\dag_getAFclientID.py
#export AF_CLI_ID='87722463182-mkjf18o8u9luur28o37se5odcaeq058a.apps.googleusercontent.com'
#export AF_WEB_ID='y15b7b3139e36e1dc-tp'
#export AF_DAG_NAME='kiwi_trigger_load'

start=`date +%s`

gcloud beta functions deploy $FX_NAME \
   --region=$REGION \
   --service-account=skytra-benchmark-devandtest@appspot.gserviceaccount.com \
   --allow-unauthenticated \
   --entry-point=hello_gcs \
   --memory 128MB \
   --runtime python37 \
   --source=gs://d-dat-data-eng-dev/staging/function-source.zip \
   --trigger-bucket=$TRG_BUCKET 
   
# --stage-bucket is needed if --source is local filesystem, it's where code is staged first
#--stage-bucket=$STG_BUCKET \
#--set-env-vars TRG_FILE_PATTERN=$TRG_FILE_PATTERN,AF_CLI_ID=$AF_CLI_ID,AF_WEB_ID=$AF_WEB_ID,AF_DAG_NAME =$AF_DAG_NAME \  
   
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


The member to add the binding for. Should be of the form user|group|serviceAccount:email or domain:domain
gcloud iam service-accounts add-iam-policy-binding skytra-benchmark-devandtest@appspot.gserviceaccount.com --member=user:paul.desmond@skytraindices.com --role=roles/iam.serviceAccountUser

PERMISSION_DENIED: Permission iam.serviceAccounts.getIamPolicy is required to perform this operation on service account projects/skytra-benchmark-devandtest/serviceAccounts/skytra-benchmark-devandtest@appspot.gserviceaccount.com.

