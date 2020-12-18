
# Route Divisor Exclusions  https://skytra.atlassian.net/browse/CMP-17
# https://skytra.atlassian.net/browse/IN-1951 Blacklist routes

###### PERFORM SAME 30 LINES PREPARATORY PROJECT AND LOGIN STEPS FROM CMP-11


cd c:\git\index2\bq\r\sp

$qrys='index_sp.sp_process_X8'
foreach ($q in $qrys) { 
	$cmd = "Get-Content $q.sql | bq query --project_id=$prj --use_legacy_sql=false"
	$cmd | Invoke-Expression
}

"""
PS C:\git\index2\bq\r\sp> $qrys='index_sp.sp_process_X8'
>> foreach ($q in $qrys) {
>>     $cmd = "Get-Content $q.sql | bq query --project_id=$prj --use_legacy_sql=false"
>>     $cmd | Invoke-Expression
>> }
>>
Waiting on bqjob_r331a60c820ad68e0_00000176723ffc37_1 ... (2s) Current status: DONE
CREATE OR REPLACE PROCEDURE `index_sp.sp_process_X8`(IN from_date DATE, IN to_date DATE)
...
    ---as extra precaution exclude dates in the future
    AND first_flight_date_utc < CURRENT_DATE()
    --- on the 17th December the surveillance Review group decided to block the routes below from our index
    --- See IN-1951
    AND NOT (
      REGEXP_CONTAINS(journey_map, "BNE-DEL")
      OR REGEXP_CONTAINS(journey_map, "DEL-BNE")
      )
      ),
...
from flag_low_RSF_x7 f
left join medians
  on medians.ticket_id=f.ticket_id;

END; -- at [1:1]
Replaced skytra-benchmark-prod.index_sp.sp_process_X8
PS C:\git\index2\bq\r\sp>
"""