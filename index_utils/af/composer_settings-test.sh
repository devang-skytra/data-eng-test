#!/usr/bin/env bash

COMPOSER_NAME = "airflow-test"
GCS_LOCATION = "gs://analytics/credentials/"
COMPOSER_INSTANCE_DATA_FOLDER = "/home/airflow/gcs/data"
COMPOSER_LOCATION = "europe-west1"
ENV_VARIABLES_JSON_NAME = "airflow_env_variables_test.json"
CREDENTIALS_JSON_NAME = "service-account.json"

ENV_VARIABLES_JSON_GCS_LOCATION = GCS_LOCATION${ENV_VARIABLES_JSON_NAME}
CREDENTIALS_JSON_LOCATION = GCS_LOCATION${CREDENTIALS_JSON_NAME}