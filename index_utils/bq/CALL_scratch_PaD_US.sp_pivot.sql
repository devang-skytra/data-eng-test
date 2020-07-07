CALL scratch_PaD_US.sp_pivot(
  'scratch_PaD_US.vw_hoffa'
  , 'scratch_PaD_US.delete_pivotted' # destination table
  , ['MoteName', 'TIMESTAMP_TRUNC(Timestamp, HOUR) AS hour'] # row_ids
  , 'SensorName' # pivot_col_name
  , 'Data' # pivot_col_value
  , 8 # max_columns
  , 'AVG' # aggregation
  , 'LIMIT 10' # optional_limit
);