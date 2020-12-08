
# v5 Compliance  https://skytra.atlassian.net/browse/CMP-11

###### PERFORM SAME 30 LINES PREPARATORY PROJECT AND LOGIN STEPS FROM CMP-11

# deploy DAGs and their dependencies


$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'

$qrys='af/dags/dag_kiwi_daily_v5_0_0.py'
foreach ($q in $qrys) { 
	$cmd = "gsutil -m cp -r $q $bkt_dag/$q"
	$cmd | Invoke-Expression
} 

##### THIS ASSUMES DEPLOYMENT DATE IS 10TH - IF SO, NEED A ONE-OFF FIX TO PROVIDE X2 FOR 9TH FOR FIRST RUN ON 11TH
bq load --project_id=skytra-benchmark-prod --location=EU --replace --source_format=PARQUET kiwi.X2_1209 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=09/*.gz.parquet"

