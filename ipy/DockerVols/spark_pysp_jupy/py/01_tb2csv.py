#!/usr/bin/python
"""
# https://cloud.google.com/dataproc/docs/guides/submit-job
# https://cloud.google.com/sdk/gcloud/reference/dataproc/jobs/submit/pyspark
# py-files must be one of the following file formats ".py, .zip, or .egg". 

gcloud dataproc jobs submit pyspark gs://bkt/main.py --cluster=$cls --region=$reg --py-files= --jars="gs://bkt/my.jar"
--properties=[PROPERTY=VALUE,…]] 

gcloud dataproc jobs submit pyspark gs://pysparkcode/bq2gcs/01_tb2csv.py --cluster=$cls --region=$reg --bucket=dp-staging-forfree --jars=gs://spark-lib/bigquery/spark-bigquery-latest_2.12.jar
"""
# v1 import pyspark
from pyspark.sql import SparkSession, SQLContext

# v1 sc = pyspark.SparkContext()
# v1 sqlContext = SQLContext(sc)

spark = SparkSession.builder.appName("01_tb2csv"
    #).config("spark.jars", "/home/jovyan/ext_vol/jdbc/postgresql-42.2.18.jar"
    #).config("spark.driver.extraClassPath", "/home/jovyan/ext_vol/jdbc/postgresql-42.2.18.jar"
    ).getOrCreate()
sc = spark.sparkContext
sqlContext = SQLContext(sc)

tb = "eu_aaa_Crush.t_schema_cols"
pj = "forfree-288615"
df_tb = sqlContext.read.format("bigquery").option("table", tb) \
  .option("parentProject", pj) \
  .option("filter", "ds = 'eu_austin_bikeshare'") \
  .load()
# df_tb.printSchema()
df_tb.write.parquet('gs://pysparkoutput/' + tb.replace('.','/') + '/', mode = 'overwrite')
  #.select([feature_lst])
  # df.repartition(1).write.mode('overwrite').parquet('tmp/pyspark_us_presidents')
