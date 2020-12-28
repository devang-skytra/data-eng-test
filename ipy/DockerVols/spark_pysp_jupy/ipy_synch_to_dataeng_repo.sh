#!/usr/bin/env bash

# bash ipy_synch_to_dataeng_repo.sh

dataeng_dest=/media/paul/code/dataeng/ipy/DockerVols/spark_pysp_jupy

cd /media/paul/data/DockerVols/spark_pysp_jupy
cp -r ipy ${dataeng_dest}
cp -r py ${dataeng_dest}
cp -r py_modules ${dataeng_dest}
cp -r *.* ${dataeng_dest}
