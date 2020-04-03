CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190101` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-01';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190102` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-02';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190103` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-03';


CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190104` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-04';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190105` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-05';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190106` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-06';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190107` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-07';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190108` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-08';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190109` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-09';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190110` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-10';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190111` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-11';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190112` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-12';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190113` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-13';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190114` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-14';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190115` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-15';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190116` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-16';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190117` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-17';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190118` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-18';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190119` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-19';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190120` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-20';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190121` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-21';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190122` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-22';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190123` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-23';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190124` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-24';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190125` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-25';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190126` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-26';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190127` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-27';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190128` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-28';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190129` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-29';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190130` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-30';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190131` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-01-31';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190201` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-01';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190202` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-02';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190203` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-03';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190204` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-04';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190205` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-05';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190206` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-06';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190207` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-07';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190208` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-08';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190209` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-09';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190210` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-10';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190211` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-11';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190212` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-12';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190213` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-13';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190214` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-14';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190215` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-15';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190216` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-16';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190217` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-17';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190218` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-18';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190219` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-19';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190220` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-20';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190221` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-21';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190222` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-22';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190223` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-23';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190224` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-24';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190225` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-25';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190226` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-26';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190227` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-27';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190228` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-02-28';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190301` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-01';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190302` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-02';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190303` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-03';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190304` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-04';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190305` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-05';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190306` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-06';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190307` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-07';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190308` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-08';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190309` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-09';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190310` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-10';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190311` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-11';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190312` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-12';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190313` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-13';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190314` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-14';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190315` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-15';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190316` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-16';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190317` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-17';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190318` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-18';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190319` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-19';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190320` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-20';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190321` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-21';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190322` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-22';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190323` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-23';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190324` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-24';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190325` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-25';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190326` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-26';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190327` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-27';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190328` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-28';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190329` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-29';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190330` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-30';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190331` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-03-31';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190401` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-01';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190402` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-02';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190403` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-03';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190404` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-04';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190405` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-05';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190406` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-06';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190407` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-07';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190408` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-08';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190409` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-09';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190410` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-10';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190411` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-11';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190412` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-12';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190413` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-13';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190414` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-14';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190415` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-15';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190416` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-16';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190417` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-17';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190418` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-18';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190419` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-19';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190420` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-20';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190421` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-21';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190422` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-22';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190423` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-23';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190424` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-24';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190425` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-25';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190426` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-26';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190427` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-27';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190428` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-28';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190429` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-29';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190430` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-04-30';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190501` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-01';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190502` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-02';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190503` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-03';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190504` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-04';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190505` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-05';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190506` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-06';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190507` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-07';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190508` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-08';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190509` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-09';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190510` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-10';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190511` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-11';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190512` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-12';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190513` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-13';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190514` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-14';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190515` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-15';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190516` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-16';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190517` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-17';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190518` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-18';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190519` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-19';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190520` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-20';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190521` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-21';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190522` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-22';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190523` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-23';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190524` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-24';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190525` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-25';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190526` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-26';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190527` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-27';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190528` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-28';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190529` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-29';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190530` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-30';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190531` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-05-31';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190601` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-01';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190602` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-02';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190603` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-03';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190604` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-04';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190605` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-05';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190606` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-06';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190607` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-07';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190608` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-08';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190609` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-09';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190610` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-10';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190611` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-11';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190612` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-12';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190613` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-13';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190614` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-14';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190615` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-15';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190616` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-16';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190617` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-17';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190618` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-18';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190619` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-19';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190620` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-20';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190621` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-21';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190622` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-22';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190623` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-23';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190624` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-24';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190625` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-25';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190626` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-26';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190627` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-27';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190628` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-28';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190629` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-29';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190630` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-06-30';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190701` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-01';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190702` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-02';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190703` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-03';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190704` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-04';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190705` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-05';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190706` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-06';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190707` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-07';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190708` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-08';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190709` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-09';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190710` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-10';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190711` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-11';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190712` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-12';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190713` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-13';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190714` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-14';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190715` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-15';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190716` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-16';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190717` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-17';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190718` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-18';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190719` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-19';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190720` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-20';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190721` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-21';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190722` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-22';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190723` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-23';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190724` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-24';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190725` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-25';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190726` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-26';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190727` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-27';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190728` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-28';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190729` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-29';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190730` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-30';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190731` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-07-31';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190801` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-01';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190802` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-02';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190803` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-03';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190804` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-04';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190805` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-05';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190806` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-06';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190807` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-07';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190808` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-08';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190809` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-09';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190810` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-10';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190811` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-11';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190812` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-12';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190813` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-13';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190814` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-14';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190815` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-15';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190816` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-16';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190817` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-17';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190818` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-18';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190819` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-19';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190820` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-20';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190821` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-21';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190822` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-22';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190823` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-23';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190824` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-24';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190825` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-25';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190826` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-26';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190827` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-27';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190828` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-28';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190829` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-29';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190830` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-30';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190831` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-08-31';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190901` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-01';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190902` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-02';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190903` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-03';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190904` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-04';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190905` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-05';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190906` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-06';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190907` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-07';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190908` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-08';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190909` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-09';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190910` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-10';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190911` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-11';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190912` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-12';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190913` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-13';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190914` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-14';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190915` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-15';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190916` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-16';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190917` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-17';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190918` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-18';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190919` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-19';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190920` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-20';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190921` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-21';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190922` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-22';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190923` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-23';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190924` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-24';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190925` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-25';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190926` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-26';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190927` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-27';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190928` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-28';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190929` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-29';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190930` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-09-30';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191001` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-01';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191002` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-02';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191003` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-03';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191004` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-04';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191005` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-05';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191006` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-06';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191007` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-07';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191008` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-08';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191009` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-09';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191010` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-10';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191011` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-11';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191012` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-12';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191013` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-13';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191014` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-14';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191015` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-15';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191016` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-16';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191017` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-17';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191018` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-18';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191019` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-19';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191020` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-20';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191021` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-21';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191022` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-22';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191023` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-23';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191024` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-24';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191025` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-25';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191026` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-26';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191027` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-27';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191028` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-28';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191029` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-29';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191030` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-30';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191031` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-10-31';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191101` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-01';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191102` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-02';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191103` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-03';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191104` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-04';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191105` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-05';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191106` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-06';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191107` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-07';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191108` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-08';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191109` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-09';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191110` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-10';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191111` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-11';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191112` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-12';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191113` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-13';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191114` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-14';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191115` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-15';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191116` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-16';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191117` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-17';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191118` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-18';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191119` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-19';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191120` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-20';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191121` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-21';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191122` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-22';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191123` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-23';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191124` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-24';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191125` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-25';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191126` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-26';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191127` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-27';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191128` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-28';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191129` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-29';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191130` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-11-30';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191201` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-01';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191202` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-02';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191203` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-03';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191204` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-04';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191205` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-05';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191206` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-06';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191207` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-07';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191208` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-08';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191209` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-09';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191210` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-10';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191211` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-11';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191212` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-12';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191213` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-13';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191214` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-14';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191215` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-15';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191216` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-16';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191217` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-17';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191218` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-18';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191219` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-19';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191220` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-20';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191221` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-21';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191222` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-22';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191223` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-23';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191224` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-24';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191225` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-25';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191226` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-26';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191227` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-27';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191228` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-28';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191229` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-29';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191230` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-30';
CREATE OR REPLACE MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191231` 
OPTIONS (model_type='linear_reg', input_label_cols=['price'], DATA_SPLIT_METHOD='NO_SPLIT') AS
SELECT X6.price,  X6.leadtime,  X6.od_mile,  X6.nb_legs,  X6.op_carrier,  X6.od,  X6.stopover_code,   X6.time_of_day 
FROM `skytra-benchmark-rnd.scratch_PhD.X6a_MODEL` as X6
WHERE X6.first_flight_date_utc='2019-12-31';

