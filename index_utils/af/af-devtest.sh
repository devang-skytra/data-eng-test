
#latest gcc vs as at 26/3/20 is 1.10.6

export COMPOSER_NAME="benchmark-airflow"
export COMPOSER_LOCATION="europe-west2"
export COMPOSER_ZONE="europe-west2-a"
export MACHINE_TYPE="e2-standard-2"
export SA="cloud-composer@skytra-benchmark-devandtest.iam.gserviceaccount.com"

gcloud composer environments create ${COMPOSER_NAME} \
  --location=${COMPOSER_LOCATION} \
  --zone=${COMPOSER_ZONE} \
  --image-version=composer-latest-airflow-1.10 \
  --disk-size=100GB \
  --python-version=3 \
  --node-count=3 \
	--machine-type ${MACHINE_TYPE} \
  --service-account ${SA}

#	--env-variables=[TRG_FILE_PATTERN=$TRG_FILE_PATTERN,AF_CLI_ID=$AF_CLI_ID]	

	
gcloud composer environments update ${COMPOSER_NAME} \
    --location ${COMPOSER_LOCATION} \
    --update-pypi-packages-from-file=PyPi_req.txt
#google-cloud-datastore>=1.11.0
#forex-python>=1.5.0	
	
	

export bktDags="gs://-bucket/dags"

#Either programmatically determine DAGS bucket location or could manually continue from this point 
export bktDags=$(gcloud composer environments describe ${COMPOSER_NAME} --location ${COMPOSER_LOCATION} | grep 'dagGcsPrefix' | grep -Eo "\S+/")dags
echo "bktDags is ${bktDags}"

# next use gsutil to deploy content - dags, yaml and sq
cd /home/paul_desmond/code/indexproduction/af/dags
gsutil -m cp -r yaml/*.py ${bktDags}/yaml
gsutil -m cp -r sq/*.sql ${bktDags}/sq	
gsutil -m cp -r *.py ${bktDags}



