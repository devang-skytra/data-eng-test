CREATE OR REPLACE FUNCTION aaa_Crush.f_MakeClusterByClause(columns ARRAY<STRUCT<column_name STRING, data_type STRING, is_nullable STRING, is_partitioning_column STRING, clustering_ordinal_position INT64>>) AS (
IFNULL(
    CONCAT(
      'CLUSTER BY ',
      (SELECT STRING_AGG(column_name, ', ' ORDER BY clustering_ordinal_position)
        FROM UNNEST(columns) WHERE clustering_ordinal_position IS NOT NULL),
      '\n'
    ),
    ''
  )
);