
# 15th

#00    PAUL
bq load --project_id=d-dat-digitalaircrafttransport --location=EU --source_format=PARQUET kiwi.X2_1215 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=00*.gz.parquet"

#01-06 PAUL
bq load --project_id=d-dat-digitalaircrafttransport --location=EU --source_format=PARQUET kiwi.X2_1215 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=01*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=02*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=03*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=04*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=05*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=06*.gz.parquet"

#07-12 DYLAN
bq load --project_id=d-dat-digitalaircrafttransport --location=EU --source_format=PARQUET kiwi.X2_1215 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=07*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=08*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=09*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=10*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=11*.gz.parquet","gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=12*.gz.parquet"



# kiwi X2 Dec 15th search date data
# PROBLEM HOURS 13,14,15,
# remaining 21 hrs fine

#13-14 PAUL
bq load --project_id=d-dat-digitalaircrafttransport --location=EU --source_format=PARQUET kiwi.X2_1215 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=13*.gz.parquet"
bq load --project_id=d-dat-digitalaircrafttransport --location=EU --source_format=PARQUET kiwi.X2_1215 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=14*.gz.parquet"

#15-16 DYLAN
bq load --project_id=d-dat-digitalaircrafttransport --location=EU --source_format=PARQUET kiwi.X2_1215 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=15*.gz.parquet"
bq load --project_id=d-dat-digitalaircrafttransport --location=EU --source_format=PARQUET kiwi.X2_1215 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=16*.gz.parquet"

#17-19 SAMAR
bq load --project_id=d-dat-digitalaircrafttransport --location=EU --source_format=PARQUET kiwi.X2_1215 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=17*.gz.parquet"
bq load --project_id=d-dat-digitalaircrafttransport --location=EU --source_format=PARQUET kiwi.X2_1215 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=18*.gz.parquet"
bq load --project_id=d-dat-digitalaircrafttransport --location=EU --source_format=PARQUET kiwi.X2_1215 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=19*.gz.parquet"



#20-23 SAMAR
bq load --project_id=d-dat-digitalaircrafttransport --location=EU --source_format=PARQUET kiwi.X2_1215 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=15/hr=2*.gz.parquet"

