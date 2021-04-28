
# https://skytra.atlassian.net/secure/RapidBoard.jspa?rapidView=26&projectKey=CMP&modal=detail&selectedIssue=CMP-35


$prj='skytra-benchmark-prod'

gcloud config set core/project ${prj}

gcloud auth login cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com

git checkout master

# *****  Airflow 

cd c:\git\index2\af\dags

$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'


$files='dag_BA_Trillo_BizDays_v5_0_2.py','dag_iata_daily_v5_0_1.py','dag_matching_daily_v5_0_1.py'
foreach ($f in $files) { 
	$cmd = "gsutil -m cp -r $f $bkt_dag/$f"
	$cmd | Invoke-Expression
} 



###### TEST PLAN
"""
Immediate
-----------------------
In Airflow, confirm new/modf DAGS 
[] - code view shows code/modf
[] - graph view shows steps/new steps
[] - compiles without error


Next Day
-----------------------
[] - check for expected RunDate in Airflow Dashboard
"""

###### ROLLBACK PLAN
"""
Use VSCode to revert back to prior version and deploy prior version
"""
