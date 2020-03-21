#!/bin/bash
bq --location=EU mk --dataset --description "DataOps dataset" ${GC_PROJECT_ID}:DataOps
