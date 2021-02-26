
# https://skytra.atlassian.net/browse/CMP-  Route Exclusions

$prj='skytra-benchmark-uat'
#$prj='skytra-benchmark-prod'

gcloud config set core/project $prj

# gcloud auth login cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com

# git checkout master
# git pull


# *****  SCHEMA
# *****************************************************

bq query --location=EU --use_legacy_sql=false """
CREATE OR REPLACE TABLE generic.exclusion_compliance(
divisor_type    STRING,
divisor_code    STRING,
secondary_code  STRING,
secondary_price NUMERIC,
tertiary_code  STRING,
date_join_type  STRING,
start_date_DOI  DATE,
end_date_DOI    DATE,
start_date_FFD  DATE,
end_date_FFD    DATE,
start_date_PIPELINE DATE,
end_date_PIPELINE 	DATE,
create_date    	DATE,
create_user  	STRING,
end_dated_date  DATE,
end_dated_user  STRING,
end_date_PIPELINE_original	DATE
);

CREATE OR REPLACE TABLE generic_stage.exclusion_compliance(
divisor_type    STRING,
divisor_code    STRING,
secondary_code  STRING,
secondary_price NUMERIC,
tertiary_code  STRING,
date_join_type  STRING,
start_date_DOI  DATE,
end_date_DOI    DATE,
start_date_FFD  DATE,
end_date_FFD    DATE,
start_date_PIPELINE DATE,
end_date_PIPELINE 	DATE,
create_date    	DATE,
create_user  	STRING,
end_dated_date  DATE,
end_dated_user  STRING,
end_date_PIPELINE_original	DATE,

IUD_operation   STRING,
bq_job_id       STRING
);
"""




# *****  Airflow gsutil DEPLOY 
# *****************************************************

cd c:\git\index2\af\dags

$bkt_dag='gs://europe-west2-benchmark-uat--2bf16b72-bucket/dags'
# $bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'

$files='sh/zops_generic_deploy.sh','sq/exclusion_compliance_check.sql','dag_zops_MASTER_DATA_handler.py'
foreach ($f in $files) { 
	$cmd = "gsutil -m cp -r $f $bkt_dag/$f"
	$cmd | Invoke-Expression
} 


# *****  PROCs deploy
# *****************************************************


cd c:\git\index2\bq\r\sp

$qrys='generic_sp.sp_exclusion_compliance_add','generic_sp.sp_exclusion_compliance_deactivate_row'
foreach ($q in $qrys) { 
	$cmd = "Get-Content $q.sql | bq query --project_id=$prj --use_legacy_sql=false"
	$cmd | Invoke-Expression
}


# seed table with current single compliance exclusion
bq query --project_id=$prj --use_legacy_sql=false "CALL generic_sp.sp_exclusion_compliance_add('route','%202101141400_ISB-KHI%','FFD', '2020-11-09', '2999-09-09', '1999-09-09', '2999-09-09');"
bq query --project_id=$prj --use_legacy_sql=false "CALL generic_sp.sp_exclusion_compliance_add('route','%202101140500_ISB-KHI%','FFD', '2020-11-09', '2999-09-09', '1999-09-09', '2999-09-09');"


###### TEST PLAN
"""

Immediate
-----------------------
[SUCCESSFUL] - In Airflow, take rendered SQL for X12 and run against BigQuery and confirm expected tickets excluded
"""
