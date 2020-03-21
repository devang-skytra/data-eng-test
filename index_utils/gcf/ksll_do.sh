#!/bin/bash
SRC_BUCKET_NAME="ext-kiwi-excl-data-test"
DEST_BUCKET_NAME="part*.csv"
TRIGGER_FILE="int-kiwi-data-test"
#--source defaults to Current directory will be used so not needed
# --trigger-resource needs ?? projects/{project}/buckets/{bucket}
gcloud beta functions deploy kiwiStatsLoadLite \ 
   --set-env-vars \
	DEST_BUCKET_NAME=$DEST_BUCKET_NAME \
	TRIGGER_FILE=$TRIGGER_FILE \
   --runtime python37 \
   --region europe-west1 \
   --memory 128MB  \
   --trigger-resource $SRC_BUCKET_NAME \
   --trigger-event google.storage.object.finalize