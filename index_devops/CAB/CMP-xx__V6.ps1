
# related doco
# C:\Users\PaulDesmond\OneDrive - SKYTRA LIMITED\Shared\pd_IdxTeamShare\pd_DataTeamShare\v6 deployment plan.sh
# C:\git\DataEng\index_devops\CAB\CMP-xx__V6_UAT_ACTIVE.ps1
# C:\git\DataEng\index_devops\CAB\CMP-xx__V6.ps1
# C:\git\DataEng\index_tests\IN-2240-airtyx-parallel-proc-improvement.ps1

# v5  https://skytra.atlassian.net/browse/CMP-10 (derived from PD-326 Best Index notes.ps1)

$prj='paul-d-test-proj'
$prj='skytra-benchmark-uat'
#$prj='skytra-benchmark-prod'
$prj='skt-uat-warehouse-id-2a3e'

gcloud config set core/project $prj

gcloud auth login paul.desmond@skytraindices.com
# gcloud auth login cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com

# git checkout master
# git checkout Develop # or 1818

# git pull


# *****  Airflow 

cd c:\git\index2\af\dags

$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'

# *****  Airflow gsutil CLEANOUT
# *****************************************************

# $files='dag_BA_Trillo_BizDays.py','dag_BA_Trillo_Staging_daily.py','dag_iata_daily_v2_2.py','dag_kiwi_daily.py','dag_kiwi_daily_parallel_v5_0_ProdReadLocalGCSTest.py','dag_matching_daily_v1_1.py'
$files='dag_BA_Trillo_BizDays.py','dag_BA_Trillo_Staging_daily.py'
foreach ($f in $files) { 
	gsutil rm $bkt_dag/$f
} 



# *****  Airflow gsutil DEPLOY SCHEMA files
# *****************************************************

$files='sh/zops_non_generic_ext_deploy.sh','sh/zops_generic_ext_deploy.sh'
foreach ($f in $files) { 
	$cmd = "gsutil -m cp -r $f $bkt_dag/$f"
	#echo $cmd
	$cmd | Invoke-Expression
} 


# gsutil -m cp -r ./dag_zops_AnyDataset_deploy.py $bkt_dag




#
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




# *****  Airflow gsutil DEPLOY PIPELINE dags
# *****************************************************

cd c:\git\index2\af\dags


$files='sq/X5a.sql','sq/X5b.sql','sq/X12.sql','sq/X13.sql','py/op_gen.py'
foreach ($f in $files) { 
	$cmd = "gsutil -m cp -r $f $bkt_dag/$f"
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


cd c:\git\index2\V6\bq\r\sp


$qrys='log_sp.sp_proc_load_start','log_sp.sp_proc_load_end','iata_sp.sp_process_R1','iata_sp.sp_process_R2','iata_sp.sp_process_R3I3','index_sp.sp_process_X8','index_sp.sp_process_X9','index_sp.sp_process_X11','log_sp.sp_proc_load_start','matching_sp.sp_process_X6','matching_sp.sp_process_X7','index_sp.sp_process_X8_doi_based','index_sp.sp_process_X9_doi_based','index_sp.sp_process_X11_doi_based'
foreach ($q in $qrys) { 
	#Get-Content $q | bq query --project_id=$prj --use_legacy_sql=false 
	$cmd = "Get-Content $q.sql | bq query --project_id=$prj --use_legacy_sql=false"
	#echo $cmd
	$cmd | Invoke-Expression
} #Write-Output



# CLOUD FUNCTION DEPLOY - CAREFUL RE TRIGGER BUCKET 


$sa='cloud-functions@skytra-benchmark-prod.iam.gserviceaccount.com'

gcloud auth login $sa

$FX_NAME='gcf_arc_api_iv1_5_sv_3'
$FX_PRIOR_DELETE='gcf_arc_api_v1_5'

$prjSfx='prod'
$bktSfx1='_prod'
$bktSfx2='-prod'

$STG_BUCKET="sys_stg_fx_deploy$bktSfx1"
$TRG_BUCKET="ext-iata-trig$bktSfx2"

$REGION='europe-west2'
$SRC_DIR='api_iata'

echo $TRG_BUCKET
echo $STG_BUCKET


cd c:\git\index2\gcf

gcloud functions deploy $FX_NAME --project=$prj --region=$REGION --allow-unauthenticated --entry-point=main --memory=1024MB --runtime=python37 --source=$SRC_DIR --stage-bucket=$STG_BUCKET --timeout=540 --trigger-bucket=$TRG_BUCKET --service-account=$sa

gcloud functions delete $FX_PRIOR_DELETE --project=$prj --region=$REGION 

# VALIDATION
C:\Users\PaulDesmond\OneDrive - SKYTRA LIMITED\Shared\pd_IdxTeamShare\pd_DataTeamShare\v5\v5 Deployment Validation BigQuery.xlsx



$inst='benchmark-prod-composer'		
$dag_id='dag_iata_daily_v5_0_1'

gcloud composer environments run $inst --location europe-west2 unpause -- $dag_id




