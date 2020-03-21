#!/bin/bash

cd /home/paul_desmond/code/index2/bq/r/sp

for file in ./*.sql; do
	cat "$(basename "$file")" | bq query --use_legacy_sql=false 
done
			
			