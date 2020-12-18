

bq show --format=prettyjson kiwi.X2_1214_340 > kiwi.X2_1214_340.json


# 340
bq load --project_id=d-dat-digitalaircrafttransport --location=EU --replace --source_format=PARQUET kiwi.X2_1214_340 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=12/part-00340-73eb6458-a75f-4990-84fa-c36983b9368a-c000.gz.parquet"


# 341
bq load --project_id=d-dat-digitalaircrafttransport --location=EU --replace --source_format=PARQUET kiwi.X2_1214_341 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=12/part-00341-73eb6458-a75f-4990-84fa-c36983b9368a-c000.gz.parquet"

# 342
bq load --project_id=d-dat-digitalaircrafttransport --location=EU --replace --source_format=PARQUET kiwi.X2_1214_342 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=12/part-00342-73eb6458-a75f-4990-84fa-c36983b9368a-c000.gz.parquet"



#[DONE] 00-04
bq load --project_id=skytra-benchmark-prod --location=EU --source_format=PARQUET kiwi.X2_1214 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=00*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=01*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=02*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=03*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=04*.gz.parquet"

#[DONE] 05-09
bq load --project_id=skytra-benchmark-prod --location=EU --source_format=PARQUET kiwi.X2_1214 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=05*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=06*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=07*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=08*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=09*.gz.parquet"

#[DONE] 10-11
bq load --project_id=skytra-benchmark-prod --location=EU --source_format=PARQUET kiwi.X2_1214 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=10*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=11*.gz.parquet"



#[CONTINUOUS FAILURE] 12
bq load --project_id=skytra-benchmark-prod --location=EU --source_format=PARQUET kiwi.X2_1214 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=12*.gz.parquet"

#[DONE] 14-15
bq load --project_id=skytra-benchmark-prod --location=EU --source_format=PARQUET kiwi.X2_1214 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=14*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=15*.gz.parquet"

#[DONE] 13,16-17,18-19
bq load --project_id=skytra-benchmark-prod --location=EU --source_format=PARQUET kiwi.X2_1214_partial "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=13*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=16*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=17*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=18*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=19*.gz.parquet"

#[DONE] 2* ie 20-23
bq load --project_id=skytra-benchmark-prod --location=EU --source_format=PARQUET kiwi.X2_1214 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=2*.gz.parquet"


gsutil du -sh gs://ext-kiwi-excl-data/data/y=2020/m=01/d=20


0.28 TiB  gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14

1.33 TiB  gs://ext-kiwi-excl-data/data/y=2020/m=01/d=20



PS C:\> bq load --project_id=skytra-benchmark-prod --location=EU --source_format=PARQUET kiwi.X2_1214 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=10*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=11*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=14/hr=12*.gz.parquet"
Waiting on bqjob_r19d0405c3d61c793_0000017667d6ef18_1 ... (708s) Current status: DONE
BigQuery error in load operation: Error processing job 'skytra-benchmark-
prod:bqjob_r19d0405c3d61c793_0000017667d6ef18_1': Resources exceeded during
query execution: The query could not be executed in the allotted memory. Peak
usage: 106% of limit.
Top memory consumer(s):
input table/file scan: 82%
other/unattributed: 18%



