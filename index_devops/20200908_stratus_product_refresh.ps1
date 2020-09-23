

@'
# Dylan said - Well the reason for stopping the update had to do with issue in daily IATA files.
# wiki mostly valid except for the X3 update on RnD. We switch to the daily files taken dirently from iata.X1 on prod.
# As a sidenote I believe iata_sp.sp_process_X3 ought to be redeployed first.

#SELECT 'daily' as c1, min( FILE_SOURCE ) FROM `d-dat-digitalaircrafttransport.iata.X3_daily` WHERE dt_of_issue >= "1970-01-01" UNION ALL
#SELECT 'weekly' as c1, max( FILE_SOURCE )  FROM iata.X3 WHERE dt_of_issue <= "2099-01-01"
 

daily   IATA_daily_api_20200720
weekly  FinalOutput_2020-07-13_w_2020-07-19_Global.csv



#SELECT distinct FILE_SOURCE FROM iata.X3 WHERE dt_of_issue  >= "2020-07-01" order by 1 # Last modified Aug 11, 2020, 10:12:19 AM / 16,839,737,675 / 3.61 TB (16,752,496,548 in Migr)
# FinalOutput_2020-07-13_w_2020-07-19_Global.csv and then IATA_daily_api_20200720 to 26

# Last modified Aug 11, 2020, 10:12:19 AM
# SELECT substr(FILE_SOURCE,1,10) as srcType, count(*) FROM iata.X3 WHERE dt_of_issue  >= "1970-01-01" group by 1 order by 1  
# 16,839,737,675 / 16,816,475,239 without daily 3.61 TB (16,752,496,548 in Migr)




   update X1 with Prod Data from IATA_daily_api_20200727
     insert into iata.X1 select * from d-dat-digitalaircrafttransport.iata.X1 where file_date_int > 20200727
   deployed new X3_daily proc
   CALL `skytra-benchmark-rnd.iata_sp.sp_process_X3_daily`(20200727,20200907);
   
continue with Stratus...

	for R1 to R3 updated source 
		WHERE dt_of_issue >= '2017-10-19'
			with
		WHERE dt_of_issue >= '2017-10-19'
		AND FILE_SOURCE between 'IATA_daily_api_20200720' and 'IATA_daily_api_20200907'
		
	R4(n), R5, R6, R7x2 are all overwrites so no DOI or file filter needed
	
	R6 uses  ML.PREDICT(MODEL `PD_309.lin_reg_model_rrpk_all_region_dist_all_operators`,... which I assume is still current
	
	
	
	
"""
run following to see rows_written

SELECT job_type, MAX(j.status) as job_status, start_time, end_time, destination_table.dataset_id, destination_table.table_id, total_bytes_processed as total_bytes,
0 as rows_read, SUM(IF(j.name like '%: Output', j.records_written, 0)) as rows_written, 
FROM `region-eu.INFORMATION_SCHEMA.JOBS_BY_USER`, UNNEST(job_stages) AS j
WHERE 
DATE(creation_time) = CURRENT_DATE 
AND user_email LIKE '%desmond%'
GROUP BY 1,3,4,5,6,7
ORDER BY start_time desc
LIMIT 20
"""

'@


# with RnD project active in GUI
gcloud config set core/project skytra-benchmark-rnd

cd c:\git\index2
git pull
git checkout feature/IN-1092-create-a-waterfall-pricing-mecha
git pull
cd bq\sq\Iata-revenue-pipeline


# 1
bq query --project_id=skytra-benchmark-rnd --destination_table iata.X1 --append_table --use_legacy_sql=false --allow_large_results "select * from d-dat-digitalaircrafttransport.iata.X1 where file_date_int >= 20200727"


# 2 X3
CALL `skytra-benchmark-rnd.iata_sp.sp_process_X3_daily`(20200727,20200907);
# X3 					21,296,859 - 	22,191,924


# 3 R1
Get-Content R1.sql | bq query --destination_table iata.R1 --append_table --use_legacy_sql=false --allow_large_results
# R1 


# 4 R2 CASE STATEMENT gets broken by Bash so have to run manually
Get-Content R2.sql | bq query --destination_table iata.R2 --append_table --use_legacy_sql=false --allow_large_results 
# R2 


# 5 R3 
Get-Content R3.sql | bq query --destination_table iata.R3 --append_table --use_legacy_sql=false --allow_large_results 
# R3 

# 6 R4*

bq query --use_legacy_sql=false --allow_large_results "CALL index_sp.sp_process_R4_index(DATE('2017-10-19'), CURRENT_DATE());"
#
""" 
SELECT job_type, MAX(j.status) as job_status, start_time, end_time, destination_table.dataset_id, destination_table.table_id, total_bytes_processed as total_bytes,
0 as rows_read, SUM(IF(j.name like '%: Output', j.records_written, 0)) as rows_written, 
FROM `region-eu.INFORMATION_SCHEMA.JOBS_BY_USER`, UNNEST(job_stages) AS j
WHERE 
DATE(creation_time) = CURRENT_DATE 
AND user_email LIKE '%desmond%'
AND destination_table.table_id like 'R4%'
GROUP BY 1,3,4,5,6,7
ORDER BY start_time desc
LIMIT 20

											08/09/2020

R4_index19 987				994				1001
R4_index18 224,409			225,271			226,330		
R4_index17 14,786,435		14,818,664		14,868,862
R4_index16 157,447,483		157,727,858		158,192,621
...
R4_index11 1,008,034,374	1,009,981,705	1,013,636,761
...
R4_index03 287,643,519		288,541,503
"""

# 7 R5
Get-Content R5.sql | bq query --destination_table matching.R5 --replace --use_legacy_sql=false --allow_large_results
# R5 FinalOutput_2020-06-29__2020-07-05_Global.csv 8978050 8978050 5323613 8978050
# R5 FinalOutput_2020-07-06__2020-07-12_Global.csv 9485115 9485115 5733184 9485115
"""
check number_of_rows = nb_of_tickets

SELECT FILE_SOURCE, COUNT(*) AS n_rows, COUNT(DISTINCT ticket_id) AS
n_tickets,
COUNTIF(skytra_rrpk IS NOT NULL) AS n_matched,
COUNTIF(waterfall_rrpk IS NOT NULL) AS n_matched_waterfall
FROM `skytra-benchmark-rnd.matching.R5`
WHERE dt_of_issue > '1970-01-01'
GROUP BY FILE_SOURCE
ORDER BY FILE_SOURCE DESC
"""

# 8 R6
Get-Content R6.sql | bq query --destination_table matching.R6 --replace --use_legacy_sql=false --allow_large_results 
# R6 5,497,706,461		5,512,908,671


# 9.1 R7_flights
Get-Content R7_flights.sql | bq query --destination_table matching.R7_flights --replace --use_legacy_sql=false --allow_large_results 
# 9.1 R7_flights 429,531,527		670,039,199


# 9.2 R7_itineraries
Get-Content R7_itineraries.sql | bq query --destination_table matching.R7_itineraries --replace --use_legacy_sql=false --allow_large_results 
# R7_itineraries 377,463,817		378,406,911



