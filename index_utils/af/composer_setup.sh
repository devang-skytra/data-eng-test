#!/usr/bin/env bash

#============================================================================================
#============================================================================================

day=20210418


#pshell
#===============================
gcloud auth login paul.desmond@skytraindices.com
gcloud config set core/project paul-d-test-proj
$CONFIG_LOCATION='gs://aaa-resource-config'
gsutil cp C:\git\index2\af\config\requirements.txt  "${CONFIG_LOCATION}/af/config/"

#bash
#===============================
day=20210418
COMPOSER_NAME=af-${day}
CONFIG_LOCATION=gs://aaa-resource-config/af/config/
COMPOSER_INSTANCE_DATA_FOLDER/home/airflow/gcs/data
COMPOSER_LOCATION=europe-west2
ENV_VARIABLES_JSON_NAME=af_variables_paul-d.json

ENV_VARIABLES_JSON_GCS_LOCATION="${CONFIG_LOCATION}${ENV_VARIABLES_JSON_NAME}"

gcloud composer environments create ${COMPOSER_NAME} \
    --location=${COMPOSER_LOCATION} \
    --airflow-configs=core-dags_are_paused_at_creation=True,core-default_timezone=Europe/London \
    --image-version=composer-1.15.0-airflow-1.10.10 \
    --disk-size=20GB \
    --python-version=3 \
    --node-count=3

#===============================
#entire section problematic
COMPOSER_GCS_BUCKET_DATA_FOLDER=$(gcloud composer environments describe ${COMPOSER_NAME} --location ${COMPOSER_LOCATION} | grep 'dagGcsPrefix' | grep -Eo "\S+/")data

# COMPOSER_GCS_BUCKET_DATA_FOLDER=gs://europe-west2-af-20210318-e3fcb001-bucket/dags/data

gsutil cp ${ENV_VARIABLES_JSON_GCS_LOCATION} ${COMPOSER_GCS_BUCKET_DATA_FOLDER}/
	
# Import environment's variables file
gcloud composer environments run ${COMPOSER_NAME} \
	--location ${COMPOSER_LOCATION} variables -- -i ${COMPOSER_GCS_BUCKET_DATA_FOLDER}/${ENV_VARIABLES_JSON_NAME}

# ERROR error Missing variables file so do manually  C:\git\DataEng\index_utils\af\composer_setup.sh


# Install PyPi packages from file IF NECESSARY

gcloud composer environments update ${COMPOSER_NAME} \
    --location ${COMPOSER_LOCATION} \
    --update-pypi-packages-from-file=${CONFIG_LOCATION}requirements.txt

# ERROR error byte vs string error


#end section
#===============================


#pshell
#===============================


$COMPOSER_GCS_BUCKET_DAGS_FOLDER="gs://europe-west2-af-20210418-7268483a-bucket/dags"

#gsutil cp C:\git\index2\af\dags\py\op* $COMPOSER_GCS_BUCKET_DAGS_FOLDER/py/
#gsutil cp C:\git\index2\af\dags\py\sl* $COMPOSER_GCS_BUCKET_DAGS_FOLDER/py/
#gsutil cp C:\git\index2\af\dags\sq\* $COMPOSER_GCS_BUCKET_DAGS_FOLDER/sq/

OR

gsutil cp C:\git\index2\af\dags\py\* $COMPOSER_GCS_BUCKET_DAGS_FOLDER/py/
gsutil cp C:\git\index2\af\dags\sq\* $COMPOSER_GCS_BUCKET_DAGS_FOLDER/sq/
gsutil cp C:\git\index2\af\dags\yaml\clients*.yml $COMPOSER_GCS_BUCKET_DAGS_FOLDER/yaml/
gsutil cp C:\git\index2\af\dags\yaml\reports*.yml $COMPOSER_GCS_BUCKET_DAGS_FOLDER/yaml/
gsutil cp C:\git\index2\af\dags\yaml\CT*.yml $COMPOSER_GCS_BUCKET_DAGS_FOLDER/yaml/
gsutil cp C:\git\index2\af\dags\Airtyx_v6\* $COMPOSER_GCS_BUCKET_DAGS_FOLDER/
gsutil cp C:\git\index2\af\dags\dag_Airtyx_BQ* $COMPOSER_GCS_BUCKET_DAGS_FOLDER/
#gsutil cp C:\git\index2\af\dags\dag_Airtyx_Export_Parent_v0_0_3.py $COMPOSER_GCS_BUCKET_DAGS_FOLDER/
#gsutil cp C:\git\index2\af\dags\dag_Airtyx_Export_v0_0_4.py $COMPOSER_GCS_BUCKET_DAGS_FOLDER/


