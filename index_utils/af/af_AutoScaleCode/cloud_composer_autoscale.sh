#!/usr/bin/env bash

#cd code/BATCH_INDEX/af_AutoScaleCode
#bash cloud_composer_autoscale.sh

set -e

PROJECT="d-dat-digitalaircrafttransport"
COMPOSER_NAME="af-kiwi-2019"
COMPOSER_LOCATION="europe-west2"
CLUSTER_ZONE="europe-west2-c"

# Enable autoscaling in node level
GKE_CLUSTER=$(gcloud composer environments describe \
${COMPOSER_NAME} \
--location ${COMPOSER_LOCATION} \
--format="value(config.gkeCluster)" \
--project ${PROJECT} | \
grep -o '[^\/]*$')


gcloud container clusters update ${GKE_CLUSTER} --enable-autoscaling \
--min-nodes 1 \
--max-nodes 20 \
--zone ${CLUSTER_ZONE} \
--node-pool=default-pool \
--project ${PROJECT}

gcloud container clusters update ${GKE_CLUSTER} --add-maintenance-exclusion-name "2019-kiwi-build" \
--add-maintenance-exclusion-start "2020-01-10T08:00:00Z" \
--add-maintenance-exclusion-end "2020-01-23T07:59:00Z" \
--zone ${CLUSTER_ZONE} \
--node-pool=default-pool \
--project ${PROJECT}

# Patch airflow-worker to make it a Guaranteed QoS Pod
gcloud container clusters get-credentials ${GKE_CLUSTER} --zone ${CLUSTER_ZONE} --project ${PROJECT}

AIRFLOW_WORKER_NS=$(kubectl get namespaces | grep composer | cut -d ' ' -f1)

kubectl patch deployment airflow-worker -n ${AIRFLOW_WORKER_NS} --patch "$(cat composer_airflow_worker_patch.yaml)"

# Enable autoscaling in worker level
sed "s/{AIRFLOW_WORKER_NS}/${AIRFLOW_WORKER_NS}/" composer_airflow_worker_hpa.yaml > composer_airflow_worker_hpa_temp.yaml

kubectl apply -f composer_airflow_worker_hpa_temp.yaml

# Remove bottleneck from airflow configuration
gcloud composer environments update $COMPOSER_NAME \
--update-airflow-configs=core-max_active_runs_per_dag=150 \
--update-airflow-configs=core-dag_concurrency=300 \
--update-airflow-configs=core-dagbag_import_timeout=120 \
--update-airflow-configs=core-parallelism=300 \
--location $COMPOSER_LOCATION \
--project $PROJECT || true

gcloud composer environments update $COMPOSER_NAME \
--update-pypi-packages-from-file=PyPi_req_AF_KIWI_2019.txt \
--location $COMPOSER_LOCATION \
--project $PROJECT || true

gcloud composer environments update $COMPOSER_NAME \
--update-labels subproject=2019-index \
--location $COMPOSER_LOCATION \
--project $PROJECT || true

printf "\nAutoscale Enabled in composer environment: $COMPOSER_NAME project: $PROJECT\n"