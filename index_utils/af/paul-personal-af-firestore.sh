

#PERSONAL ACCOUNT - NB: ENABLED BETA FEATURES
#--------------------------------------

export COMPOSER_NAME="af-pypi-firestore-1cpu-1"
export COMPOSER_LOCATION="europe-west2"
export COMPOSER_ZONE="europe-west2-c"
export MACHINE_TYPE="n1-standard-1"

gcloud composer environments create ${COMPOSER_NAME} \
    --location=${COMPOSER_LOCATION} \
	--zone=${COMPOSER_ZONE} \
    --image-version=composer-1.8.3-airflow-1.10.2 \
    --disk-size=100GB \
    --python-version=3 \
    --node-count=3 \
	--machine-type ${MACHINE_TYPE}

	
gcloud composer environments update ${COMPOSER_NAME} \
    --location ${COMPOSER_LOCATION} \
    --update-pypi-packages-from-file=PyPi_req.txt
