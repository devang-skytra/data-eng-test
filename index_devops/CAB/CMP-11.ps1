
# v5 Trillo  https://skytra.atlassian.net/browse/CMP-11

"""
Compulsory pre-test - first time:
  using Trillo 2.0 buckets 
  and doing copy b/t Prod GCS 1.0 and Prod GCS 2.0 using Prod service account
  hence a small prod test has been done
    
	gcloud auth login cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com
	
    gsutil mv -r gs://trillo-stage-prod/groups/ASAS_SIDF gs://skt-prod-trillostore-0f57
	gsutil rm -r gs://skt-prod-trillostore-0f57/ASAS_SIDF
	
	# clean out very old original Prod Trillo testing results 
	# alternative might be gsutil rm gs://trillo-stage-prod/groups/**
	gsutil rm -r gs://trillo-stage-prod/groups/A*
	gsutil rm -r gs://trillo-stage-prod/groups/E*
	gsutil rm -r gs://trillo-stage-prod/groups/N*
	
"""

$prj='skytra-benchmark-prod'
gcloud config set core/project $prj

cd c:\git\index2\
git checkout master
git pull

gcloud auth login cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com

# deploy DAGs and their dependencies
#--------------------------------------------------------------
cd af\dags

$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'

$qrys='sq/BA_X13_SIDF.sql','sq/BA_X13_SISVDF.sql','dag_BA_Trillo_Staging_daily_v5_0_2.py'
foreach ($q in $qrys) { 
	$cmd = "gsutil -m cp -r $q $bkt_dag/$q"
	$cmd | Invoke-Expression
} 

$qrys='dag_BA_Trillo_BizDays_v5_0_2.py'
foreach ($q in $qrys) { 
	$cmd = "gsutil -m cp -r $q $bkt_dag/$q"
	$cmd | Invoke-Expression
} 

# since so few DAGs to deploy have done in loop above...
# ... rather than use ->   gsutil -m cp -r ./dag_BA_Trillo_*_v5_0_2.py $bkt_dag

# bq/csv/generic.product_ba_label_dim.csv shared from Migrated bucket and already deployed





