REM cd "code/index_NoGit/fx/"$FX_NAME

REM deployment vars only
REGION=europe-west2
FX_NAME=gcf_kiwi_api
STG_BUCKET=sys_stg_fx_deploy

REM GCF vars
export TRG_BUCKET="ext-kiwi-trig"


gcloud beta functions deploy %FX_NAME% \
   --region=%REGION% \
   --allow-unauthenticated \
   --entry-point=main \
   --memory 128MB \
   --runtime python37 \
   --source=%FX_NAME% \
   --stage-bucket=%STG_BUCKET% \
   --trigger-bucket=%TRG_BUCKET% 


REM Perms required iam.serviceAccounts.signBlob for d-dat-digitalaircrafttransport@appspot.gserviceaccount.com
REM gcloud iam service-accounts add-iam-policy-binding d-dat-digitalaircrafttransport@appspot.gserviceaccount.com \
REM 	--member=serviceAccount:d-dat-digitalaircrafttransport@appspot.gserviceaccount.com \
REM 	--role=roles/iam.serviceAccountTokenCreator

