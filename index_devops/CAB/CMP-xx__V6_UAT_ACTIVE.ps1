
# v6 UAT version  https://skytra.atlassian.net/browse/CMP-xx


$prj='skytra-benchmark-uat'
#$prj='skytra-benchmark-prod'

gcloud config set core/project ${prj}

gcloud auth login paul.desmond@skytraindices.com
# gcloud auth login cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com

# git checkout master
# git checkout 1818

# git pull


# *****  Airflow 

cd c:\git\index2\af\dags

# $bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'
$bkt_dag='gs://europe-west2-benchmark-uat--2bf16b72-bucket/dags'


# *****  Airflow gsutil CLEANOUT
# *****************************************************

# $files='dag_BA_Trillo_BizDays.py','dag_BA_Trillo_Staging_daily.py','dag_iata_daily_v2_2.py','dag_kiwi_daily.py','dag_kiwi_daily_parallel_v5_0_ProdReadLocalGCSTest.py','dag_matching_daily_v1_1.py'
$files='dag_BA_Trillo_BizDays.py','dag_BA_Trillo_Staging_daily.py'
foreach ($f in $files) { 
	gsutil rm $bkt_dag/$f
} 


# *****  UAT ONLY, PROD would be if v6 approved, TABLE COPIES

# *****  Airflow gsutil DEPLOY SCHEMA files
# *****************************************************

"""
$files='sh/zops_iata_deploy.sh','sh/zops_matching_deploy.sh','sh/zops_index_deploy.sh'
foreach ($f in $files) { 
	$cmd = "gsutil -m cp -r $f $bkt_dag/$f"
	#echo $cmd
	$cmd | Invoke-Expression
} 

OR 
"""

"""
$files='sh/*.sh'
gsutil -m cp -r $f ${bkt_dag}
gsutil -m cp -r ./dag_zops_AnyDataset_deploy.py ${bkt_dag}
"""


# *****  DATASETS make
# *****************************************************


$ds='iata_sp','index_sp','log_sp','matching_sp'
$ds='iata',   'index',   'log',   'matching',  'kiwi','generic'
foreach ($d in $ds) { bq --location=EU mk --dataset $d }


# *****  COPY generic dataset manually
# *****************************************************



# *****  Tables single partition cp
# *****************************************************

#20210101
$tbls='iata.R1','iata.R2','iata.R3I3','index.X8_doi','index.X9_doi','index.X11_doi','log.proc_load'
foreach ($t in $tbls) { bq cp "skytra-benchmark-uat:$t`$20210101" $t }

#202101 Month Partitioned
$tbls='index.X8','index.X9','index.X11','matching.X6','matching.X7'
foreach ($t in $tbls) { bq cp "skytra-benchmark-uat:$t`$202101" $t }


# *****  PROCs deploy
# *****************************************************


cd c:\git\index2\bq\r\sp

$qrys='iata_sp.sp_process_R1','iata_sp.sp_process_R2','iata_sp.sp_process_R3I3', 'index_sp.sp_process_X8','index_sp.sp_process_X9','index_sp.sp_process_X11','index_sp.sp_process_X10','index_sp.sp_process_X10_iata','index_sp.sp_process_X10_noBQML','log_sp.sp_proc_load_start','matching_sp.sp_process_X6','matching_sp.sp_process_X6_per_DOIS','matching_sp.sp_process_X7'



$qrys='iata_sp.sp_process_R1','iata_sp.sp_process_R2','iata_sp.sp_process_R3I3','index_sp.sp_process_X8','index_sp.sp_process_X9','index_sp.sp_process_X11','log_sp.sp_proc_load_start','matching_sp.sp_process_X6','matching_sp.sp_process_X7'

not in branch yet
	'index_sp.sp_process_X8_doi','index_sp.sp_process_X9_doi','index_sp.sp_process_X11_doi'

foreach ($q in $qrys) { 
	$cmd = "Get-Content $q.sql | bq query --project_id=$prj --use_legacy_sql=false"
	$cmd | Invoke-Expression
} #Write-Output



$procPfx='sp_process_'

# ***********

$dset='iata_sp'
$regx="${dset}.${procPfx}R[1-3]"

# ***********

$dset='matching_sp'
$regx="${dset}.${procPfx}X[6-7]"

# ***********

$dset='index_sp'
$regx="${dset}.${procPfx}R[4]"

$dset='index_sp'
$regx="${dset}.${procPfx}X[189]"

# ***********
# ***********

Get-ChildItem | Where-Object { $_.Name -match ${regx} } | 
Foreach-Object {
	$cmd = "Get-Content $_ | bq query --project_id=${prj} --location=EU --use_legacy_sql=false"
	$cmd | Invoke-Expression
	echo $_.Name
}  | Out-File -append -FilePath c:\git\logs\${dset}.txt

bq query --project_id=${prj} --location=EU --use_legacy_sql=false "select specific_name, last_altered from ${dset}.INFORMATION_SCHEMA.ROUTINES r order by 2 desc"

