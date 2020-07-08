export COMPOSER_NAME="benchmark-devtest-composer-3"
export COMPOSER_LOCATION="europe-west2"
#echo "COMPOSER_NAME is ${COMPOSER_NAME}"
export bktDags="gs://europe-west2-af-test-8091433b-bucket/dags"

# beta (still?) must be used to provide --airflow-version
# machineType 
gcloud beta composer environments create ${COMPOSER_NAME} \
    --location=${COMPOSER_LOCATION} \
    --image-version=composer-1.8.2-airflow-1.10.3 \
    --disk-size=100GB \
    --python-version=3 \
    --node-count=3
	--machineType n1-standard-1
	#--airflow-configs=core-dags_are_paused_at_creation=True
	#--image-version composer-latest-airflow-x.y.z \
	
	
# NB: PyPi_req.txt packages must be complete list, not just new packages
# consistently breaks Airflow GUI with 502 server error
# https://stackoverflow.com/questions/53800011/google-cloud-composer-the-server-encountered-a-temporary-error-and-could-not-com
#https://stackoverflow.com/questions/56586015/airflow-error-while-adding-python-dependency?rq=1
# flower debugging https://groups.google.com/forum/#!topic/cloud-composer-discuss/Fg54FfXW2h8
gcloud composer environments update ${COMPOSER_NAME} \
    --location ${COMPOSER_LOCATION} \
    --update-pypi-packages-from-file=PyPi_req.txt


#Either programmatically determine DAGS bucket location or could manually continue from this point 
export bktDags=$(gcloud composer environments describe ${COMPOSER_NAME} --location ${COMPOSER_LOCATION} | grep 'dagGcsPrefix' | grep -Eo "\S+/")dags


# next use gsutil to deploy content from a dedicated bucket	
cd /home/paul_desmond/code/index/af/dags
gsutil -m cp -r * ${bktDags}

cd /home/paul_desmond/code/index_NoGit/af/dags
#gsutil -cp *.py ${bktDags}
gsutil -cp py/* ${bktDags}/py

# Further options avail in H:\git\sbe\af\composer_setup.sh eg..
# Copy environment's variables file 
# Copy environment's service account credentials from our analytics GCS bucket
# Import environment's variables file
# Set up bigquery_gdrive connection