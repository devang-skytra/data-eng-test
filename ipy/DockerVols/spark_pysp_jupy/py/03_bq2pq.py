#!/usr/bin/python
# gcloud dataproc jobs submit pyspark gs://pysparkcode/bq2gcs/02_pq2pq.py --cluster=$cls --region=$reg --bucket=dp-staging-forfree 
#   --jars=gs://spark-lib/bigquery/spark-bigquery-latest_2.12.jar

# v1 import pyspark
from pyspark.sql import SparkSession, SQLContext #, Row

# v1 sc = pyspark.SparkContext()
# v1 sqlContext = SQLContext(sc)

spark = SparkSession.builder.appName("03_bq2pq"
    ).getOrCreate()
sc = spark.sparkContext
sqlContext = SQLContext(sc)

"""
use '--' to separate arguments to your job from arguments to gcloud:
...test-pyspark.py -- 7 2017-11-01
var = int(sys.argv[1]) if len(sys.argv) > 1 else 2
"""


tb = "eu_aaa_Crush.t_schema_cols"
pj = "forfree-288615"
df_tb = sqlContext.read.format("bigquery").option("table", tb) \
  .option("parentProject", pj) \
  .option("filter", "ds = 'eu_austin_bikeshare'") \
  .load()
# df_tb.printSchema()
df_tb.write.parquet('gs://pysparkoutput/' + tb.replace('.','/') + '/', mode = 'overwrite')



