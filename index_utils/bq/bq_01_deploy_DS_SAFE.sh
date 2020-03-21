#!/bin/bash

cd /home/paul_desmond/code/index2/bq/ds

bq_safe_mk() {
    dataset=$1
    exists=$(bq ls --dataset | grep -w $dataset)
    if [ -n "$exists" ]; then
       echo "Not creating $dataset since it already exists"
    else
       echo "Creating $dataset"
       bq mk $dataset
    fi
}

#echo $i
array=( ds1 ds2 )
for i in "${array[@]}"; do
	bq_safe_mk $i
done
