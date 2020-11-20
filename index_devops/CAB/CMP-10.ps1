
# v5  https://skytra.atlassian.net/browse/CMP-10 (derived from PD-326 Best Index notes.ps1)


$prj='skytra-benchmark-prod'
gcloud config set core/project $prj

gcloud auth login cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com

# deployment (not index) DAGs

cd c:\git\index2\af\dags

$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'

$qrys='sh/zops_non_generic_ext_deploy.sh','sh/zops_generic_ext_deploy.sh'
foreach ($q in $qrys) { 
	$cmd = "gsutil -m cp -r $q $bkt_dag/$q"
	#echo $cmd
	$cmd | Invoke-Expression
} 

gsutil -m cp -r ./dag_zops* $bkt_dag


git checkout master
git pull

#gcloud auth login paul.desmond@skytraindices.com
#gcloud auth login cloud-functions@skytra-benchmark-prod.iam.gserviceaccount.com


# External Table Deploy

$inst='benchmark-prod-composer'		
$dag_id='dag_zops_generic_ext_deploy'
$day='2020_11_19'
$age_interval='1 DAY'
$dset='generic'

gcloud composer environments run $inst --location europe-west2 trigger_dag -- $dag_id --run_id="$dag_id $day" --conf '{ "replacement_age_interval":$age_interval, "dset":$dset}'

$dag_id='dag_zops_non_generic_ext_deploy'

gcloud composer environments run $inst --location europe-west2 trigger_dag -- $dag_id --run_id="$dag_id $day" --conf '{ "replacement_age_interval":$age_interval}'


# manual variable versions - may need to escape due to : preceding var name

gcloud composer environments run $inst --location europe-west2 trigger_dag -- $dag_id --run_id="$dag_id $day" --conf '{}'

$dag_id='dag_zops_non_generic_ext_deploy'

gcloud composer environments run $inst --location europe-west2 trigger_dag -- $dag_id --run_id="$dag_id $day" --conf '{}'

# Log Tables were cleared in UAT for v5 so should not need to clear again?
#		C:\Users\PaulDesmond\OneDrive - SKYTRA LIMITED\Shared\pd_IdxTeamShare\pd_DataTeamShare\v5\log cleanout.sql




# *****  Airflow gsutil deploy
# *****************************************************

cd c:\git\index2\af\dags


$qrys='sq/X5a.sql','sq/X5b.sql','sq/X12.sql','sq/X13.sql','py/op_gen.py'
foreach ($q in $qrys) { 
	$cmd = "gsutil -m cp -r $q $bkt_dag/$q"
	#echo $cmd
	$cmd | Invoke-Expression
} 


#  !!!!  ENSURE ANY SCHEDULED DAGs ARE SET TO PAUSED_on_CREATION and *CATCHUP* FALSE before deployment
#  !!!!  ENSURE ANY SCHEDULED DAGs ARE SET TO PAUSED_on_CREATION and *CATCHUP* FALSE before deployment
#  !!!!  ENSURE ANY SCHEDULED DAGs ARE SET TO PAUSED_on_CREATION and *CATCHUP* FALSE before deployment

$dags='dag_iata_daily_v5_0_1.py','dag_matching_daily_v5_0_1.py','dag_index_daily_v5_0_1.py','dag_kiwi_daily_v5_0_0.py'
foreach ($d in $dags) { 
	$cmd = "gsutil -m cp -r $d $bkt_dag/$d"
	#echo $cmd
	$cmd | Invoke-Expression
}


# *****  PROCs deploy
# *****************************************************


cd c:\git\index2\bq\r\sp

$qrys='iata_sp.sp_process_R1','iata_sp.sp_process_R2','iata_sp.sp_process_R3I3','iata_sp.sp_process_X3', 'index_sp.sp_process_X8','index_sp.sp_process_X9','index_sp.sp_process_X11','log_sp.sp_proc_load_start','matching_sp.sp_process_X6','matching_sp.sp_process_X7'
foreach ($q in $qrys) { 
	#Get-Content $q | bq query --project_id=$prj --use_legacy_sql=false 
	$cmd = "Get-Content $q.sql | bq query --project_id=$prj --use_legacy_sql=false"
	#echo $cmd
	$cmd | Invoke-Expression
} #Write-Output



# CLOUD FUNCTION DEPLOY - CAREFUL RE TRIGGER BUCKET 

gcloud auth login cloud-functions@skytra-benchmark-prod.iam.gserviceaccount.com

$FX_NAME='gcf_arc_api_iv1_5_sv_3'
$FX_PRIOR_DELETE='gcf_arc_api_v1_5'

$prjSfx='prod'
$bktSfx='_prod'

$STG_BUCKET="sys_stg_fx_deploy$bktSfx"
$TRG_BUCKET="ext-iata-trig$bktSfx"

$REGION='europe-west2'
$SRC_DIR='api_iata'

echo $TRG_BUCKET

$STG_BUCKET="sys_stg_fx_deploy_prod"


cd c:\git\index2\gcf

gcloud functions deploy $FX_NAME --project=$prj --region=$REGION --allow-unauthenticated --entry-point=main --memory=1024MB --runtime=python37 --source=$SRC_DIR --stage-bucket=$STG_BUCKET --timeout=540 --trigger-bucket=$TRG_BUCKET

gcloud functions delete $FX_PRIOR_DELETE --project=$prj --region=$REGION 

# VALIDATION
C:\Users\PaulDesmond\OneDrive - SKYTRA LIMITED\Shared\pd_IdxTeamShare\pd_DataTeamShare\v5\v5 Deployment Validation BigQuery.xlsx



$inst='benchmark-prod-composer'		
$dag_id='dag_iata_daily_v5_0_1'

gcloud composer environments run $inst --location europe-west2 unpause -- $dag_id




