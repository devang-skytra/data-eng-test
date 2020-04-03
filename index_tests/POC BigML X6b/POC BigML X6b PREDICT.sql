INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190101`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-01'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190102`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-02'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190103`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-03'));


INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190104`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-04'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190105`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-05'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190106`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-06'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190107`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-07'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190108`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-08'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190109`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-09'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190110`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-10'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190111`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-11'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190112`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-12'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190113`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-13'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190114`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-14'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190115`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-15'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190116`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-16'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190117`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-17'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190118`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-18'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190119`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-19'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190120`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-20'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190121`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-21'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190122`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-22'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190123`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-23'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190124`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-24'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190125`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-25'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190126`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-26'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190127`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-27'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190128`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-28'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190129`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-29'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190130`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-30'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190131`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-01-31'));


INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190201`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-01'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190202`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-02'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190203`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-03'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190204`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-04'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190205`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-05'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190206`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-06'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190207`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-07'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190208`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-08'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190209`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-09'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190210`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-10'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190211`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-11'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190212`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-12'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190213`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-13'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190214`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-14'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190215`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-15'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190216`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-16'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190217`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-17'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190218`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-18'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190219`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-19'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190220`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-20'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190221`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-21'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190222`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-22'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190223`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-23'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190224`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-24'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190225`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-25'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190226`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-26'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190227`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-27'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190228`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-02-28'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190301`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-01'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190302`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-02'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190303`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-03'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190304`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-04'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190305`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-05'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190306`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-06'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190307`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-07'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190308`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-08'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190309`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-09'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190310`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-10'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190311`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-11'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190312`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-12'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190313`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-13'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190314`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-14'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190315`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-15'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190316`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-16'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190317`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-17'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190318`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-18'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190319`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-19'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190320`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-20'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190321`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-21'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190322`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-22'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190323`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-23'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190324`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-24'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190325`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-25'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190326`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-26'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190327`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-27'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190328`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-28'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190329`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-29'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190330`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-30'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190331`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-03-31'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190401`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-01'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190402`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-02'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190403`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-03'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190404`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-04'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190405`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-05'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190406`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-06'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190407`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-07'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190408`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-08'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190409`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-09'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190410`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-10'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190411`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-11'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190412`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-12'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190413`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-13'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190414`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-14'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190415`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-15'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190416`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-16'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190417`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-17'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190418`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-18'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190419`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-19'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190420`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-20'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190421`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-21'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190422`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-22'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190423`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-23'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190424`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-24'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190425`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-25'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190426`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-26'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190427`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-27'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190428`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-28'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190429`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-29'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190430`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-04-30'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190501`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-01'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190502`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-02'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190503`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-03'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190504`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-04'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190505`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-05'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190506`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-06'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190507`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-07'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190508`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-08'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190509`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-09'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190510`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-10'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190511`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-11'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190512`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-12'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190513`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-13'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190514`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-14'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190515`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-15'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190516`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-16'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190517`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-17'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190518`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-18'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190519`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-19'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190520`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-20'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190521`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-21'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190522`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-22'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190523`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-23'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190524`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-24'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190525`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-25'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190526`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-26'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190527`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-27'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190528`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-28'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190529`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-29'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190530`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-30'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190531`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-05-31'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190601`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-01'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190602`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-02'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190603`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-03'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190604`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-04'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190605`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-05'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190606`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-06'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190607`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-07'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190608`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-08'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190609`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-09'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190610`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-10'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190611`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-11'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190612`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-12'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190613`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-13'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190614`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-14'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190615`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-15'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190616`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-16'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190617`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-17'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190618`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-18'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190619`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-19'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190620`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-20'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190621`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-21'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190622`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-22'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190623`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-23'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190624`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-24'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190625`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-25'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190626`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-26'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190627`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-27'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190628`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-28'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190629`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-29'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190630`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-06-30'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190701`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-01'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190702`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-02'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190703`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-03'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190704`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-04'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190705`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-05'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190706`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-06'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190707`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-07'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190708`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-08'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190709`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-09'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190710`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-10'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190711`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-11'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190712`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-12'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190713`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-13'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190714`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-14'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190715`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-15'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190716`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-16'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190717`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-17'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190718`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-18'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190719`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-19'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190720`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-20'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190721`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-21'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190722`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-22'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190723`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-23'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190724`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-24'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190725`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-25'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190726`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-26'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190727`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-27'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190728`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-28'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190729`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-29'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190730`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-30'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190731`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-07-31'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190801`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-01'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190802`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-02'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190803`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-03'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190804`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-04'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190805`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-05'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190806`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-06'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190807`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-07'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190808`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-08'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190809`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-09'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190810`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-10'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190811`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-11'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190812`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-12'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190813`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-13'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190814`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-14'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190815`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-15'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190816`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-16'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190817`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-17'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190818`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-18'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190819`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-19'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190820`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-20'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190821`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-21'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190822`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-22'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190823`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-23'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190824`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-24'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190825`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-25'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190826`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-26'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190827`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-27'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190828`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-28'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190829`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-29'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190830`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-30'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190831`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-08-31'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190901`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-01'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190902`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-02'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190903`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-03'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190904`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-04'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190905`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-05'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190906`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-06'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190907`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-07'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190908`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-08'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190909`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-09'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190910`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-10'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190911`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-11'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190912`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-12'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190913`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-13'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190914`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-14'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190915`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-15'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190916`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-16'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190917`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-17'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190918`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-18'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190919`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-19'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190920`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-20'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190921`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-21'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190922`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-22'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190923`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-23'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190924`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-24'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190925`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-25'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190926`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-26'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190927`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-27'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190928`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-28'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190929`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-29'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20190930`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-09-30'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191001`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-01'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191002`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-02'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191003`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-03'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191004`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-04'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191005`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-05'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191006`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-06'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191007`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-07'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191008`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-08'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191009`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-09'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191010`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-10'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191011`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-11'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191012`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-12'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191013`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-13'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191014`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-14'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191015`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-15'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191016`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-16'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191017`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-17'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191018`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-18'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191019`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-19'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191020`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-20'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191021`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-21'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191022`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-22'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191023`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-23'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191024`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-24'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191025`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-25'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191026`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-26'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191027`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-27'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191028`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-28'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191029`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-29'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191030`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-30'));


INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191031`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-10-31'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191101`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-01'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191102`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-02'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191103`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-03'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191104`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-04'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191105`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-05'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191106`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-06'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191107`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-07'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191108`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-08'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191109`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-09'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191110`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-10'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191111`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-11'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191112`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-12'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191113`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-13'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191114`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-14'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191115`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-15'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191116`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-16'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191117`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-17'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191118`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-18'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191119`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-19'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191120`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-20'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191121`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-21'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191122`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-22'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191123`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-23'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191124`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-24'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191125`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-25'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191126`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-26'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191127`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-27'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191128`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-28'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191129`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-29'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191130`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-11-30'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191201`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-01'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191202`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-02'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191203`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-03'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191204`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-04'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191205`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-05'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191206`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-06'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191207`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-07'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191208`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-08'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191209`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-09'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191210`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-10'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191211`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-11'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191212`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-12'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191213`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-13'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191214`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-14'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191215`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-15'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191216`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-16'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191217`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-17'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191218`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-18'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191219`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-19'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191220`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-20'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191221`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-21'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191222`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-22'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191223`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-23'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191224`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-24'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191225`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-25'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191226`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-26'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191227`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-27'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191228`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-28'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191229`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-29'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191230`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-30'));
INSERT INTO scratch_PhD.X6b
SELECT * EXCEPT (predicted_price), predicted_price FROM ML.PREDICT(MODEL `skytra-benchmark-rnd.2019_X6_minprice_AS_AS_ml_models.kiwi_price_lin_reg_model_20191231`,
( SELECT * FROM `skytra-benchmark-rnd.scratch_PhD.X6a_PREDICT` as X6 WHERE X6.first_flight_date_utc='2019-12-31'));
