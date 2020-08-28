REM cd c:\git\index2\af\dags

gcloud auth login cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com


SET bkt_dag=gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags

gsutil -m cp -r py %bkt_dag%/py
gsutil -m cp -r sq %bkt_dag%/sq

SET dag=dag_fxrates.py
gsutil -m cp -r %dag% %bkt_dag%/%dag%

SET dag=dag_iata_daily_v2_2.py
gsutil -m cp -r %dag% %bkt_dag%/%dag%

SET dag=dag_kiwi_daily.py
gsutil -m cp -r %dag% %bkt_dag%/%dag%

SET dag=dag_matching_daily_v1_1.py
gsutil -m cp -r %dag% %bkt_dag%/%dag%

REM cd c:\git\index2


gcloud auth login paul.desmond@skytraindices.com





REM CLEANUP ***************************

SET dag=dag_iata_daily_v2_1.py
gsutil rm %bkt_dag%/%dag%

SET dag=dag_matching_daily.py
gsutil rm %bkt_dag%/%dag%





REM RESOLVE ***************************

SET py=op_gen.py
gsutil cp py\%py% %bkt_dag%/py/%py%