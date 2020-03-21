#!/bin/bash
#${GC_PROJECT_ID} did not work, hardcode did, then gcloud_config_set.sh so no longer need to specify project
#gsutil mb -b on -c standard -l europe-west1 -p ${GC_PROJECT_ID} gs://ext-kiwi-excl-data-test
#gsutil mb -b on -c standard -l europe-west1 -p d-dat-digitalaircrafttransport gs://ext-kiwi-excl-data-test
gsutil mb -b on -c standard -l europe-west1 gs://ext-kiwi-excl-data-test
