#!/bin/bash
# bash airtyx_zipping.sh
d=20200226
for i in BMO BNP Barclays CreditSuisse Deutsche Susquehanna Willem
do
   mkdir air_${i}
   gsutil cp gs://airtyx_bi_reports/${i}/* air_${i}
   zip ./${i}_${d}.zip air_${i}/*
done

gsutil cp ./*.zip gs://airtyx_bi_reports/signed

#for i in BMO BNP Barclays CreditSuisse Deutsche
#do
#   mv ${i}.zip ${i}_20200216.zip
#done

# pip3 install --user pyopenssl

f=./signedURLs_${d}.txt
for i in BMO BNP Barclays CreditSuisse Deutsche Susquehanna Willem
do
   echo ${i} >> ${f}
   gsutil signurl -d 7d ../gcp_keys/skytra-benchmark-uat-signedURL.json gs://airtyx_bi_reports/signed/${i}_${d}.zip >> ${f}
   echo -- >> ${f}
done
