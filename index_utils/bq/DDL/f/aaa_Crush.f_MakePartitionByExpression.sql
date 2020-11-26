CREATE OR REPLACE FUNCTION aaa_Crush.f_MakePartitionByExpression(column_name STRING, data_type STRING) AS (
IF(column_name = '_PARTITIONTIME', 'DATE(_PARTITIONTIME)',
    IF(data_type = 'TIMESTAMP', CONCAT('DATE(', column_name, ')'), column_name)
  )
);