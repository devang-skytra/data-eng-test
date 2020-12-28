#!/usr/bin/python
# gcloud dataproc jobs submit pyspark gs://pysparkcode/bq2gcs/02_pq2pq.py --cluster=$cls --region=$reg --bucket=dp-staging-forfree 
#   --jars=gs://spark-lib/bigquery/spark-bigquery-latest_2.12.jar

# v1 import pyspark
from pyspark.sql import SparkSession, SQLContext #, Row

# v1 sc = pyspark.SparkContext()
# v1 sqlContext = SQLContext(sc)

spark = SparkSession.builder.appName("02_pq2pq"
    ).getOrCreate()
sc = spark.sparkContext
sqlContext = SQLContext(sc)

"""
use '--' to separate arguments to your job from arguments to gcloud:
...test-pyspark.py -- 7 2017-11-01
var = int(sys.argv[1]) if len(sys.argv) > 1 else 2
"""


pq = 'gs://source-data-forfree/data_y=2020_m=07_d=01_hr=00_part-00000.gz.parquet'
df_pq = sqlContext.read.parquet(pq)

df_pq_x1 = df_pq.limit(1000).selectExpr(
    "*", 
    "from_unixtime(timestamp,'yyyy-MM-dd') AS search_date", 
    "data_list.booking_token.sid AS sid", 
    "data_list.booking_token.sid AS ind_sid", 
    "data_list.booking_token.id AS btid", 
    "data_list.booking_token.p AS p", 
    "data_list.booking_token.partner IN('skytra_user') AS skytra_search", 
    "data_list.route AS routes",
    "ROW_NUMBER() OVER(PARTITION BY data_list.booking_token.sid ORDER BY(data_list.booking_token.sid)) AS rank",
    "posexplode(data) as (sortorder,data_list)"
    ).drop("data","currency","currency_rate","data_list")

from pyspark.sql.functions import split

df_pq_x2 = df_pq_x1.filter(
    "(search_params.flyFrom_type NOT IN ('anywhere', 'radius') AND search_params.to_type NOT IN ('anywhere', 'radius') ) AND size(data_list.route) < 7 AND rank = 1"
    ).withColumn("a_btid", split("btid","\\|")
    ).withColumn("a_p", split("p","\\|").cast("array<decimal(10,2)>")
    ).drop("btid","p")

from pyspark.sql.functions import explode, arrays_zip

df_pq_x3 = df_pq_x2.withColumn("splits", explode( arrays_zip("a_btid","a_p") ))
df_pq_x3.printSchema()

"""
root
 |-- timestamp: long (nullable = true)
 |-- search_params: struct (nullable = true)
 |    |-- flyFrom_type: string (nullable = true)
 |    |-- seats: struct (nullable = true)
 |    |    |-- adults: integer (nullable = true)
 |    |    |-- children: integer (nullable = true)
 |    |    |-- infants: integer (nullable = true)
 |    |    |-- passengers: integer (nullable = true)
 |    |-- to_type: string (nullable = true)
 |-- search_date: string (nullable = true)
 |-- sid: string (nullable = true)
 |-- ind_sid: string (nullable = true)
 |-- skytra_search: boolean (nullable = true)
 |-- routes: array (nullable = true)
 |    |-- element: struct (containsNull = true)
 |    |    |-- aTimeUTC: long (nullable = true)
 |    |    |-- airline: string (nullable = true)
 |    |    |-- dTimeUTC: long (nullable = true)
 |    |    |-- fare_classes: string (nullable = true)
 |    |    |-- flight_no: integer (nullable = true)
 |    |    |-- flyFrom: string (nullable = true)
 |    |    |-- flyTo: string (nullable = true)
 |    |    |-- id: string (nullable = true)
 |    |    |-- operating_carrier: string (nullable = true)
 |    |    |-- vehicle_type: string (nullable = true)
 |    |    |-- source: string (nullable = true)
 |    |    |-- found_on: string (nullable = true)
 |    |    |-- fare_category: string (nullable = true)
 |-- rank: integer (nullable = true)
 |-- sortorder: integer (nullable = false)
 |-- a_btid: array (nullable = true)
 |    |-- element: string (containsNull = true)
 |-- a_p: array (nullable = true)
 |    |-- element: decimal(10,2) (containsNull = true)
 |-- splits: struct (nullable = false)
 |    |-- a_btid: string (nullable = true)
 |    |-- a_p: decimal(10,2) (nullable = true)
 """
 
from pyspark.sql.functions import regexp_replace

# ERR No such struct field btid in a_btid, a_p;

df_pq_x4 = df_pq_x3.withColumn( 
    "pkg_id", regexp_replace("splits.a_btid","_(\\d+)$","") 
    ).groupBy(["sid","ind_sid","pkg_id"]
    ).sum("splits.a_p")
df_pq_x4.printSchema()

"""
root
 |-- sid: string (nullable = true)
 |-- ind_sid: string (nullable = true)
 |-- pkg_id: string (nullable = true)
 |-- sum(splits.a_p AS `a_p`): decimal(20,2) (nullable = true)
 """