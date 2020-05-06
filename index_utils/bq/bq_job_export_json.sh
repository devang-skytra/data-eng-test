
job=d-dat-digitalaircrafttransport:EU.bquxjob_66ea4f1_171dedd176e
out=index_airflow_params_X7
pth=~/prettyjson/

bq show --format=prettyjson -j $job > $pth$out'_jobExport.json'

# https://bqvisualiser.appspot.com/