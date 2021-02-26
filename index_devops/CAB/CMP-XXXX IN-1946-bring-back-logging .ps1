/*
create table kiwi.X5b_v5 as (select * from skytra-benchmark-rnd.kiwi.X5b_v5 where search_date < '2000-01-01' LIMIT 0)

drop table iata.R3I3;
create or replace table iata.R3I3 as (select * from `skytra-benchmark-rnd.iata.R3I3` where dt_of_issue < '2000-01-01' LIMIT 0)

select * from log.proc_load order by 2 desc


SELECT
fare_category
from iata.R3I3 where dt_of_issue < '2000-01-01'

--R3I3 schema I have is missed fare_category

matching.X7 / spX7

Inserted
row has wrong column count; Has 72, expected 70 at [skytra-benchmark-
devandtest.matching_sp.sp_process_X7:56:1]


*/







$prj='skytra-benchmark-devandtest'

gcloud config set core/project $prj

gcloud auth login paul.desmond@skytraindices.com


$inst='benchmark-prod-composer'		
$inst='benchmark-devtest-composer-3'
$dag_id='dag_zops_AnyDataset_deploy'
$day='2021_01_06'
$base_dset='iata'

#,\"create_type\":\"OR REPLACE\" does not work perhaps because of SPACE so would need better if then else
gcloud composer environments run $inst --location europe-west2 trigger_dag -- $dag_id --run_id="$dag_id $day $base_dset" --conf '{\"base_dset\":\"iata\",\"dset\":\"iata\"}'


cd c:\git\index2\bq\r\sp

$qrys='log_sp.sp_proc_load_end','matching_sp.sp_process_X6','matching_sp.sp_process_X7','index_sp.sp_process_X8','index_sp.sp_process_X9'

$qrys='matching_sp.sp_process_X7'
foreach ($q in $qrys) { 
	$cmd = "Get-Content $q.sql | bq query --project_id=$prj --use_legacy_sql=false"
	$cmd | Invoke-Expression
}


$qrys="matching_sp.sp_process_X6('file_xyz')","matching_sp.sp_process_X7('2001-01-01','2001-01-01')","index_sp.sp_process_X8('2001-01-01','2001-01-01')","index_sp.sp_process_X9('2001-01-01','2001-01-01')"

$qrys="matching_sp.sp_process_X7('2001-01-01','2001-01-01')"
foreach ($q in $qrys) { 
	bq query --project_id=$prj --use_legacy_sql=false "CALL $q ;"
}
