-- create table if not exists iata.X3( f1 int64  );

-- alter table iata.X3 add column if not exists b geography options(description="my description");

DECLARE v_tbl STRING DEFAULT 'ext_EURUSD';
IF (SELECT creation_time  < TIMESTAMP_SUB(CURRENT_TIMESTAMP, INTERVAL 1 MONTH) FROM generic.INFORMATION_SCHEMA.TABLES WHERE table_name = v_tbl) THEN
  CREATE OR REPLACE EXTERNAL TABLE generic.ext_EURUSD OPTIONS(
  format = 'CSV',
  uris = ['gs://bucket/path1.csv']
  );
END IF

--  https://towardsdatascience.com/just-released-bigquery-user-friendly-sql-functions-979fca9cd007

/*
https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#create_external_table_statement
CREATE [OR REPLACE] EXTERNAL TABLE [IF NOT EXISTS] [[project_name.]dataset_name.]table_name
[(  column_name column_schema,  ...)]
[WITH PARTITION COLUMNS  [(      partition_column_name partition_column_type,      ...  )] ]  # hive-partitioned layout
OPTIONS (  external_table_option_list eg. compression,description,format,hive_partition_uri_prefix,require_hive_partition_filter,skip_leading_rows,uris  ... );

CREATE OR REPLACE EXTERNAL TABLE dataset.CsvTable
(
  x INT64,
  y STRING
)
OPTIONS (
  format = 'CSV',
  uris = ['gs://bucket/path1.csv'],
  field_delimiter = '|',
  max_bad_records = 5
);

CREATE EXTERNAL TABLE dataset.CustomHivePartitionedTable
WITH PARTITION COLUMNS (
  field_1 STRING, -- column order must match the external path
  field_2 INT64
)
OPTIONS (
  uris=['gs://bucket/path/*'],
  format=csv,
  hive_partition_uri_prefix='gs://bucket/path'
);

*/