$nowtime=get-date
Get-Item "C:\git\index2\af\dags\*.*" | Foreach {
	$lastupdatetime=$_.LastWriteTime
	if (($nowtime - $lastupdatetime).totalhours -le 1)
	{
	Write-Host "gsutil cp"$_.Fullname $COMPOSER_GCS_BUCKET_DAGS_FOLDER/
	}
}


gsutil cp C:\git\index2\af\dags\dag_Airtyx*.* gs://europe-west2-af-20210318-e3fcb001-bucket/dags/

#============================================================================================
COMPOSER_NAME = "airflow-test"
GCS_LOCATION = "gs://analytics/credentials/"
COMPOSER_INSTANCE_DATA_FOLDER = "/home/airflow/gcs/data"
COMPOSER_LOCATION = "europe-west1"
ENV_VARIABLES_JSON_NAME = "airflow_env_variables_test.json"
CREDENTIALS_JSON_NAME = "service-account.json"

ENV_VARIABLES_JSON_GCS_LOCATION = GCS_LOCATION${ENV_VARIABLES_JSON_NAME}
CREDENTIALS_JSON_LOCATION = GCS_LOCATION${CREDENTIALS_JSON_NAME}



# beta must be used to provide --airflow-version
gcloud composer environments create ${COMPOSER_NAME} \
    --location=${COMPOSER_LOCATION} \
    --airflow-configs=core-dags_are_paused_at_creation=True \
    --image-version=composer-1.5.0-airflow-1.10.1 \
    --disk-size=20GB \
    --python-version=2 \
    --node-count=3 \
    --labels env=${ENVIRONMENT}

COMPOSER_GCS_BUCKET_DATA_FOLDER=$(gcloud composer environments describe ${COMPOSER_NAME} --location ${COMPOSER_LOCATION} | grep 'dagGcsPrefix' | grep -Eo "\S+/")data

echo "Data folder is ${COMPOSER_GCS_BUCKET_DATA_FOLDER}"

# Copy environment's variables file and service account credentials from our analytics GCS bucket
gsutil cp ${ENV_VARIABLES_JSON_GCS_LOCATION} ${COMPOSER_GCS_BUCKET_DATA_FOLDER}
gsutil cp ${CREDENTIALS_JSON_LOCATION} ${COMPOSER_GCS_BUCKET_DATA_FOLDER}

echo "Importing environment variables from ${COMPOSER_INSTANCE_DATA_FOLDER}/${ENV_VARIABLES_JSON_NAME}..."

# Import environment's variables file
gcloud composer environments run ${COMPOSER_NAME} \
    --location ${COMPOSER_LOCATION} variables -- \
    -i ${COMPOSER_INSTANCE_DATA_FOLDER}/${ENV_VARIABLES_JSON_NAME}

echo "Importing pypi packages from ./pypi_packages..."

# Install PyPi packages from file
gcloud composer environments update ${COMPOSER_NAME} \
    --location ${COMPOSER_LOCATION} \
    --update-pypi-packages-from-file=pypi_packages
echo "Setting up bigquery_gdrive connection"

gcloud composer environments run ${ENVIRONMENT} \
    --location ${COMPOSER_LOCATION} connections -- --add \
    --conn_id=bigquery_gdrive --conn_type=google_cloud_platform \
    --conn_extra <<EXTRA '{"extra__google_cloud_platform__project": "our-project",
"extra__google_cloud_platform__key_path": "/home/airflow/gcs/data/service-account.json",
"extra__google_cloud_platform__scope": "https://www.googleapis.com/auth/bigquery,https://www.googleapis.com/auth/drive,https://www.googleapis.com/auth/cloud-platform"}'
EXTRA
echo "Done"