
$prj='skytra-benchmark-prod'

gcloud config set core/project $prj

gcloud auth login cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com

git checkout master
git pull

cd c:\git\index2\af\dags

$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'

$files='py/op_gen.py','py/slack_messages.py','iata/sq/airflow_tasks_log.sql'
foreach ($f in $files) { 
	$cmd = "gsutil -m cp -r $f $bkt_dag/$f"
	$cmd | Invoke-Expression
} 

gsutil mv $bkt_dag/dag_iata_daily_v5_0_1.py $bkt_dag/iata/dag_iata_daily_v5_0_1.py


""" according to Paulo, tests_sp.index_review is just a placeholder so dont deploy
cd c:\git\index2\bq\r\sp

$qrys='tests_sp.index_review'
foreach ($q in $qrys) { 
	$cmd = Get-Content $q.sql | bq query --project_id=$prj --use_legacy_sql=false
	$cmd | Invoke-Expression
}
"""