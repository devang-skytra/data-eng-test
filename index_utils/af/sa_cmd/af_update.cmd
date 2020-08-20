
REM https://cloud.google.com/sdk/gcloud/reference/composer/environments/update

gcloud config set core/project skytra-benchmark-prod

SET PROJECT=skytra-benchmark-prod
SET COMPOSER_NAME=benchmark-prod-composer
SET COMPOSER_LOCATION=europe-west2


gcloud auth activate-service-account cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com --key-file "C:\Users\PaulDesmond\OneDrive - SKYTRA LIMITED\Automation\gcp_keys\skytra-benchmark-prod-6d88d2848958.json" 

gcloud composer environments update %COMPOSER_NAME% --location %COMPOSER_LOCATION% --update-airflow-configs=core-default_timezone=Europe/London

REM --impersonate-service-account=cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com
REM ERROR: (gcloud.composer.environments.update) Error 403 (Forbidden) - failed to impersonate [cloud-composer@skytra-benchmark-prod.iam.gserviceaccount.com]. Make sure the account that's trying to impersonate it has access to the service account itself and the "roles/iam.serviceAccountTokenCreator" role.


gcloud composer environments update %COMPOSER_NAME% --location %COMPOSER_LOCATION% --update-pypi-packages-from-file=C:\git\DataEng\index_utils\af\sa_cmd\PyPi_req_af.txt
REM --update-pypi-package "aiohttp"



REM --update-airflow-configs=
REM for additional examples see 
REM 		C:\git\DataEng\index_utils\af\af_AutoScaleCode\cloud_composer_autoscale.sh
REM 		https://airflow.apache.org/docs/stable/configurations-ref.html
REM webserver-dag_orientation=TB “Default DAG orientation. Valid values are:” LR (Left->Right), TB (Top->Bottom), RL (Right->Left), BT (Bottom->Top)