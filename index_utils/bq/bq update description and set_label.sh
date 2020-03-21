
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



matching 
-------------------------------
bq update --description "Created using Airflow DAGs: DAG: dag_IATA_X6_PROD_YYYY* x4" \
  --set_label mode:airflow \
  --set_label operator:af-bashoperator-bqproc \
  --set_label start:2019-01-01 \
  --set_label end:append-forever \
  --set_label version:4-2 \
  matching.X6

