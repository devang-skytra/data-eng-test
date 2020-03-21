#!/bin/bash
cd /home/paul_desmond/code/index2/af/dags
gsutil -m cp -r * gs://europe-west2-af-test-no-pyp-3dc83611-bucket/dags
cd /home/paul_desmond/code/index2