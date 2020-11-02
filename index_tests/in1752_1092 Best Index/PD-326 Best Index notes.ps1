
# Best Index 

gcloud config get-value core/project

# 2020 10 28
# ****************************************************************************************
# ****************************************************************************************


# *****  DONE  External Table Deploy
# *****************************************************
	cd c:\git\index2\bq\t

	bq mk --project_id=$prj --external_table_definition=./generic.ext_EURUSD_defn.json --schema ./generic.ext_EURUSD_schema.json generic.ext_EURUSD
	bq mk --project_id=$prj --external_table_definition=./iata.ext_data_gz_defn.json --schema ./iata.X1.json iata.ext_data_gz
	bq mk --project_id=$prj --external_table_definition=./iata.ext_data_defn.json --schema ./iata.X1.json iata.ext_data
	bq mk --project_id=$prj --external_table_definition=./stat.iata_stats_defn.json stat.iata_stats
	bq mk --project_id=$prj --external_table_definition=./stat.kiwi_stats_defn.json --schema ./stat.kiwi_stats_schema.json stat.kiwi_stats


# *****  DONE  Generic Table Copy
# *****************************************************
	$prj='skytra-benchmark-uat'
	gcloud config set core/project $prj


	#  CONFIRMED  'iata.X1_Pre_Daily_Merged_v2' prepared in UAT and unchanged in RnD ??

	$tbls='generic.golden_table_airports','generic.golden_table_operating_carriers','generic.golden_ticketing_carriers','generic.index_rrpk_model_params_201811_201911','generic.spot_window_regions_ext','generic.skytra_index_regions','generic.Ticketing_to_Operating_Carrier'
	foreach ($t in $tbls) { 
		$cmd = "bq cp -f skytra-benchmark-rnd:$t $t"
		#echo $cmd
		$cmd | Invoke-Expression
	} 


# ***** Fact Table Copy
# *****************************************************

# 1 [scratch_SaN.X5b$__PARTITIONS_SUMMARY__] 2018 274 from 20180401
# 2 [kiwi.X5b$__PARTITIONS_SUMMARY__]                      20190101 to 20201027 +active
# 3 [kiwi.X5b_v5$__PARTITIONS_SUMMARY__]     combo of above

bq cp -f skytra-benchmark-rnd:kiwi.X5b_v5 skytra-benchmark-uat:kiwi.X5b


$tbls ='iata.X3','iata.R1','iata.R2','iata.R3I3','matching.X6','matching.X7','index.X8','index.X9','index.X11','index.X12'
foreach ($t in $tbls) { 
	$cmd = "bq cp -f skytra-benchmark-rnd:$t $t"
	#echo $cmd
	$cmd | Invoke-Expression
} 

"""
Waiting on bqjob_r5bf34288d0967c93_0000017589f2eb56_1 ... (135s) Current status: DONE
Table 'skytra-benchmark-rnd:iata.X3' successfully copied to 'skytra-benchmark-uat:iata.X3'
Waiting on bqjob_r487b758cd5e1e63e_0000017589f5086a_1 ... (164s) Current status: DONE
Table 'skytra-benchmark-rnd:iata.R1' successfully copied to 'skytra-benchmark-uat:iata.R1'
Waiting on bqjob_r675eeb0e7c30c56c_0000017589f79657_1 ... (164s) Current status: DONE
Table 'skytra-benchmark-rnd:iata.R2' successfully copied to 'skytra-benchmark-uat:iata.R2'
Waiting on bqjob_r38b38c94ec9d5cba_0000017589fa27ea_1 ... (135s) Current status: DONE
Table 'skytra-benchmark-rnd:iata.R3I3' successfully copied to 'skytra-benchmark-uat:iata.R3I3'
Waiting on bqjob_r9dee856f58fdde5_0000017589fc4600_1 ... (14s) Current status: DONE
Table 'skytra-benchmark-rnd:matching.X6' successfully copied to 'skytra-benchmark-uat:matching.X6'
Waiting on bqjob_r77d5915963493c9e_0000017589fc8d1c_1 ... (6s) Current status: DONE
Table 'skytra-benchmark-rnd:matching.X7' successfully copied to 'skytra-benchmark-uat:matching.X7'
Waiting on bqjob_rfc1af3fa0295da2_0000017589fcb4b2_1 ... (4s) Current status: DONE
Table 'skytra-benchmark-rnd:index.X8' successfully copied to 'skytra-benchmark-uat:index.X8'
Waiting on bqjob_r562dc31479886336_0000017589fcd1ff_1 ... (3s) Current status: DONE
Table 'skytra-benchmark-rnd:index.X9' successfully copied to 'skytra-benchmark-uat:index.X9'
Waiting on bqjob_r6185ccd82a5c9dd_0000017589fcebbe_1 ... (135s) Current status: DONE
Table 'skytra-benchmark-rnd:index.X11' successfully copied to 'skytra-benchmark-uat:index.X11'
Waiting on bqjob_r5855dbbb6ddcaa80_0000017589ff088b_1 ... (0s) Current status: DONE
"""


