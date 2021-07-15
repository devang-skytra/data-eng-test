
# v6 https://skytra.atlassian.net/browse/CMP-xx


$prj='skytra-benchmark-uat'
$prj='skytra-benchmark-prod'

gcloud config set core/project ${prj}

gcloud auth login paul.desmond@skytraindices.com
# gcloud auth login cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com

git checkout Develop
# git checkout master


# git pull




# *****  PROCs deploy
# *****************************************************


cd c:\git\index2\bq\r\sp


$qrys='iata_sp.sp_process_X3','iata_sp.sp_process_R1'
$qrys='iata_sp.sp_process_R2','iata_sp.sp_process_R3I3'
$qrys='matching_sp.sp_process_X6','matching_sp.sp_process_X7'

foreach ($q in $qrys) { 
	$cmd = "Get-Content $q.sql | bq query --project_id=$prj --use_legacy_sql=false"
	$cmd | Invoke-Expression
} #Write-Output





# *****  Airflow 

cd c:\git\index2\af\dags

$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'


$files='dag_matching_daily_v5_0_1.py','dag_iata_daily_v5_0_1.py'
foreach ($f in $files) { 
	$cmd = "gsutil -m cp -r $f $bkt_dag/$f"
	$cmd | Invoke-Expression
} 

