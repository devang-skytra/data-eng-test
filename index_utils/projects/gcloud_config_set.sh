#!/bin/bash
#gcloud projects list  does not flag which is active
#gcloud config get-value SECTION/PROPERTY [GCLOUD_WIDE_FLAG …]
#gcloud config get-value core/project
gcloud config set core/project d-dat-digitalaircrafttransport
gcloud config set core/project skytra-benchmark-devandtest
