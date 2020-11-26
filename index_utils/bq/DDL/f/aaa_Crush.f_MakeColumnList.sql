CREATE OR REPLACE FUNCTION aaa_Crush.f_MakeColumnList(columns ARRAY<STRUCT<column_name STRING, data_type STRING, is_nullable STRING, is_partitioning_column STRING, clustering_ordinal_position INT64>>) AS (
IFNULL(
    CONCAT(
      '(\n',
      (SELECT STRING_AGG(CONCAT('  ', column_name, ' ', data_type,  aaa_Crush.f_MakeNullable(data_type, is_nullable)), ',\n')
       FROM UNNEST(columns)),
      '\n)\n'
    ),
    ''
  )
);