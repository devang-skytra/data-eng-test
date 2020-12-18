
# DEPLOY
#------

$branch='master'
git checkout $branch
git pull

cd C:\git\index2\af\dags

#DevTest
#$inst='benchmark-devtest-composer-3'	
#$bkt_dag='gs://europe-west2-benchmark-devt-6ca0db0f-bucket/dags'

#UAT
#$inst='benchmark-uat-composer2'		
#$bkt_dag='gs://europe-west2-benchmark-uat--2bf16b72-bucket/dags'

#PROD	
#$inst='??'
#$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'

#Migr	
$inst='af-kiwi-2019'
$bkt_dag='gs://europe-west2-af-kiwi-2019-336f8a73-bucket/dags'


#$sq='sq/X5b.*'
#gsutil -m cp -r $sq $bkt_dag/sq

$dag='dag_iata_daily_v2_3.py'
gsutil cp $dag $bkt_dag/$dag


gcloud composer environments pause $inst --location europe-west2 dag_iata_daily_v2_2


# RUN
#------

# https://airflow.apache.org/docs/stable/cli-ref#backfill
$dag_id='dag_kiwi_daily_parallel'
$bf_start='2020-09-10'
$bf_end='2020-09-12'
gcloud composer environments run $inst --location europe-west2 backfill -- $dag_id --start_date $bf_start --end_date $bf_end --reset_dagruns

# CLEAR
#------


gcloud config set core/project skytra-benchmark-uat

$inst='benchmark-uat-composer2'
$dag_id='dag_BackNone_Catch_Paral'
$task='bashEcho2'
$bf_start='2020-07-04'

gcloud composer environments run $inst --location europe-west2 clear -- $dag_id --start_date $bf_start -t $task --downstream --no_confirm 
# --only_failed


gcloud config set core/project skytra-benchmark-prod

$inst='benchmark-prod-composer'		
$dag_id='dag_kiwi_daily_v5_0_0'
$task='X5aPartReplace'
$bf_start='2020-12-09'

gcloud composer environments run $inst --location europe-west2 clear -- $dag_id --start_date $bf_start -t $task --downstream