# *****  DONE  CLEAR LOG TABLES EXCEPT FOR KIWI V5 BUILD  
#C:\Users\PaulDesmond\OneDrive - SKYTRA LIMITED\Shared\pd_IdxTeamShare\pd_DataTeamShare\v5\log cleanout.sql
# *****************************************************



# *****  DONE  Airflow gsutil deploy
# *****************************************************

	git checkout feature/IN-1092-create-a-waterfall-pricing-mecha
	git pull

	cd c:\git\index2\af\dags

	#DevTest
	#$inst='benchmark-devtest-composer-3'	
	#$bkt_dag='gs://europe-west2-benchmark-devt-6ca0db0f-bucket/dags'

	#UAT
	$inst='benchmark-uat-composer2'		
	$bkt_dag='gs://europe-west2-benchmark-uat--2bf16b72-bucket/dags'

	#PROD	
	# SET bkt_dag=gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags
	# gsutil -m cp -r py %bkt_dag%/py


	gsutil -m cp -r *v5_0_0.py $bkt_dag

	$qrys='sq/X5a.sql','sq/X5b.sql','sq/X12.sql','py/op_gen.py'
	$qrys='py/op_gen.py'
	foreach ($q in $qrys) { 
		$cmd = "gsutil -m cp -r $q $bkt_dag/$q"
		#echo $cmd
		$cmd | Invoke-Expression
	} 

 
# *****  DONE  PROCs deploy
# *****************************************************


	cd c:\git\index2\bq\r\sp

	$qrys='iata_sp.sp_process_R1','iata_sp.sp_process_R2','iata_sp.sp_process_R3I3','iata_sp.sp_process_X3', 'index_sp.sp_process_X8','index_sp.sp_process_X9','index_sp.sp_process_X11','log_sp.sp_proc_load_start','matching_sp.sp_process_X6','matching_sp.sp_process_X7'
	foreach ($q in $qrys) { 
		#Get-Content $q | bq query --project_id=$prj --use_legacy_sql=false 
		$cmd = "Get-Content $q.sql | bq query --project_id=$prj --use_legacy_sql=false"
		#echo $cmd
		$cmd | Invoke-Expression
	} #Write-Output





# ***** JSON Diff

cd c:\git\index2\bq
mkdir t_temp
cd t_temp

$prj='skytra-benchmark-rnd'
gcloud config set core/project $prj


$tbls ='iata.X3','iata.R1','iata.R2','iata.R3I3','matching.X6','matching.X7','index.X8','index.X9','index.X11','index.X12'
foreach ($t in $tbls) { 
	$cmd = "bq show --schema --format=prettyjson $t > $t.json"
	echo $cmd
	$cmd | Invoke-Expression
} 


# Screenshot results to "C:\Users\PaulDesmond\OneDrive - SKYTRA LIMITED\Shared\pd_IdxTeamShare\pd_DataTeamShare\v5"


# ****************************************************************************************
# ****************************************************************************************




# 2020 10 22
# ****************************************************************************************
$prj='skytra-benchmark-rnd'
gcloud config set core/project $prj

