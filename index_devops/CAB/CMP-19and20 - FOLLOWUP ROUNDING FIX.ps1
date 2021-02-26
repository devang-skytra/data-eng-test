

###### PERFORM SAME 30 LINES PREPARATORY PROJECT AND LOGIN STEPS FROM CMP-11
"""
ie
$prj='skytra-benchmark-prod'	etc
git checkout master				etc
gcloud auth login cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com

"""

bq cp -f skytra-benchmark-uat:generic.index_rrpk_model_params_201811_201911_staging generic.index_rrpk_model_params_201811_201911_staging

bq query --project_id=$prj --use_legacy_sql=false "CALL generic_sp.sp_update_any_compliant_snapshot('generic.index_rrpk_model_params_201811_201911', FALSE, 'region_pair')"


# deploy DAG sqls
#--------------------------------------------------------------

cd c:\git\index2\af\dags
$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'

#589 gsutil cp sql x2

$qrys='sq/X12.sql','sq/X13.sql'
foreach ($q in $qrys) { 
	$cmd = "gsutil -m cp -r $q $bkt_dag/$q"
	$cmd | Invoke-Expression
} 

###### TEST PLAN
"""
Immediate
-----------------------
In Airflow, confirm modf DAGS 

Take rendered SQL for 
[SUCCESS] -- new steps (SKWW) and check compiles in BQ (new data will not be present until tomorrow)
[SUCCESS] -- existing step and check presence of ISINs

[SUCCESS] - take rendered GCS path for new steps (SKWW) and confirm path exists in Trillo Prod

"""



