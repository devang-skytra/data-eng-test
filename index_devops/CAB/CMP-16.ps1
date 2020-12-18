
# Trillo  https://skytra.atlassian.net/browse/CMP-16
# deploy https://bitbucket.org/indexproduction_SK/indexproduction/pull-requests/563

###### PERFORM SAME 30 LINES PREPARATORY PROJECT AND LOGIN STEPS FROM CMP-11

# deploy DAGs and their dependencies


cd c:\git\index2\
git checkout master
git pull

bq query --project_id=$prj --use_legacy_sql=false "CREATE OR REPLACE EXTERNAL TABLE generic.bank_holidays_ext OPTIONS( format = 'NEWLINE_DELIMITED_JSON', uris = ['gs://bq-generic/holiday_dims/gov_uk_bank_holidays.json'] );"

$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'

cd af\dags

$qrys='dag_BA_Trillo_BizDays_v5_0_2.py','dag_BA_Trillo_Staging_daily_v5_0_2.py'
foreach ($q in $qrys) { 
	$cmd = "gsutil -m cp -r $q $bkt_dag/$q"
	$cmd | Invoke-Expression
} 


###### TEST PLAN
"""
Immediate
-----------------------
In Airflow, confirm modf DAGS 
[DONE] - code view shows modf
[DONE] - graph view shows new/modf steps
[DONE] - compile without error

[DONE] - take rendered SQL for modf BizDay check and manually run in BQ and confirm expected result occurs
	SELECT EXTRACT(DAYOFWEEK FROM CURRENT_DATE) NOT IN(1,7), 0 = (select count(*) from generic.bank_holidays_ext, UNNEST(england_and_wales.events) as eng_hols where eng_hols.date = CURRENT_DATE)

[DONE] - take rendered GCS path and confirm using powershell that rendered path/file contents matches Trillo Prod
	gsutil cp -r gs://trillo-stage-prod/groups/** gs://skt-prod-trillostore-0f57/groups/Internal_SIDF_Daily_Check/
	vs
	gsutil mv -r gs://trillo-stage-prod/groups gs://skt-prod-trillostore-0f57
	
	gsutil ls gs://skt-prod-trillostore-0f57/groups/Internal_SIDF_Daily_Check/


Next Day
-----------------------
1. Log on to Trillo production at 11:15 following day and confirm presence of files
2. Spot check content (fully content check to happen as part of formal daily Index review).



"""