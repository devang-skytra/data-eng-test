

# Route Divisor Exclusions  https://skytra.atlassian.net/browse/CMP-17
# https://skytra.atlassian.net/browse/IN-1951 Blacklist routes
# deploy pullR ???


###### PERFORM SAME 30 LINES PREPARATORY PROJECT AND LOGIN STEPS FROM CMP-11


cd c:\git\index2\bq\r\sp

$qrys='index_sp.sp_process_X8'
foreach ($q in $qrys) { 
	$cmd = "Get-Content $q.sql | bq query --project_id=$prj --use_legacy_sql=false"
	$cmd | Invoke-Expression
}



CREATE OR REPLACE TABLE generic.divisor_exclusions(
divisor_type    STRING,
divisor_code    STRING,
attribute1      STRING,
attribute2      STRING,
start_date_ELT  DATE,
end_date_ELT    DATE,
date_join_type  STRING,
start_date_DOI  DATE,
end_date_DOI    DATE,
start_date_FFD  DATE,
end_date_FFD    DATE
)
as (
SELECT 'route','DEL-BNE','Delhi-Brisbane', '', DATE'1999-09-09', DATE'1999-09-09', 'first_flight_date', DATE'1999-09-09', DATE'1999-09-09', DATE'2020-12-23', DATE'2999-09-09'
UNION ALL
SELECT 'route','BNE-DEL','Brisbane-Delhi', '', DATE'1999-09-09', DATE'1999-09-09', 'first_flight_date', DATE'1999-09-09', DATE'1999-09-09', DATE'2020-12-23', DATE'2999-09-09'
)


"""
https://skytra.atlassian.net/wiki/spaces/IN/pages/383025153/Entering+Divisor+Control+Data

https://bitbucket.org/indexproduction_SK/indexproduction/branch/feature/IN-705-implement-divisors-as-part-of-the-pipeline#chg-bq/t/generic.divisor_exclusions.json

select
x8.*
from skytra-benchmark-rnd.index.X8
#LEFT
INNER JOIN generic.divisor_exclusions d
	ON
   d.divisor_type = 'route'
  AND REGEXP_CONTAINS(x8.journey_map, REPLACE(d.divisor_code, 'DEL-BNE', 'ELH-FLL'))
LIMIT 10
"""