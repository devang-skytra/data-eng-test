

create or replace view products_m.vw_P002 as 



CALL products_m.sp_pivot(
    'products_m.vw_P002'  		# source object
  , 'products_m.P002_pivotted'  # destination table
  , ['dt_of_issue']       		# row_ids
  , 'unpiv_key'            		# pivot_col_name
  , 'unpiv_val'          		# pivot_col_value
  , 1000                        # column limit
  , 'AVG'                       # aggregation
  , 'LIMIT 1000000'             # row limit
);