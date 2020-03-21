#!/bin/bash

cd code/index_NoGit/fx
#cd "code/index_NoGit/fx/"$FX_NAME

export REGION="europe-west1"
export FX_NAME="fx_load_fx_prices"
export TRG_BUCKET="fxrates"
export TRG_FILE="trg_"$FX_NAME
#export ZIP=$FX_NAME".zip" Not needed, just unzipped directory
export STG_BUCKET="sys_stg_fx_deploy"
#echo "TRG_FILE is $TRG_FILE"


start=`date +%s`

gcloud beta functions deploy $FX_NAME \
   --region=$REGION \
   --allow-unauthenticated \
   --entry-point=$FX_NAME \
   --memory 256MB \
   --runtime python37 \
   --source=$FX_NAME \
   --stage-bucket=$STG_BUCKET \
   --set-env-vars TRIGGER_FILE=$TRG_FILE \
   --trigger-bucket=$TRG_BUCKET 

end=`date +%s`
runtime=$((end-start))
# can also do  time yourscript.sh >> real, user and sys (want real time)
echo $runtime

#Allow unauthenticated invocations of new function [fx_load_fx_prices]? (y/N)?  N
#gcloud beta functions get-iam-policy $FX_NAME
#https://stackoverflow.com/questions/57122047/google-cloud-function-not-created-with-private-access