cd c:\git\index2\bq\t\

$tbls='matching_models_test_SANS_OD.X11','matching_models_test.X11'
foreach ($t in $tbls) { 
	"bq rm --project_id=$prj -t -f $t" | Invoke-Expression
	"bq mk --project_id=$prj --table --time_partitioning_field first_flight_date_utc --require_partition_filter --clustering_fields=region_pair,ticket_id --schema .`\matching.X11.json $t" | Invoke-Expression
} 

bq query --project_id=$prj --append_table --use_legacy_sql=false --allow_large_results "CALL index_sp.sp_process_X11_SANS_OD( ['2018-11-01'], ['ASAS'], 'matching_models_test_SANS_OD', 'matching', 'matching_models_test_SANS_OD', 'matching', FALSE );" 

bq query --project_id=$prj --append_table --use_legacy_sql=false --allow_large_results "CALL index_sp.sp_process_X11( ['2018-11-01'], ['ASAS'], 'matching_models_test', 'matching', 'matching_models_test', 'matching', FALSE );" 


SELECT 'matching_models_test_SANS_OD' as mdl, * FROM ML.WEIGHTS(MODEL `matching_models_test_SANS_OD.kiwi_price_lin_reg_model_ASAS_20181101`) 
UNION ALL
SELECT 'matching_models_test' as mdl, * FROM ML.WEIGHTS(MODEL `matching_models_test.kiwi_price_lin_reg_model_ASAS_20181101`) 

# ****************************************************************************************



#$prj='skytra-benchmark-devandtest'
$prj='skytra-benchmark-uat'
#$prj='skytra-benchmark-prod'

gcloud config set core/project $prj


gcloud auth login paul.desmond@skytraindices.com
cd c:\git\index2
git checkout feature/IN-1092-create-a-waterfall-pricing-mecha
git pull

# Write-Output  		Invoke-Expression
# | Write-Output		| bq query  --project_id=$dst_prj --use_legacy_sql=false 


# SCHEMA SETUP
# ****************************************************************************************
# BECAUSE BACKFILL, NO --time_partitioning_EXPIRATION !!!!!!!!!!!!!

cd c:\git\index2\bq\t\

#foreach ($t in $tbls) { (Get-Content $t) -replace '--time_partitioning_expiration 950400 ','' | Invoke-Expression } 
$tbls='kiwi.X5a'
foreach ($t in $tbls) { 
	"bq rm --project_id=$prj -t -f $t" | Invoke-Expression
	"bq mk --project_id=$prj --table --time_partitioning_field search_date --require_partition_filter --schema .`\$t.json $t" | Invoke-Expression
} 



bq rm -t -f kiwi.X5b_SIDs
$t=@'
CREATE OR REPLACE TABLE kiwi.X5b_SIDs (
ExecDate_INT    INT64, 
sid_key         INT64, 
sid             STRING,  
ind_sid         INT64 
)
PARTITION BY RANGE_BUCKET(ExecDate_INT, generate_array( 20200101, 20240101, 10 ) )
'@
# bq query --use_legacy_sql=false $t



# TABLE/PARTITION COPIES
# ****************************************************************************************

# take X2 FROM ANOTHER PRJ AND USE NEW parallel-run-comp naming
$src_prj='skytra-benchmark-rnd'
$dst_prj='skytra-benchmark-devandtest'
$ds='kiwi'
$tb='X2'
$ptns=20200202,20200826 # Paulo's choice for X2 in RnD, 20200711 my choice because ?
foreach ($p in $ptns) { "bq cp -a -n $src_prj`:$ds.$tb`$$p $dst_prj`:$ds.$tb`_$p" | Invoke-Expression }


# GCS version
# **************************************************

$ds='kiwi'
$tb='X2'

$startDate=[datetime]::parseexact('20200501', 'yyyyMMdd', $null)
$endDate=[datetime]::parseexact('20200601', 'yyyyMMdd', $null)
for($i = $startDate; $i -lt $endDate; $i = $i.AddDays(1))
{
	$d=$i.ToString("yyyyMMdd")
	$y=$d.Substring(0,4)
	$m=$d.Substring(4,2)
	$d=$d.Substring(6,2)
	"bq load --project_id=$prj --location=EU --replace --source_format=PARQUET $ds.$tb`_$m$d `"gs://ext-kiwi-excl-data/data/y=$y/m=$m/d=$d/*.gz.parquet`"" | Write-Output
}

