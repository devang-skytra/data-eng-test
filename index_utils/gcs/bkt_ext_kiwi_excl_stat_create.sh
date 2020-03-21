#!/bin/bash
gsutil mb -b on -c standard -l europe-west1 gs://ext-kiwi-excl-stat
#perms
gsutil iam ch serviceAccount:svc-ext-kiwi-excl@d-dat-digitalaircrafttransport.iam.gserviceaccount.com:objectCreator gs://ext-kiwi-excl-stat