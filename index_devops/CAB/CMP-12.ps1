
# v5 Compliance  https://skytra.atlassian.net/browse/CMP-12

###### PERFORM SAME 30 LINES PREPARATORY PROJECT AND LOGIN STEPS FROM CMP-11

# deploy DAGs and their dependencies


cd c:\git\index2\
git checkout master
git pull


$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'

cd af\dags

$qrys='dag_kiwi_daily_v5_0_0.py'
foreach ($q in $qrys) { 
	$cmd = "gsutil -m cp -r $q $bkt_dag/$q"
	$cmd | Invoke-Expression
} 


git checkout Develop
git pull


##### DO THIS LAST BECAUSE DON'T WANT TO CLOG UP POWERSHELL FOR 40 MINUTES
#####   THIS ASSUMES DEPLOYMENT DATE IS 10TH - IF SO, NEED A ONE-OFF FIX TO PROVIDE X2 FOR 9TH FOR FIRST RUN ON 11TH
bq load --project_id=skytra-benchmark-prod --location=EU --replace --source_format=PARQUET kiwi.X2_1209 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=09/*.gz.parquet"
# bq load --project_id=skytra-benchmark-prod --location=EU --replace --source_format=PARQUET kiwi.X2_1210 "gs://ext-kiwi-excl-data/data/y=2020/m=12/d=10/*.gz.parquet"



# IN-1914 datasets and tables 

bq --location=EU mk --dataset --description "compliance dataset" compliance
bq --location=EU mk --dataset --description "compliance proc dataset" compliance_sp

cd c:\git\index2\bq\t

bq mk --table --time_partitioning_field date_received --schema ./compliance.C000_X1_with_X6_meta.json compliance.C000_X1_with_X6_meta
bq mk --table --time_partitioning_field flight_date --schema ./compliance.C001_iata_dashboard_data.json compliance.C001_iata_dashboard_data
bq mk --table --time_partitioning_field search_date --require_partition_filter --schema ./compliance.C100_kiwi_aggregate.json compliance.C100_kiwi_aggregate
bq mk --table --time_partitioning_field search_date --require_partition_filter --schema ./compliance.C101_kiwi_dashboard_data.json compliance.C101_kiwi_dashboard_data
bq mk --table --time_partitioning_field alert_creation_date --clustering_fields alert_type,last_update --schema ./compliance.C999_alerts.json compliance.C999_alerts
bq mk --table --schema compliance.detected_routes.json compliance.detected_routes

"""
Error decoding JSON schema from file ./compliance.C000_X1_with_X6_meta.json: 'charmap' codec can't decode byte 0x9d
in position 3137: character maps to <undefined>
To specify a one-column schema, use "name:string".

	due to “TKID”...

compliance.C999_alerts
BigQuery error in mk operation: The field specified for partitioning cannot be
found in the schema.

	should have been alert_creation_date
"""

# 1918 The following 3 tables  must be copied form uat/Migr to Prod

bq cp skytra-benchmark-uat:compliance.directly_reporting_airlines compliance.directly_reporting_airlines
bq cp skytra-benchmark-uat:compliance.high_risk_airlines compliance.high_risk_airlines
bq cp d-dat-digitalaircrafttransport:generic.airlines_ticketing generic.airlines_ticketing



# IN-1921 populate tables 

bq query --project_id=$prj --use_legacy_sql=false "insert into compliance.C000_X1_with_X6_meta  select * from `skytra-benchmark-uat.compliance.C000_X1_with_X6_meta` ;"

bq cp skytra-benchmark-uat:compliance.C001_iata_dashboard_data compliance.C001_iata_dashboard_data
bq cp skytra-benchmark-uat:compliance.C100_kiwi_aggregate compliance.C100_kiwi_aggregate
bq cp skytra-benchmark-uat:compliance.C101_kiwi_dashboard_data compliance.C101_kiwi_dashboard_data
bq cp skytra-benchmark-uat:compliance.C999_alerts compliance.C999_alerts
bq cp skytra-benchmark-uat:compliance.detected_routes compliance.detected_routes

bq update --require_partition_filter=false compliance.C101_kiwi_dashboard_data


'''
BigQuery error in cp operation: Error processing job skytra-benchmark-
prod:bqjob_r737cd167ebf52887_000001764d383e8e_1: Failed to copy skytra-
benchmark-uat:compliance.C999_alerts to skytra-benchmark-
prod:compliance.C999_alerts: incompatible clustering fields.
'''

'''
bq query --project_id=$prj --use_legacy_sql=false "insert into compliance.C001_iata_dashboard_data  select * from `skytra-benchmark-uat.compliance.C001_iata_dashboard_data` ;"

bq query --project_id=$prj --use_legacy_sql=false "insert into compliance.C100_kiwi_aggregate  select * from `skytra-benchmark-uat.compliance.C100_kiwi_aggregate` ;"

bq query --project_id=$prj --use_legacy_sql=false "insert into compliance.C101_kiwi_dashboard_data  select * from `skytra-benchmark-uat.compliance.C101_kiwi_dashboard_data` ;"

bq query --project_id=$prj --use_legacy_sql=false " insert into compliance.C999_alerts  select * from `skytra-benchmark-uat.compliance.C999_alerts` ; "

bq query --project_id=$prj --use_legacy_sql=false "insert into compliance.detected_routes  select * from `skytra-benchmark-uat.compliance.detected_routes` ;"
'''

# *****  PROCs deploy
# *****************************************************


cd c:\git\index2\bq\r\sp
cd compliance

$qrys='compliance_sp.sp_process_C000_daily','compliance_sp.sp_process_C000_history','compliance_sp.sp_process_C000_weekly','compliance_sp.sp_process_C001_iata_dashboard_data','compliance_sp.sp_process_C001_capacity_alerts','compliance_sp.sp_process_C001_channels_transactions_alerts','compliance_sp.sp_process_C001_unknown_routes_airports_alerts','compliance_sp.sp_process_C001_unmatched_alerts','compliance_sp.sp_process_C101_kiwi_dashboard_data','compliance_sp.sp_process_C101_kiwi_alerts'

$qrys='compliance_sp.sp_process_C100_kiwi_aggregate'
foreach ($q in $qrys) { 
	#Get-Content $q | bq query --project_id=$prj --use_legacy_sql=false 
	$cmd = "Get-Content $q.sql | bq query --project_id=$prj --use_legacy_sql=false"
	#echo $cmd
	$cmd | Invoke-Expression
} #Write-Output



