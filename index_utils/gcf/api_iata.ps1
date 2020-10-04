
# https://cloud.google.com/sdk/gcloud/reference/functions/deploy

$prj='skytra-benchmark-devandtest'
#$prj='skytra-benchmark-uat'
$prj='skytra-benchmark-prod'
$REGION='europe-west1'

$FX_NAME='gcf_arc_api_v1_5'
#$FX_NAME=gcf_arc_api_v1_5_New
$SRC_DIR='api_iata'

## gsutil mb -b on -c standard -l europe-west1 gs://sys_stg_fx_deploy_prod
## gsutil mb -b on -c standard -l europe-west1 gs://ext-iata-trig-prod

$STG_BUCKET='sys_stg_fx_deploy_prod'
$suffix='-prod'
$TRG_BUCKET="ext-iata-trig$suffix"

cd c:\git\index2\gcf

gcloud functions deploy $FX_NAME --project=$prj --region=$REGION --allow-unauthenticated --entry-point=main --memory=1024MB --runtime=python37 --source=$SRC_DIR --stage-bucket=$STG_BUCKET --timeout=540 --trigger-bucket=$TRG_BUCKET


# Perms required iam.serviceAccounts.signBlob for d-dat-digitalaircrafttransport@appspot.gserviceaccount.com
# gcloud iam service-accounts add-iam-policy-binding ^
# d-dat-digitalaircrafttransport@appspot.gserviceaccount.com ^
# --member=serviceAccount:d-dat-digitalaircrafttransport@appspot.gserviceaccount.com ^
# --role=roles\iam.serviceAccountTokenCreator

# DEV
------
$prj='skytra-benchmark-devandtest'
#gcloud auth login paul.desmond@skytraindices.com
#OR
#gcloud auth login skytra-benchmark-devandtest@appspot.gserviceaccount.com
# result 
#	With my credentials Create Function button does not work on DevTest and UAT (does on Migrated)





gcloud auth activate-service-account cloud-functions@skytra-benchmark-prod.iam.gserviceaccount.com --key-file="C:\Users\PaulDesmond\OneDrive - SKYTRA LIMITED\Automation\gcp_keys\skytra-benchmark-prod-cloud-functions.json"

gcloud auth login cloud-functions@skytra-benchmark-prod.iam.gserviceaccount.com

#cd c:\git
#$FX_NAME='py-sample-fx-sa'
#$ENTRY_FX='hello_gcs'
#$SRC_DIR='py-sample-fx-sa'


$prj='skytra-benchmark-prod'
gcloud config set core/project $prj

cd c:\git\index2\gcf

$FX_NAME='gcf_arc_api_v1_5'
$ENTRY_FX='main'
$SRC_DIR='api_iata'

$REGION='europe-west2'
$STG_BUCKET='sys_stg_fx_deploy_prod'
$TRG_BUCKET='ext-iata-trig-prod'

gcloud functions deploy $FX_NAME --project=$prj --region=$REGION --allow-unauthenticated --entry-point=$ENTRY_FX --memory=1024MB --runtime=python37 --source=$SRC_DIR --stage-bucket=$STG_BUCKET --timeout=540 --trigger-bucket=$TRG_BUCKET


# echo 'new data' | gsutil cp - gs://ext-iata-trig-prod/prod-20200924-data.txt





