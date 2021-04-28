
# https://skytra.atlassian.net/secure/RapidBoard.jspa?rapidView=26&projectKey=CMP&modal=detail&selectedIssue=CMP-36


$prj='skytra-benchmark-prod'

gcloud config set core/project ${prj}

gcloud auth login cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com

git checkout master


# *****  Airflow 

cd c:\git\index2\af\dags

$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'


# *****  Airflow gsutil CLEANOUT
$files='dag_fxrates.py'
foreach ($f in $files) { 
	gsutil rm $bkt_dag/$f
} 


$files='dag_fxrates_v1_0_1.py'
foreach ($f in $files) { 
	$cmd = "gsutil -m cp -r $f $bkt_dag/$f"
	$cmd | Invoke-Expression
} 

cd c:\git\index2\af\dags\py

$files='fxrates_get.py'
foreach ($f in $files) { 
	$cmd = "gsutil -m cp -r $f $bkt_dag/py/$f"
	$cmd | Invoke-Expression
} 


# *****  BigQuery 


cd c:\git\index2\bq\t



$qrys='generic.currency_ext'
foreach ($q in $qrys) { 
	$cmd = "Get-Content $q.sql | bq query --project_id=$prj --use_legacy_sql=false"
	$cmd | Invoke-Expression
} #Write-Output



###### TEST PLAN
"""
Immediate
-----------------------
In Airflow, confirm new/modf DAGS 
[] - code view shows code/modf
[] - graph view shows steps/new steps
[] - compiles without error

Take rendered command for 
[] -- new/modf steps and check looks as expected for code changes


Next Day
-----------------------
[] - check for additional data source with 'select * from generic.currency_ext'
"""

###### ROLLBACK PLAN
"""
Use VSCode to revert back to prior version and deploy prior version
remove generic.currency_ext
"""
