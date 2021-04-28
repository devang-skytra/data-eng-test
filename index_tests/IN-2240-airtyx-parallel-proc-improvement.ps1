		
			

bq query --project_id=${prj} --location=EU --use_legacy_sql=false "create schema if not exists airline_deliverables;  create schema if not exists airline_output_files;	create schema if not exists airtyx_deliv_F;	create schema if not exists airtyx_deliv_FP;	create schema if not exists airtyx_deliv_S;	create schema if not exists airtyx_deliv_SP;	create schema if not exists product; 	create schema if not exists product_sp;	create schema if not exists product_v;"



bq cp -n -a 'skytra-benchmark-uat:generic.airline_platinum_table' generic.airline_platinum_table

# op's 99, AA, AF respectively
# SELECT * FROM `skytra-benchmark-uat.generic.airline_platinum_table`t where t.flight_op_carrier in('99','AA','AF')
bq cp -n -a 'skytra-benchmark-uat:product.TT_master_table$1109' product.TT_master_table
bq cp -n -a 'skytra-benchmark-uat:product.TT_master_table$565'  product.TT_master_table
bq cp -n -a 'skytra-benchmark-uat:product.TT_master_table$597'  product.TT_master_table






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
			
			
