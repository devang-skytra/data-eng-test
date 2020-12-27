
$prj='forfree-288615'
gcloud config set project $prj

$cls='dp-us-1n-100gb-sp24-ju-pip1'
$reg='us-central1'
$zne="$reg-a"
$bkt="$cls-gcs"

gsutil mb -c standard -l $reg gs://$bkt

# --scopes https://www.googleapis.com/auth/cloud-platform

gcloud beta dataproc clusters create $cls --enable-component-gateway --region $reg --zone ${zne} --single-node --master-machine-type n1-standard-4 --master-boot-disk-size 100 --image-version 1.5-debian10 --optional-components ANACONDA,JUPYTER --scopes 'https://www.googleapis.com/auth/cloud-platform' --project $prj --bucket $bkt --metadata 'PIP_PACKAGES=google-cloud-bigquery google-cloud-storage' --initialization-actions gs://goog-dataproc-initialization-actions-$reg/python/pip-install.sh

# https://medium.com/google-cloud/apache-spark-and-jupyter-notebooks-made-easy-with-dataproc-component-gateway-fa91d48d6a5a

# https://github.com/GoogleCloudDataproc/cloud-dataproc/tree/master/notebooks

# need to create OAuth credentials for external SDK calls  https://developers.google.com/identity/sign-in/web/sign-in
#   GCPSDK
#   18021881858-i7huoj9h8bjmks3ml2fjp9c790hr14s5.apps.googleusercontent.com
#   7NiyVHUC5XeA7h0Vuq5tODvz
#  OR --impersonate-service-account=SERVICE_ACCOUNT_EMAIL

  from pyspark.sql import SparkSession
  spark = SparkSession.builder \
    .appName('Jupyter BigQuery Storage')\
    .config('spark.jars', 'gs://spark-lib/bigquery/spark-bigquery-latest_2.12.jar') \
    .getOrCreate()
  
  
# Notebooks
# https://codelabs.developers.google.com/codelabs/spark-jupyter-dataproc?hl=en#5
# https://cloud.google.com/ai-platform/notebooks/docs/troubleshooting
#   403 - iam.serviceAccounts.ActAs  OR  Service Account - Service Account User

gcloud beta dataproc clusters stop $cls --region=$reg

# --impersonate-service-account=18021881858-compute@developer.gserviceaccount.com



