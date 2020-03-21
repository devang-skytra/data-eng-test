#!/bin/bash  

PROJECT="d-dat-digitalaircrafttransport"
parentDir="/home/paul_desmond/code/index2/"
cd $parentDir

bq_safe_dataset() {
    dataset=$1
    exists=$(bq ls --dataset | grep -w $dataset)
    if [ -n "$exists" ]; then
       echo "Not creating $dataset since it already exists"
    else
       echo "Creating $dataset"
       bq mk $dataset
    fi
}

bq_safe_table_sprints() {
    sprint=$1
    #exists=$(bq query --location=EU --use_legacy_sql=false "select distinct description from DataOps.ops_schema_history" | grep -w $sprint)
    exists=$(x | grep -w fred)
    if [ -n "$exists" ]; then
      echo "NOT running $sprint Deployment since already done"
    else
      echo "Will Deploy $sprint"
      for file in bq/$sprint/iata*.json; do
        echo "DEBUG MODE - will deploy using bq cli $file"
        #cat "$file" | bq query --use_legacy_sql=false
      done
    fi
}

# Sequence is critical
#---------------------------------------
#1 Datasets


cd /home/paul_desmond/code/index2/bq/r/sp

for file in ./*.sql; do
	cat "$(basename "$file")" | bq query --use_legacy_sql=false 
done
			
			

#for dir in t_sprint/*/; do
for dir in bq/*/; do
  bq_deploy `basename $dir`
done









