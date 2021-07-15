		
# related doco
# C:\Users\PaulDesmond\OneDrive - SKYTRA LIMITED\Shared\pd_IdxTeamShare\pd_DataTeamShare\v6 deployment plan.sh
# C:\git\DataEng\index_devops\CAB\CMP-xx__V6_UAT_ACTIVE.ps1
# C:\git\DataEng\index_devops\CAB\CMP-xx__V6.ps1
# C:\git\DataEng\index_tests\IN-2240-airtyx-parallel-proc-improvement.ps1

		
bq query --project_id=${prj} --location=EU --use_legacy_sql=false "create schema if not exists airline_deliverables;  create schema if not exists airline_output_files;	create schema if not exists airtyx_deliv_F;	create schema if not exists airtyx_deliv_FP;	create schema if not exists airtyx_deliv_S;	create schema if not exists airtyx_deliv_SP;	create schema if not exists product; 	create schema if not exists product_sp;	create schema if not exists product_v;"



bq cp -n -a 'skytra-benchmark-uat:generic.airline_platinum_table' generic.airline_platinum_table

# op's 99, AA, AF respectively
# SELECT * FROM `skytra-benchmark-uat.generic.airline_platinum_table`t where t.flight_op_carrier in('99','AA','AF')
bq rm product.TT_master_table
bq cp -n -a 'skytra-benchmark-uat:product.TT_master_table$1109' product.TT_master_table
bq cp -n -a 'skytra-benchmark-uat:product.TT_master_table$565'  product.TT_master_table
bq cp -n -a 'skytra-benchmark-uat:product.TT_master_table$597'  product.TT_master_table



#  Query error: Function not found: product.fx_normalize_col_name at [skt-wsprod-pauldesmond-ec7c.product_sp.sp_pivot:1:107


$prj='paul-d-test-proj'

# ***********

cd C:\git\index2\bq\r\fx

$procPfx='fx_'
$dset='airline_output_files'

# ***********

$procPfx='fx_'
$dset='product_sp'

# ***********

cd C:\git\index2\bq\r\sp

$procPfx='sp_process_airtyx_'
$dset='product_sp'

# ***********

$procPfx='sp_piv'
$dset='product_sp'

# ***********

$regx="${dset}.${procPfx}"

Get-ChildItem | Where-Object { $_.Name -match ${regx} } | 
Foreach-Object {
	$cmd = "Get-Content $_ | bq query --project_id=${prj} --location=EU --use_legacy_sql=false"
	$cmd | Invoke-Expression
	echo $_.Name
}  | Out-File -append -FilePath c:\git\logs\${dset}.txt

bq query --project_id=${prj} --location=EU --use_legacy_sql=false "select specific_name, last_altered from ${dset}.INFORMATION_SCHEMA.ROUTINES r order by 2 desc"
			
			
#FP Quarter regression test

SELECT
'pd' as prj,
count(*) as c,
count(distinct dt_of_issue) cd_doi,
min(dt_of_issue) min_doi,
max(dt_of_issue) max_doi,
sum( cast(A99NANAALLQ029GREB as NUMERIC  )) as c1_sum
FROM `skt-wsprod-pauldesmond-ec7c.airtyx_deliv_FP.deliv_FP_99_2020_Q_NANA`

union all 

SELECT
'uat' as prj,
count(*) as c,
count(distinct dt_of_issue) cd_doi,
min(dt_of_issue) min_doi,
max(dt_of_issue) max_doi,
sum( cast(A99NANAALLQ029GREB as NUMERIC  )) as c1_sum
FROM `skytra-benchmark-uat.airtyx_deliv_FP.deliv_FP_99_2020_Q_NANA`


#FP ALLD regression test

SELECT
'pd' as prj,
count(*) as c,
count(distinct dt_of_issue) cd_doi,
min(dt_of_issue) min_doi,
max(dt_of_issue) max_doi,
sum( cast(A99NANAWEKALLDGREB as NUMERIC  )) as c1_sum
FROM `skt-wsprod-pauldesmond-ec7c.airtyx_deliv_FP.deliv_FP_99_A_NANA`

union all 

SELECT
'uat' as prj,
count(*) as c,
count(distinct dt_of_issue) cd_doi,
min(dt_of_issue) min_doi,
max(dt_of_issue) max_doi,
sum( cast(A99NANAWEKALLDGREB as NUMERIC  )) as c1_sum
FROM `skytra-benchmark-uat.airtyx_deliv_FP.deliv_FP_99_A_NANA`


