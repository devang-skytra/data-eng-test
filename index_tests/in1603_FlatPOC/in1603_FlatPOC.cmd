
REM IN-1603	 

REM	email to Eric with details -	Tue, Jul 14, 2020 at 9:37 AM NARRAVULA, Khanna

REM 	1. How long does it take a 1 day kiwi processing in 500 slots	
REM [ confirm DAG step logging is accurate so will allow accurate comparisons ]
REM [ DAG already present in UAT, just Clear and rerun given day ]

REM 	2. How long does it take a matching of a weekly iata file (35 dates) in 500 slots?
REM [ need 35 days of X5b and several weeks of iata to reflect non-ptn nature of I2 and I3 filters ]
REM [ spX6 might need to point to separate X5b_35_days if want to isolate from 1) for deletion/test clarify purposes ]
REM [ carefully assess spX6 dependencies to avoid repetition/failure ]

REM 	3. How long does it take the iata processing in 500 slots X3-I3?
REM [ check if X3-I3 ever run in UAT? if not, deploy and... ]
REM [ ...carefully assess sp* dependencies to avoid repetition/failure ]


REM gcloud config get-value core/project
REM gcloud config set core/project d-dat-digitalaircrafttransport
REM gcloud config set core/project skytra-benchmark-devandtest
REM gcloud config set core/project skytra-benchmark-uat

SET ds=in1603_FlatPOC

-- TABLES FROM DEFN
----------------------------------------
	cd \
	cd git\index2\bq\t

	bq mk --table --time_partitioning_field dt_of_issue --require_partition_filter --clustering_fields ticket_id --schema ./iata.I1.json %ds%.I1
	bq mk --table --time_partitioning_field dt_of_issue --require_partition_filter --clustering_fields ticket_id --schema ./iata.I2.json %ds%.I2
	bq mk --table --time_partitioning_field dt_of_issue --require_partition_filter --clustering_fields ticket_id --schema ./iata.I3.json %ds%.I3
	bq mk --table --time_partitioning_field dt_of_issue --require_partition_filter --clustering_fields ticket_id --schema ./iata.X3.json %ds%.X3_daily
REM X3 or X3_daily ??

	bq mk --table --time_partitioning_field search_date --require_partition_filter --time_partitioning_expiration 950400 --schema ./kiwi.X4.json %ds%.X4
	bq mk --table --time_partitioning_field search_date --require_partition_filter --time_partitioning_expiration 950400 --schema ./kiwi.X5a.json %ds%.X5a
	bq mk --table --time_partitioning_field search_date --require_partition_filter --time_partitioning_expiration 4320000 --schema ./kiwi.X5b.json %ds%.X5b
	
	bq mk --table --time_partitioning_field dt_of_issue --clustering_fields first_flight_date_utc,region_pair --schema ./matching.X6.json %ds%.X6
	
-- AIRFLOW
REM https://stackoverflow.com/questions/39755684/sed-equivalent-in-a-bat-file?rq=1
REM sed -i '$ s/,/;/g' abc.java
REM call jrepl "," ";" /inc -1 /f abc.java /o -			NB: overwrites file like sed does so copy first


	SET locDags=c:\git\index2\af\dags\
	SET bktDags=gs://europe-west2-benchmark-devt-6ca0db0f-bucket/dags
	gsutil cp %locDags%dag_iata_daily.py %bktDags%

	gsutil cp %locDags%dag_kiwi_daily_v2.py %bktDags%
	


REM July 28th extra big Kiwi test to see if linear increase in time 
	
SET bktPfx=gs://ext-kiwi-excl-
SET ym=y=2020/m=01
SET bktMD=%bktPfx%data/data/%ym%
SET bktMDU=%bktPfx%uat-data/data/%ym%

SET d=d=15
echo gsutil -m cp -r %bktMD%/%d% %bktMDU%/%d%


SET bktMS=%bktPfx%stat/stats/%ym%
SET bktMSU=%bktPfx%uat-stat/stats/%ym%
echo gsutil -m cp -r %bktMS%/%d% %bktMSU%/%d%


backfill dag_kiwi_daily_FlatRate 2020-01-15 00:00:00