@'
bq load --project_id=skytra-benchmark-uat --location=EU --replace --source_format=PARQUET kiwi.X2_0420 "gs://ext-kiwi-excl-data/data/y=2020/m=04/d=20/*.gz.parquet"
bq load --project_id=skytra-benchmark-uat --location=EU --replace --source_format=PARQUET kiwi.X2_0421 "gs://ext-kiwi-excl-data/data/y=2020/m=04/d=21/*.gz.parquet"

bq load --project_id=skytra-benchmark-uat --location=EU --replace --source_format=PARQUET kiwi.X2_0422 "gs://ext-kiwi-excl-data/data/y=2020/m=04/d=22/*.gz.parquet"
bq load --project_id=skytra-benchmark-uat --location=EU --replace --source_format=PARQUET kiwi.X2_0423 "gs://ext-kiwi-excl-data/data/y=2020/m=04/d=23/*.gz.parquet"
bq load --project_id=skytra-benchmark-uat --location=EU --replace --source_format=PARQUET kiwi.X2_0424 "gs://ext-kiwi-excl-data/data/y=2020/m=04/d=24/*.gz.parquet"
bq load --project_id=skytra-benchmark-uat --location=EU --replace --source_format=PARQUET kiwi.X2_0425 "gs://ext-kiwi-excl-data/data/y=2020/m=04/d=25/*.gz.parquet"
bq load --project_id=skytra-benchmark-uat --location=EU --replace --source_format=PARQUET kiwi.X2_0426 "gs://ext-kiwi-excl-data/data/y=2020/m=04/d=26/*.gz.parquet"
bq load --project_id=skytra-benchmark-uat --location=EU --replace --source_format=PARQUET kiwi.X2_0427 "gs://ext-kiwi-excl-data/data/y=2020/m=04/d=27/*.gz.parquet"
bq load --project_id=skytra-benchmark-uat --location=EU --replace --source_format=PARQUET kiwi.X2_0428 "gs://ext-kiwi-excl-data/data/y=2020/m=04/d=28/*.gz.parquet"
bq load --project_id=skytra-benchmark-uat --location=EU --replace --source_format=PARQUET kiwi.X2_0429 "gs://ext-kiwi-excl-data/data/y=2020/m=04/d=29/*.gz.parquet"

bq load --project_id=skytra-benchmark-uat --location=EU --replace --source_format=PARQUET kiwi.X2_0430 "gs://ext-kiwi-excl-data/data/y=2020/m=04/d=30/*.gz.parquet"


could you please create new x5b for 10th and 11th Sept? 

bq load --project_id=skytra-benchmark-uat --location=EU --replace --source_format=PARQUET kiwi.X2_0910 "gs://ext-kiwi-excl-data/data/y=2020/m=09/d=10/*.gz.parquet"
bq load --project_id=skytra-benchmark-uat --location=EU --replace --source_format=PARQUET kiwi.X2_0911 "gs://ext-kiwi-excl-data/data/y=2020/m=09/d=11/*.gz.parquet"


check 2019 parquet becomes schema changed neatly on 20200101 from memory
https://bitbucket.org/indexproduction_SK/indexproduction/diff/bq/t/kiwi.X2.json?diff1=b318e805b2d0736f64abd308797ef87f650283ac&diff2=651ee90ee583515841d5e9262600139d2e0b59d7


bq load --project_id=skytra-benchmark-uat --location=EU --replace --source_format=PARQUET kiwi.X2_190101 "gs://ext-kiwi-excl-data/data/2019/01/01/*.gz.parquet"

bq load --project_id=skytra-benchmark-uat --location=EU --replace --source_format=PARQUET kiwi.X2_191231 "gs://ext-kiwi-excl-data/data/2019/12/31/*.gz.parquet"


