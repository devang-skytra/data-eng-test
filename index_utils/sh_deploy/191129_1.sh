#!/bin/bash
#  cd /home/paul_desmond/code/sbe/sh_deploy
#  bash 191129_1.sh > 191129_1.log
#  bq
#    datasets
cd /home/paul_desmond/code/index/bq/ds
#bash ds_matching_create.sh
#    tables
cd ../t
#bash matching.X6.sh
#bash kiwi.K_pkg.sh
#bash kiwi.X5.sh
bash kiwi.X4.sh
bash kiwi.X2.sh
#    dags
cd /home/paul_desmond/code/index/af/dags
bash af_deploy.sh