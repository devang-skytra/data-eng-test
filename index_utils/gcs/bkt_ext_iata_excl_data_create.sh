#!/bin/bash
gsutil mb -b on -c standard -l europe-west1 gs://ext-iata-excl-data

#perms - not sure this is needed
#gsutil iam ch serviceAccount:156629557333-compute@developer.gserviceaccount.com:objectCreator gs://ext-iata-excl-data

#/home/airbus/ext_iata_excl_data in iata vm is where gs://ext-iata-excl-data is mounted
#https://cloud.google.com/storage/docs/gcs-fuse#using
'''
export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s`
echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install gcsfuse
'''
#$ cd /home/airbus
#$ sudo mkdir /home/airbus/ext_iata_excl_data
#$ sudo chmod 777 /home/airbus/ext_iata_excl_data
#$ gcsfuse ext-iata-excl-data /home/airbus/ext_iata_excl_data
#TEST $ cp schema.json ext_iata_excl_data