'@



# PIPELINE QUERIES - FAILED TO GET WORKING SO GO STRAIGHT TO AIRFLOW (or try .sh DevOps method, copy file, modf file, )
# ****************************************************************************************

cd c:\git\index2\af\dags\sq

$ds='kiwi'
$sqls='X5a.sql','X5b_SIDs.sql','X5b.sql'
$ptns=20200826
@'
foreach ($s in $sqls) { 
	foreach ($p in $ptns) {
		$pdash=[datetime]::parseexact($p, 'yyyyMMdd', $null).ToString('yyyy-MM-dd')
		$sql=(Get-Content $s  -Raw) -replace '{{ ds_nodash }}',$p -replace '{{ ds }}',$pdash
		$tb=$s -replace '.sql',''
		$dstb="$ds.$tb"
		#bq query --destination_table $dstb --append_table --use_legacy_sql=false --allow_large_results "`"$sql`"" 
		#Add-Content -Path .\$ds`_$p.sql "insert into $dstb $sql ;"
		#| Invoke-Expression
		Write-Output "`"$sql`""
	} 
}
'@


# bq rm -t -f generic.ext_EURUSD
bq mk --external_table_definition=./generic.ext_EURUSD_defn.json --schema ./ext_EURUSD_schema.json generic.ext_EURUSD
bq mk --external_table_definition=./generic.ext_file_source_log_defn.json generic.ext_file_source_log


bq cp skytra-benchmark-rnd:generic.Ticketing_to_Operating_Carrier skytra-benchmark-devandtest:generic.Ticketing_to_Operating_Carrier

#fxrates
$bkt_src='gs://fxrates/to/*'
#$bkt_dst='gs://fxrates-rnd/to/'
$bkt_dst='gs://fxrates-uat/to/'
gsutil -m cp -r $bkt_src $bkt_dst


# ****************************************************************************************




# DAGS
# ****************************************************************************************

	
cd c:\git\index2
git checkout feature/IN-1092-create-a-waterfall-pricing-mecha
git pull
cd af\dags


#DevTest
#$inst='benchmark-devtest-composer-3'	
#$bkt_dag='gs://europe-west2-benchmark-devt-6ca0db0f-bucket/dags'

#UAT
$inst='benchmark-uat-composer2'		
$bkt_dag='gs://europe-west2-benchmark-uat--2bf16b72-bucket/dags'

#PROD	
# SET bkt_dag=gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags
# gsutil -m cp -r py %bkt_dag%/py

$sq='sq/X5b.*'
gsutil -m cp -r $sq $bkt_dag/sq



git checkout IN-1754-v5-backfill-x2-parallel-run-comp
git pull
$sq='sq/X5a.*'
gsutil -m cp -r $sq $bkt_dag/sq
$dag='dag_kiwi_daily_parallel.py'
gsutil cp $dag $bkt_dag


# https://airflow.apache.org/docs/stable/cli-ref#backfill
$dag_id='dag_kiwi_daily_parallel'
$bf_start='2020-09-10'
$bf_end='2020-09-12'
gcloud composer environments run $inst --location europe-west2 backfill -- $dag_id --start_date $bf_start --end_date $bf_end --reset_dagruns

# --rerun_failed_tasks

@'
SELECT search_date, count(*) FROM `skytra-benchmark-uat.kiwi.X5b` WHERE search_date >= "2020-01-01" group by 1 order by 1
X5a							X5b
2020-04-20 5,109,499,406	132,861,665
2020-04-21 4,827,917,543	121,468,717
2020-04-22 4,654,348,666	116,670,339
'@

bq cp -n -a 'skytra-benchmark-uat:kiwi.X5a$20200910' skytra-benchmark-rnd:kiwi.X5a_202009_10_to_11_B
bq cp -n -a 'skytra-benchmark-uat:kiwi.X5a$20200911' skytra-benchmark-rnd:kiwi.X5a_202009_10_to_11_B

bq cp -n -a 'skytra-benchmark-uat:kiwi.X5b$20200910' skytra-benchmark-rnd:kiwi.X5b_202009_10_to_11_B
bq cp -n -a 'skytra-benchmark-uat:kiwi.X5b$20200911' skytra-benchmark-rnd:kiwi.X5b_202009_10_to_11_B


bq cp -f d-dat-digitalaircrafttransport:iata.X1 skytra-benchmark-rnd:iata.X1

# ****************************************************************************************



# archive
# ****************************************************************************************



#  GCS sample data move/load
# **************************************************

#DevTest
#gsutil -m cp -r gs://ext-kiwi-excl-stat/stats/y=2020/m=04 gs://ext-kiwi-excl-dev-stat/stats/y=2020/m=04

#gsutil -m cp -r gs://ext-kiwi-excl-data/data/y=2020/m=04/d=20 gs://ext-kiwi-excl-dev-data/data/y=2020/m=04/d=20


#UAT
gsutil -m cp -r gs://ext-kiwi-excl-stat/stats/y=2020/m=04 gs://ext-kiwi-excl-uat-stat/stats/y=2020/m=04
gsutil -m cp -r gs://ext-kiwi-excl-stat/stats/y=2020/m=05 gs://ext-kiwi-excl-uat-stat/stats/y=2020/m=05

gsutil -m cp -r gs://ext-kiwi-excl-stat/stats/y=2020/m=09 gs://ext-kiwi-excl-uat-stat/stats/y=2020/m=09


#PROD	



gsutil -m cp -r gs://ext-kiwi-excl-stat/stats/y=2020/m=04 gs://ext-kiwi-excl-uat-stat/stats/y=2020/m=04
gsutil -m cp -r gs://ext-kiwi-excl-stat/stats/y=2020/m=05 gs://ext-kiwi-excl-uat-stat/stats/y=2020/m=05

gsutil -m cp -r gs://ext-kiwi-excl-data/data/y=2020/m=04/d=20 gs://ext-kiwi-excl-dev-data/data/y=2020/m=04/d=20


gsutil -m cp -r gs://ext-kiwi-excl-stat/stats/y=2020/m=08 gs://ext-kiwi-excl-dev-stat/stats/y=2020/m=08
# gsutil -m rm gs://ext-kiwi-excl-dev-data/data/y=2020/m=08/**
gsutil -m cp -r gs://ext-kiwi-excl-data/data/y=2020/m=08/d=27 gs://ext-kiwi-excl-dev-data/data/y=2020/m=08/d=27




bq load --project_id=skytra-benchmark-rnd --location=EU --replace --source_format=PARQUET kiwi.X2_20200826 "gs://ext-kiwi-excl-data/data/y=2020/m=02/d=02/*.gz.parquet,gs://ext-kiwi-excl-data/data/y=2020/m=08/d=26/*.gz.parquet"





UAT

gs://ext-kiwi-excl-uat-data/data/y=2020/m=03/d=23/hr=21/part-00000-e1a29e0a-b4b4-4d76-9260-ba56427489fb-c000.gz.parquet
gs://ext-kiwi-excl-uat-data/data/y=2020/m=07/d=01/hr=00/part-00000-aa73f8d7-e62d-4165-9f7f-7f10a98f5d0d-c000.gz.parquet



#  X2 partitioning idea - dropped for kiwi.X2_{{ ds_nodash[4:] }} approach
# *************************************************
simply add search_date to X2.json and use X2.sh to create

then
	INSERT INTO .X2
	SELECT 
	EXTRACT(date FROM TIMESTAMP_SECONDS(timestamp)) AS search_date,
	* EXCEPT(m,d,hr)
	FROM kiwi.ext_data 
	WHERE 
	_FILE_NAME like '%data/y=2020/m=03/d=23/hr=21/part-00000-e1a29e0a-b4b4-4d76-9260-ba56427489fb-c000.gz.parquet'
	OR
	hr = '21'
	
key ***
	can we get kiwi.ext_data working in Migrated (ISSUE)
	
cd C:\git\index2\bq\t\
bq mk --project_id=d-dat-digitalaircrafttransport --external_table_definition=./kiwi.ext_data_defn.json kiwi.ext_data_UAT

