/* days to seconds
1  - 86400
5  - 432000 
50 - 4320000

gcloud config set core/project skytra-benchmark-devandtest
gcloud config set core/project d-dat-digitalaircrafttransport


*/
bq update --time_partitioning_expiration 950400 kiwi.X4 
bq update --time_partitioning_expiration 950400 kiwi.X5a 
bq update --time_partitioning_expiration 4320000 kiwi.X5b 


bq update --set_label etl_service:airflow 

kiwi_PROD
-------------------------------
bq update --description "Created using Airflow DAGs: dag_PROD_kiwi_3x_PROD__2019MM x12" \
  --set_label mode:airflow \
  --set_label operator:af-bqoperator \
  --set_label start:truncated \
  --set_label version:4-2 \
  kiwi_PROD.X4_2019
  
bq update --description "Created using Airflow DAGs: dag_PROD_kiwi_3x_PROD__2019MM x12" \
  --set_label mode:airflow \
  --set_label operator:af-bqoperator \
  --set_label start:truncated \
  --set_label version:4-2 \
  kiwi_PROD.X5a_2019
  
bq update --description "Created using Airflow DAGs: dag_PROD_kiwi_3x_PROD__2019MM x12" \
  --set_label mode:airflow \
  --set_label operator:af-bqoperator \
  --set_label start:2019-01-01 \
  --set_label end:append-forever \
  --set_label version:4-2 \
  kiwi_PROD.X5b_2019

