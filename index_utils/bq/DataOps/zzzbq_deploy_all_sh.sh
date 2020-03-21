#!/bin/bash

cd /home/paul_desmond/code/index2/bq/r/sp
#for file in `ls -v | grep 'iata.*.sh'`; do cat "$file"; done;
#for file in `ls -v | grep '.sh'`; do bash "$file"; done;

#cd ../m
for file in `ls -v | grep '.sql'`; do cat "$file" | bq query --use_legacy_sql=false; done;
			