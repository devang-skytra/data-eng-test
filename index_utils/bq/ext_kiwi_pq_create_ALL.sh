#!/bin/bash

cd /home/paul_desmond/code/index2/bq/t

#bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_TEST.ext_kiwi_pq_201901
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_TEST.ext_kiwi_pq_201902
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_TEST.ext_kiwi_pq_201903
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_TEST.ext_kiwi_pq_201904
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_TEST.ext_kiwi_pq_201905
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_TEST.ext_kiwi_pq_201906
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_TEST.ext_kiwi_pq_201907
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_TEST.ext_kiwi_pq_201908
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_TEST.ext_kiwi_pq_201909
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_TEST.ext_kiwi_pq_201910
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_TEST.ext_kiwi_pq_201911
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_TEST.ext_kiwi_pq_201912

bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_PROD.ext_kiwi_pq_201901
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_PROD.ext_kiwi_pq_201902
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_PROD.ext_kiwi_pq_201903
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_PROD.ext_kiwi_pq_201904
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_PROD.ext_kiwi_pq_201905
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_PROD.ext_kiwi_pq_201906
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_PROD.ext_kiwi_pq_201907
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_PROD.ext_kiwi_pq_201908
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_PROD.ext_kiwi_pq_201909
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_PROD.ext_kiwi_pq_201910
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_PROD.ext_kiwi_pq_201911
bq mk --external_table_definition=./kiwi.ext_kiwi_pq.json kiwi_PROD.ext_kiwi_pq_201912