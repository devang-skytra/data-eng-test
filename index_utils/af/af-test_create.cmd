SET COMPOSER_NAME = "benchmark-devtest-composer-3"
SET COMPOSER_LOCATION = "europe-west2"
echo COMPOSER_NAME is %COMPOSER_NAME%
SET bktDags = "gs://europe-west2-benchmark-devt-6ca0db0f-bucket/dags"

REM C:\gcpsdk\google-cloud-sdk>gsutil cp C:\git\index2\af\dags\sq\SavedQuery.md %bktDags%

REM beta (still?) must be used to provide --airflow-version
REM machineType 
gcloud beta composer environments create %COMPOSER_NAME% \
    --location=%COMPOSER_LOCATION%
    --image-version=composer-1.8.2-airflow-1.10.3 \
    --disk-size=100GB \
    --python-version=3 \
    --node-count=3
	--machineType n1-standard-1
REM --airflow-configs=core-dags_are_paused_at_creation=True
REM --image-version composer-latest-airflow-x.y.z \
	
	
REM NB: PyPi_req.txt packages must be complete list, not just new packages
REM consistently breaks Airflow GUI with 502 server error
REM https://stackoverflow.com/questions/53800011/google-cloud-composer-the-server-encountered-a-temporary-error-and-could-not-com
REM https://stackoverflow.com/questions/56586015/airflow-error-while-adding-python-dependency?rq=1
REM flower debugging https://groups.google.com/forum/#!topic/cloud-composer-discuss/Fg54FfXW2h8
gcloud composer environments update %COMPOSER_NAME% \
    --location %COMPOSER_LOCATION% \
    --update-pypi-packages-from-file=PyPi_req.txt


REM Either programmatically determine DAGS bucket location or could manually continue from this point 
SET bktDags=$(gcloud composer environments describe %COMPOSER_NAME% --location %COMPOSER_LOCATION% | grep 'dagGcsPrefix' | grep -Eo "\S+/")dags


REM  next use gsutil to deploy content from a dedicated bucket	
cd /home/paul_desmond/code/index/af/dags
gsutil -m cp -r * %bktDags%

cd /home/paul_desmond/code/index_NoGit/af/dags
REM gsutil -cp *.py ${bktDags}
gsutil -cp py/* %bktDags%/py

REM  Further options avail in H:\git\sbe\af\composer_setup.sh eg..
REM  Copy environment's variables file 
REM  Copy environment's service account credentials from our analytics GCS bucket
REM  Import environment's variables file
REM  Set up bigquery_gdrive connection