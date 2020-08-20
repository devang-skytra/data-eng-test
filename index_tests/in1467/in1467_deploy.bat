/* resources

gcloud config get-value core/project 

gcloud config set core/project skytra-benchmark-uat
gcloud config set core/project d-dat-digitalaircrafttransport

IN-1467 

*/

-- RegrTests
----------------------------------------

-- IATA C:\Users\PaulDesmond\OneDrive - SKYTRA LIMITED\UATvPRODregrTests\I3_20200713.xlsx
-- KIWI C:\Users\PaulDesmond\OneDrive - SKYTRA LIMITED\UATvPRODregrTests\X5b_20200713.xlsx



-- Further Checks
----------------------------------------

[CONFIRMED] confirm DevTest change to BST works as expected



-- BACKUPS Tuesday late afternoon
----------------------------------------
----------------------------------------

SELECT 
CONCAT( 'bq cp ', table_schema, '.', table_name, ' scratch_PaD_PreDeployBak_Expire14d.', table_name, '_20200721') as bq_bak 
FROM iata.INFORMATION_SCHEMA.TABLES
where table_name like 'I_' or table_name like 'X_'
order by 1

bq cp iata.I1 zzz_PreDeployBak_Expire14d.I1_20200721

bq cp iata.I2 zzz_PreDeployBak_Expire14d.I2_20200721

bq cp iata.I3 zzz_PreDeployBak_Expire14d.I3_20200721

bq cp iata.X1 zzz_PreDeployBak_Expire14d.X1_20200721

bq cp iata.X3 zzz_PreDeployBak_Expire14d.X3_20200721


-- DEPLOYMENT Tuesday late afternoon
----------------------------------------
----------------------------------------


-- Config
----------------------------------------

Disable af DAG 'dag_iata_daily'

GCC Migrate Config to use BST - default_timezone	Europe/London



cd \

	
-- BQ
----------------------------------------
cd git\index2\bq\t
	
	bq query | ./airflow.af_check_X1
		(already present) generic.ext_file_source_log_defn.json
	bq mk --external_table_definition=./stat.iata_stats_defn.json stat.iata_stats
	bq mk --table --time_partitioning_field dt_of_issue --require_partition_filter --clustering_fields ticket_id --schema ./iata.X3.json iata.X3_daily
	cd ..\r\sp
	
	bq query | iata_sp.sp_process_X3.sql
	bq query | iata_sp.sp_process_I1.sql


	


-- AIRFLOW
----------------------------------------
	
	Will need to adjust afStartDate to 19th
	
	
	SET locDags=C:\git\index2\af\dags\
	
	look in af utils for full py/sq/dags script
	
	
	dag_iata_daily.py 
	dag_kiwi_daily.py
	
--ERRORS

	op_gen.py most recent was required
	./sq/airflow_tasks_log.sql not found
	
	op_gen.py airflow version schema_update_options behaviour tuple vs list
		#schema_update_options = allow_new,





