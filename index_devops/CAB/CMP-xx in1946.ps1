
# Route Divisor Exclusions  https://skytra.atlassian.net/browse/CMP-17
# https://skytra.atlassian.net/browse/IN-1951 Blacklist routes

###### PERFORM SAME 30 LINES PREPARATORY PROJECT AND LOGIN STEPS FROM CMP-11


cd c:\git\index2\bq\r\sp


# in Dev / UAT need to do some ps replace magic first

$qrys='matching_sp.sp_process_X6','matching_sp.sp_process_X7','index_sp.sp_process_X8','index_sp.sp_process_X9'
foreach ($q in $qrys) { 
	$cmd = "Get-Content $q.sql | bq query --project_id=$prj --use_legacy_sql=false"
	$cmd | Invoke-Expression
}

"""

"""