
# https://skytra.atlassian.net/browse/CMP-18
# deploy https://bitbucket.org/indexproduction_SK/indexproduction/pull-requests/572/kiwi-parquet-load-failover-hourly

###### PERFORM SAME 30 LINES PREPARATORY PROJECT AND LOGIN STEPS FROM CMP-11

# deploy DAGs and their dependencies


cd c:\git\index2\
git checkout master
git pull

$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'

cd af\dags

$qrys='dag_kiwi_daily_v5_0_0.py'
foreach ($q in $qrys) { 
	$cmd = "gsutil -m cp -r $q $bkt_dag/$q"
	$cmd | Invoke-Expression
} 


###### TEST PLAN
"""
Immediate
-----------------------
In Airflow, confirm modf DAGS 
[DONE] - code view shows modf
[DONE] - graph view shows new/modf steps
[DONE] - compile without error

[DONE] - rendered bq command for an Hourly Load is correct

Next Scheduled Load
-----------------------
1. Monitor Kiwi DAG
"""