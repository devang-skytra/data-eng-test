#!/usr/bin/env bash

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