CREATE OR REPLACE FUNCTION aaa_Crush.f_MakePartitionByClause(columns ARRAY<STRUCT<column_name STRING, data_type STRING, is_nullable STRING, is_partitioning_column STRING, clustering_ordinal_position INT64>>) AS (
IFNULL(
    CONCAT(
      'PARTITION BY ',
      (SELECT aaa_Crush.f_MakePartitionByExpression(column_name, data_type)
       FROM UNNEST(columns) WHERE is_partitioning_column = 'YES'),
      '\n'),
    ''
  )
);