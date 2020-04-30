# https://cloud.google.com/composer/docs/how-to/using/testing-dags


#======================================================================
# Checking for PyPI package errors
# this script to test python install on 1 worker rather than cluster
#======================================================================

# Determine the Cloud Composer environment's GKE cluster
# gcloud composer environments describe benchmark-devtest-composer-3 --location europe-west2
"""
airflowUri: https://oeff0ed4fbdf51c0ep-tp.appspot.com
gkeCluster: projects/skytra-benchmark-devandtest/zones/europe-west2-a/
 clusters/europe-west2-benchmark-devt-6ca0db0f-gke
serviceAccount: cloud-composer@skytra-benchmark-devandtest.iam.gserviceaccount.com
imageVersion: composer-1.10.0-airflow-1.10.6
"""
# 

GKE_CLUSTER=projects/skytra-benchmark-devandtest/zones/europe-west2-a/clusters/europe-west2-benchmark-devt-6ca0db0f-gke
GKE_LOCATION=europe-west2
gcloud container clusters get-credentials $GKE_CLUSTER --zone $GKE_LOCATION

kubectl get pods --all-namespaces

namespace=composer-1-10-0-airflow-1-10-6-6ca0db0f
# airflow-scheduler-58cf745bbb-7db28 (not used - just for interest)
worker=airflow-worker-76755df87f-4jqsx
kubectl -n $namespace exec -it $worker -c airflow-worker -- /bin/bash

'''
sudo python3 -m pip install "[PACKAGE]"
airflow list_dags
airflow test --dry_run [DAG_ID] [TASK_ID] [EXECUTION_DATE]
airflow test [DAG_ID] [TASK_ID] [EXECUTION_DATE]
sudo python2 -m pip uninstall "[PACKAGE]"
'''
