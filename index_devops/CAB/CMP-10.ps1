
# v5  https://skytra.atlassian.net/browse/CMP-10 (derived from PD-326 Best Index notes.ps1)


$prj='skytra-benchmark-prod'
gcloud config set core/project $prj

git checkout feature/IN-1092-create-a-waterfall-pricing-mecha
git pull

#gcloud auth login paul.desmond@skytraindices.com
#gcloud auth login cloud-functions@skytra-benchmark-prod.iam.gserviceaccount.com

gcloud auth login cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com


# External Table Deploy

$inst='benchmark-prod-composer'		
$dag_id='dag_zops_generic_ext_deploy'
$day='2020_11_18'
$age_interval='1 DAY'
$dset='generic'

gcloud composer environments run $inst --location europe-west2 trigger_dag -- $dag_id --run_id="$dag_id $day" --conf '{ "replacement_age_interval":$age_interval, "dset":$dset}'

$dag_id='dag_zops_none_generic_ext_deploy'

gcloud composer environments run $inst --location europe-west2 trigger_dag -- $dag_id --run_id="$dag_id $day" --conf '{ "replacement_age_interval":$age_interval}'


# *****  CLEAR LOG TABLES EXCEPT FOR KIWI V5 BUILD  
#C:\Users\PaulDesmond\OneDrive - SKYTRA LIMITED\Shared\pd_IdxTeamShare\pd_DataTeamShare\v5\log cleanout.sql
# *****************************************************



# *****  Airflow gsutil deploy
# *****************************************************

cd c:\git\index2\af\dags

$bkt_dag=gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags


# gsutil -m cp -r *v5_0_1.py $bkt_dag
#   OR
$dags='dag_iata_daily_v5_0_1.py','dag_matching_daily_v5_0_1.py','dag_index_daily_v5_0_1.py'

foreach ($d in $dags) { 
	$cmd = "gsutil -m cp -r $d $bkt_dag/$d"
	echo $cmd
	#$cmd | Invoke-Expression
}

$qrys='sq/X5a.sql','sq/X5b.sql','sq/X12.sql','py/op_gen.py'
$qrys='sq/X5a.sql'
foreach ($q in $qrys) { 
	$cmd = "gsutil -m cp -r $q $bkt_dag/$q"
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




