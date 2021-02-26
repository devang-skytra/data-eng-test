
# Skytra ISINs  https://skytra.atlassian.net/browse/CMP-19
# Skytra World  https://skytra.atlassian.net/browse/CMP-20


###### PERFORM SAME 30 LINES PREPARATORY PROJECT AND LOGIN STEPS FROM CMP-11
"""
ie
$prj='skytra-benchmark-prod'	etc
git checkout master				etc
gcloud auth login cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com


#590 gsutil cp DAG
dep on #588 gsutil cp csv
dep on #589 gsutil cp sql x2
dep on JN trillo change
dep on #593 bq q deploy sp + bq cp x3 + bq q call sp
"""

# dep on #593

#    First time deployment of controlled Dimension requires in-place migration of table schema and copy of 2 helper tables
#    https://skytra.atlassian.net/wiki/spaces/IN/pages/852295681/BQ+Golden+Table+Snapshotter+for+controlled+Dimension+Snapshots

bq query --project_id=$prj --replace --use_legacy_sql=false --destination_table generic.index_rrpk_model_params_201811_201911 "select DATE'2001-01-01' as last_update, * EXCEPT(calibration_date) from generic.index_rrpk_model_params_201811_201911"

bq cp skytra-benchmark-uat:generic.index_rrpk_model_params_201811_201911_history generic.index_rrpk_model_params_201811_201911_history 
bq cp skytra-benchmark-uat:generic.index_rrpk_model_params_201811_201911_staging generic.index_rrpk_model_params_201811_201911_staging

bq --project_id=$prj --location=EU mk --dataset --description "generic dataset procs" generic_sp

cd c:\git\index2\bq\r\sp

$qrys='generic_sp.sp_update_any_compliant_snapshot'
foreach ($q in $qrys) { 
	$cmd = "Get-Content $q.sql | bq query --project_id=$prj --use_legacy_sql=false"
	$cmd | Invoke-Expression
}

bq query --project_id=$prj --use_legacy_sql=false "CALL generic_sp.sp_update_any_compliant_snapshot('generic.index_rrpk_model_params_201811_201911', FALSE, 'region_pair')"


#588 gsutil cp csv

cd ..\..\csv

gsutil cp generic.product_ba_label_dim.csv gs://bq-generic/prod_dims/generic.product_ba_label_dim.csv


# deploy DAGs and their dependencies
#--------------------------------------------------------------

cd c:\git\index2\af\dags
$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'

#589 gsutil cp sql x2

$qrys='sq/X12.sql','sq/X13.sql'
foreach ($q in $qrys) { 
	$cmd = "gsutil -m cp -r $q $bkt_dag/$q"
	$cmd | Invoke-Expression
} 


# 590 gsutil cp DAG

$qrys='dag_BA_Trillo_Staging_daily_v5_0_2.py'
foreach ($q in $qrys) { 
	$cmd = "gsutil -m cp -r $q $bkt_dag/$q"
	$cmd | Invoke-Expression
} 


###### TEST PLAN
"""
Immediate
-----------------------
In Airflow, confirm modf DAGS 
[SUCCESS] - code view shows modf
[SUCCESS] - graph view shows new steps (SKWW)
[SUCCESS] - compile without error

Take rendered SQL for 
[SUCCESS] -- new steps (SKWW) and check compiles in BQ (new data will not be present until tomorrow)
[SUCCESS] -- existing step and check presence of ISINs

[SUCCESS] - take rendered GCS path for new steps (SKWW) and confirm path exists in Trillo Prod

Next Day
-----------------------
[] - log onto Trillo production at 11:15 following day and confirm presence of new file and ISINs
"""



