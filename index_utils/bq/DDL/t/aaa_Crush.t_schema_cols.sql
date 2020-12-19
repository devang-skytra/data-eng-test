CREATE OR REPLACE TABLE aaa_Crush.t_schema_cols
(
  pj STRING,
  ds STRING,
  tb STRING,
  tb_full STRING,
  script STRING,
  ts TIMESTAMP,
  columns ARRAY<STRUCT<column_name STRING, data_type STRING, is_nullable STRING, is_partitioning_column STRING, clustering_ordinal_position INT64>>,
  options ARRAY<STRUCT<option_name STRING, option_value STRING>>
)