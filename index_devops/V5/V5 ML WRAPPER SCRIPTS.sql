
DECLARE a_dates ARRAY<STRING>;
DECLARE a_regions ARRAY<STRING>;

# FIRST RUN 
SET a_dates = ARRAY (SELECT FORMAT_DATE ("%Y-%m-%d", x) FROM UNNEST( generate_date_array('2018-11-01','2018-11-05') ) x );
# SECOND RUN 
# SET a_dates = ARRAY (SELECT FORMAT_DATE ("%Y-%m-%d", x) FROM UNNEST( generate_date_array('2018-11-06','2019-02-01') ) x );

SET a_regions = ARRAY(SELECT region_pair_abbrv FROM generic.skytra_index_regions WHERE region_pair_abbrv IN('ASAS','ASEU','ASNA','EUEU','EUNA','NANA') ORDER BY 1 );

# PAUL
# CALL `skytra-benchmark-rnd.index_sp.sp_process_X11`( a_dates, a_regions, 'matching_models_test', 'matching', 'matching_models_test', 'matching', FALSE );
# PAULO R
CALL `skytra-benchmark-rnd.index_sp.sp_process_X11_SANS_OD`( a_dates, a_regions, 'matching_models_test_SANS_OD', 'matching', 'matching_models_test_SANS_OD', 'matching', FALSE );




CALL `skytra-benchmark-rnd.index_sp.sp_process_X11`( a_dates, a_regions, 'matching_models_test', 'matching', 'matching_models_test', 'matching', FALSE );
CALL `skytra-benchmark-rnd.index_sp.sp_process_X11_SANS_OD`( a_dates, a_regions, 'matching_models_test_SANS_OD', 'matching', 'matching_models_test_SANS_OD', 'matching', FALSE );

