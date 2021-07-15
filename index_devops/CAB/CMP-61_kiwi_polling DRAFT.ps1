
# v5  

$prj='skytra-benchmark-prod'
gcloud config set core/project $prj

gcloud auth login cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com

git checkout master
git pull


# *****  CLOUD FUNCTION DEPLOY 
# *****************************************************

cd c:\git\index2\gcf
# then use use https://bitbucket.org/skt-data/indexproduction/src/ae428c3423a5f5c63691f659827d513888419fc0/gcf/kiwi_api_polling/deploy-kiwi-polling-gcf.sh

# *****  Airflow gsutil deploy
# *****************************************************


cd c:\git\index2\af\dags

$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'

$qrys='',''
foreach ($q in $qrys) { 
	$cmd = "gsutil -m cp -r $q $bkt_dag/$q"
	$cmd | Invoke-Expression
} 

gsutil -m cp -r ./dag_zops* $bkt_dag


# VALIDATION








