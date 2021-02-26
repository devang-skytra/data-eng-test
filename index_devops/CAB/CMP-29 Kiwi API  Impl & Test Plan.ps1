
# https://skytra.atlassian.net/browse/CMP-29


###### PERFORM SAME 30 LINES PREPARATORY PROJECT AND LOGIN STEPS FROM CMP-11
"""
ie
$prj='skytra-benchmark-prod'	etc
git checkout master				etc
gcloud auth login cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com
"""


# *****  Airflow 

cd c:\git\index2\af\dags
$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'



# *****  Airflow gsutil CLEANOUT old files
# *****************************************************

$files='py/call_prices_kiwiAPI.py'
foreach ($f in $files) { 
	gsutil rm $bkt_dag/$f
} 



# *****  Airflow DEPLOY DAGs and their dependencies
#--------------------------------------------------------------

$qrys='py/kiwi_api_call.py','sq/kiwi_api_gen_URLs.sql','dag_kiwi_api_v5_0_0.py'
foreach ($q in $qrys) { 
	$cmd = "gsutil -m cp -r $q $bkt_dag/$q"
	$cmd | Invoke-Expression
} 

# *****  Airflow WHEN TO ENABLE DAG for first time
#--------------------------------------------------------------

# enable after 10AM day after deployment


###### TEST PLAN
"""
Immediate
-----------------------
In Airflow, confirm new/modf DAGS 
[SUCCESS] - code view shows code/modf
[SUCCESS] - graph view shows steps/new steps
[SUCCESS] - compiles without error

Take rendered SQL for 
[SUCCESS] -- new SQL steps and check compiles in BQ against PROD (and returns expected result if can return result today)


Next Day
-----------------------
[] - check for expected results in Data Studio Data Control Dashboard page 24 
"""
