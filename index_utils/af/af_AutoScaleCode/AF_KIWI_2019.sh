
export COMPOSER_NAME="af-kiwi-2019"
export COMPOSER_LOCATION="europe-west2"
export COMPOSER_ZONE="europe-west2-c"
export MACHINE_TYPE="n1-standard-8"

gcloud composer environments create ${COMPOSER_NAME} \
    --location=${COMPOSER_LOCATION} \
	--zone=${COMPOSER_ZONE} \
    --image-version=composer-latest-airflow-1.10 \
    --disk-size=500GB \
    --python-version=3 \
    --node-count=3 \
	--machine-type ${MACHINE_TYPE} \
	--labels=[subproject="2019-index"]
#	--env-variables=[TRG_FILE_PATTERN=$TRG_FILE_PATTERN,AF_CLI_ID=$AF_CLI_ID]	

# THIS TIME WILL BE DONE AS PART OF AutoScale script	
#gcloud composer environments update ${COMPOSER_NAME} \
#    --location ${COMPOSER_LOCATION} \
#    --update-pypi-packages-from-file=PyPi_req_AF_KIWI_2019.txt
	
	
	
	
#export bktDags="gs://europe-west2-af-test-8091433b-bucket/dags"

#Either programmatically determine DAGS bucket location or could manually continue from this point 
#export bktDags=$(gcloud composer environments describe ${COMPOSER_NAME} --location ${COMPOSER_LOCATION} | grep #'dagGcsPrefix' | grep -Eo "\S+/")dags
#echo "bktDags is ${bktDags}"

# next use gsutil to deploy content
#cd /home/paul_desmond/code/index2/af/dags
#gsutil -m cp -r *.py ${bktDags}

#cd /home/paul_desmond/code/index_NoGit/af/dags
#gsutil -cp *.py ${bktDags}
#gsutil -cp py/* ${bktDags}/py	