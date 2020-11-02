
# https://cloud.google.com/sdk/gcloud/reference/functions/deploy


$branch='master'
git checkout $branch
git pull

# _iv = iata version _sv_ = skytra subversion
$FX_NAME='gcf_arc_api_iv1_5_sv_3'
$FX_PRIOR_DELETE='gcf_arc_api_v1_5'

#$prjSfx='devandtest'
#$bktSfx='-dev'

#$prjSfx='uat'
#$bktSfx='-uat'

#$prjSfx='prod'
#$bktSfx='-prod'
#gcloud auth login cloud-functions@skytra-benchmark-prod.iam.gserviceaccount.com

#$prj="skytra-benchmark-$prjSfx"
# OR
$prj='d-dat-digitalaircrafttransport'
$bktSfx=''

$STG_BUCKET="sys_stg_fx_deploy$bktSfx"
$TRG_BUCKET="ext-iata-trig$bktSfx"

$REGION='europe-west2'
$SRC_DIR='api_iata'

cd c:\git\index2\gcf

gcloud functions deploy $FX_NAME --project=$prj --region=$REGION --allow-unauthenticated --entry-point=main --memory=1024MB --runtime=python37 --source=$SRC_DIR --stage-bucket=$STG_BUCKET --timeout=540 --trigger-bucket=$TRG_BUCKET

gcloud functions delete $FX_PRIOR_DELETE --project=$prj 

# MISC
#------

# echo 'new data' | gsutil cp - gs://ext-iata-trig-uat/uat-20201026-data.txt

##gcloud auth activate-service-account cloud-functions@skytra-benchmark-prod.iam.gserviceaccount.com --key-file="C:\Users\PaulDesmond\OneDrive - SKYTRA LIMITED\Automation\gcp_keys\skytra-benchmark-prod-cloud-functions.json"

## gsutil mb -b on -c standard -l europe-west1 gs://sys_stg_fx_deploy_prod
## gsutil mb -b on -c standard -l europe-west1 gs://ext-iata-trig-prod

# echo 'new data' | gsutil cp - gs://ext-iata-trig-prod/prod-20200924-data.txt





