
# v5  

$prj='skytra-benchmark-prod'
gcloud config set core/project $prj

gcloud auth login cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com

git checkout master
git pull

# *****  Airflow gsutil deploy
# *****************************************************

cd c:\git\index2\af\dags

$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'

gsutil -m cp -r spi_csv $bkt_dag

gsutil rm $bkt_dag/sq/BA_X13*
gsutil rm $bkt_dag/dag_BA_Trillo*

# CLEANUP

gsutil rm $bkt_dag/sq/BA_X7*
gsutil rm $bkt_dag/sq/X4.sql
gsutil rm $bkt_dag/sq/X5b_SIDs.sql
gsutil rm $bkt_dag/sq/X7*

gsutil rm -r $bkt_dag/sh

gsutil rm $bkt_dag/py/data_quality_control.py
gsutil rm $bkt_dag/py/load_fx_prices.py


gsutil rm $bkt_dag/dag_iata_daily_v2_2.py
gsutil rm $bkt_dag/dag_kiwi_daily.py
gsutil rm $bkt_dag/dag_kiwi_daily_parallel_v5_0_ProdReadLocalGCSTest.py
gsutil rm $bkt_dag/dag_matching_daily_v1_1.py
gsutil rm $bkt_dag/dag_zops*
