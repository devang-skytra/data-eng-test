
# Route Divisor Exclusions  https://skytra.atlassian.net/browse/CMP-23

###### PERFORM SAME 30 LINES PREPARATORY PROJECT AND LOGIN STEPS FROM CMP-11


# git checkout master / pull


# deploy DAGs and their dependencies
#--------------------------------------------------------------
cd af\dags

$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'

$qrys='sq/X12.sql'
foreach ($q in $qrys) { 
	$cmd = "gsutil -m cp -r $q $bkt_dag/$q"
	$cmd | Invoke-Expression
} 
