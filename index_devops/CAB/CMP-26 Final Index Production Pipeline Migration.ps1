

# https://skytra.atlassian.net/browse/CMP-26 CMP-26 Final Index Production Pipeline Migration

$prj='skytra-benchmark-prod'

gcloud config set core/project $prj

gcloud auth login cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com

# git checkout master
# git pull


# *****  Airflow gsutil DISABLE 
# *****************************************************


# DISABLE 'dag_fxrates.py','dag_iata_daily_v5_0_1.py' on MIGRATED



# *****  Airflow gsutil DEPLOY 
# *****************************************************



# *** NB 
# on Migrated we disable dag before 6PM

# on Prod, we enable dag after 6PM because airflow always runs the prior schedule on first enablement, 
#   so it will run the 6PM schedule just missed which is what we want to correctly avoid a days gap/duplication



cd c:\git\index2\af\dags

$bkt_dag='gs://europe-west2-benchmark-prod-8d6b30f8-bucket/dags'

$files='dag_fxrates.py'
foreach ($f in $files) { 
	$cmd = "gsutil -m cp -r $f $bkt_dag/$f"
	$cmd | Invoke-Expression
} 

###### TEST PLAN
"""

airflow fxrates
=======================

Immediate
-----------------------
[SUCCESSFUL] In BQ - check generic.ext_EURUSD table immediately for success


cloud functions iata daily file api request
=======================

Immediate
-----------------------
In Airflow, confirm modf DAG
[SUCCESSFUL] - code view shows modf
[SUCCESSFUL] - graph view shows new steps (statTrigger >> dataTrigger >> gcsSensor)
[SUCCESSFUL] - compiles without error


Next Day
-----------------------
[PENDING] - confirm daily IATA pipeline runs successfully
"""