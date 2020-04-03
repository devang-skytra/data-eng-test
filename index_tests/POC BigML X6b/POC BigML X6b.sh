#C:\Users\pdesmond\Documents\Spreadsheet Helpers\BIG ML...xlsm

bq mk --table --time_partitioning_field first_flight_date_utc --schema ./matching.X6.json skytra-benchmark-rnd:scratch_PhD.X6_for_BQ_linear_reg_ptn

bq query --allow_large_results --append_table --use_legacy_sql=false --destination_table skytra-benchmark-rnd:scratch_PhD.X6_for_BQ_linear_reg_ptn "select * FROM skytra-benchmark-rnd.scratch_PhD.X6_for_BQ_linear_reg"


bq mk --table --time_partitioning_field first_flight_date_utc --clustering_fields region_pair --schema ./matching.X6b.json scratch_PhD.X6a_MODEL
bq mk --table --time_partitioning_field first_flight_date_utc --clustering_fields region_pair --schema ./matching.X6b.json scratch_PhD.X6a_PREDICT
#add predicted_price column to X6b.json for X6b
bq mk --table --time_partitioning_field first_flight_date_utc --clustering_fields region_pair --schema ./matching.X6b.json scratch_PhD.X6b

#Archi queries
#Model - X6_kiwi_price_lin_reg_model
#Predict - X6_kiwi_price_lin_reg_prediction

#x2 inserts in one statement
insert into 
scratch_PhD.X6a_MODEL
--scratch_PhD.X6a_PREDICT
SELECT 
  X6.pl_id, X6.ticket_id, X6.region_pair, X6.dt_of_issue, X6.nb_legs, X6.leadtime, X6.first_flight_date_utc, X6.journey_map,
  X6.classless_journey_map, X6.sumP, X6.od_mile, X6.leg_prices, X6.leg_miles, X6.mkt_carrier_code_list, X6.operating_carrier_list, X6.mkt_carrier,
  IF (LENGTH(X6.op_carrier)=2, X6.op_carrier, 'XX') AS op_carrier,
  X6.n_pkg, X6.price, X6.key_type, X6.distribution_channel, X6.source_code, X6.ticket_document_amount, X6.FILE_SOURCE,
  X1.true_origin as od, 
  X1.stopover_code,
  IF(SAFE_CAST(X1.FLIGHT_DEPART_TIME AS INT64) BETWEEN 900 AND 2100, 'peak', 'non-peak') as time_of_day
FROM
  `skytra-benchmark-rnd.scratch_PhD.2019_minprice_X6_AS_AS_sumP_verified_part`
  --`skytra-benchmark-rnd.scratch_PhD.2019_minprice_X6_AS_AS_partitioned` 
  as X6
INNER JOIN
  `d-dat-digitalaircrafttransport.IATA_batch_4_global.FinalOutput_2019` as X1
ON
  X6.ticket_id=X1.ticket_id AND X1.segment_id='1'
WHERE
  X6.price IS NOT NULL
  AND X6.leadtime>=0
  AND X6.first_flight_date_utc between '2019-01-01' and '2019-12-31'
--170,945,837 rows to skytra-benchmark-rnd:scratch_PhD.X6a_MODEL = select count(*) from `skytra-benchmark-rnd.scratch_PhD.2019_minprice_X6_AS_AS_sumP_verified_part` WHERE first_flight_date_utc between '2019-01-01' and '2019-12-31'
--392,573,074 rows to skytra-benchmark-rnd:scratch_PhD.X6a_PREDICT = select count(*) from `skytra-benchmark-rnd.scratch_PhD.2019_minprice_X6_AS_AS_partitioned` WHERE first_flight_date_utc between '2019-01-01' and '2019-12-31'

# DELETE scratch_PhD.X6b as X6 WHERE X6.first_flight_date_utc>='2019-01-01'



#https://cloud.google.com/bigquery-ml/docs/reference/standard-sql/bigqueryml-syntax-feature
#select * FROM ML.FEATURE_INFO(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190101`)

#https://cloud.google.com/bigquery-ml/docs/reference/standard-sql/bigqueryml-syntax-train
#select * FROM ML.TRAINING_INFO(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190101`)

# *** https://cloud.google.com/bigquery-ml/docs/reference/standard-sql/bigqueryml-syntax-evaluate
select * FROM ML.EVALUATE(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190101`)

# **  https://cloud.google.com/bigquery-ml/docs/reference/standard-sql/bigqueryml-syntax-weights
select * FROM ML.WEIGHTS(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190101`)

# logistic regression-specific metrics https://cloud.google.com/bigquery-ml/docs/reference/standard-sql/bigqueryml-syntax-roc





Public Sub CreateModel()
    Dim d, df, dt As Date
    Dim i As Integer
    Dim sql, s, pred, p As String
    
    sql = Sheet1.Range("a1")
    pred = Sheet1.Range("a3")
    df = Sheet1.Range("c1")
    dt = Sheet1.Range("d1")

    d = df
    i = 1
    Sheet2.Range("A:C").Clear
    
    Do While d <= dt
        s = Replace(Replace(sql, "yyyymmdd", Format(d, "yyyymmdd")), "yyyy-mm-dd", Format(d, "yyyy-mm-dd"))
        p = Replace(Replace(pred, "yyyymmdd", Format(d, "yyyymmdd")), "yyyy-mm-dd", Format(d, "yyyy-mm-dd"))
        Sheet2.Cells(i, 1) = s
        Sheet2.Cells(i, 3) = p
        i = i + 1
        d = d + 1
    Loop
End Sub


from google.cloud import bigquery

# Construct a BigQuery client object.
client = bigquery.Client()

# TODO(developer): Set model_id to the ID of the model to fetch.
# model_id = 'your-project.your_dataset.your_model'

model = client.get_model(model_id)  # Make an API request.

full_model_id = "{}.{}.{}".format(model.project, model.dataset_id, model.model_id)
friendly_name = model.friendly_name
print(
    "Got model '{}' with friendly_name '{}'.".format(full_model_id, friendly_name)
)
