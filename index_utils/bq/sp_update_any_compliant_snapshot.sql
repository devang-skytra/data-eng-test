CREATE OR REPLACE PROCEDURE generic_sp.sp_update_any_compliant_snapshot(
	base_dataset_table STRING,     --the base/dimension table
	initialise BOOLEAN,            --once only call to initiliase snapshotting tables
	unique_key_columns STRING)     --for any dimension mgt, a business key is needed eg. iata_code for airports

	--NB: at the time of initialisation, the base table must exist and contain a DATE column named 'last_update' as first_column
  
  /*
  create or replace table data_eng.skytra_airport as select date'2001-01-01' as last_update, * EXCEPT(last_update) from generic.skytra_airport
  # truncate table data_eng.skytra_airport_history
  INITIALISE
  insert into data_eng.skytra_airport_staging select 'UPDATE' as IUD_operation, 'PaD' as iata_code, * EXCEPT(iata_code, last_update) from generic.skytra_airport where iata_code = 'PHQ'
  update data_eng.skytra_airport_staging SET bad_airport = TRUE WHERE 1=1
  
  CALL generic_sp.sp_update_any_compliant_snapshot('generic.skytra_airport', TRUE  , '')
  CALL generic_sp.sp_update_any_compliant_snapshot('generic.skytra_airport', FALSE , 'iata_code')
  
  select * from data_eng.skytra_airport where last_update = (select max(last_update) from data_eng.skytra_airport)
  select * from data_eng.skytra_airport_history where iata_code in('PaD','PHQ')
  */
  

  
BEGIN

	IF initialise THEN
		
		--auto-create the correct schema for the _history table if does not already exist
		EXECUTE IMMEDIATE ( 'create table if not exists ' || base_dataset_table || """_history as
		( select SESSION_USER() as user, DATE'2001-01-01' as snapshot_date, * from """ || base_dataset_table || ' LIMIT 0)' );

		--auto-create the correct schema for the _staging table if does not already exist
		EXECUTE IMMEDIATE ( 'create table if not exists ' || base_dataset_table || """_staging as
		( select '' as IUD_operation, * EXCEPT(last_update) from """ || base_dataset_table || ' LIMIT 0)' );

	ELSE
    
		-- append entire base table into _history table recording user performing action and the current_date as snapshot_date
		EXECUTE IMMEDIATE ( 'INSERT into ' || base_dataset_table || '_history select SESSION_USER() as user, current_date as snapshot_date, * from ' || base_dataset_table );

		-- DELETE matched rows even when an UPDATE because UPDATE in our case is handled as DELETE and INSERT
		EXECUTE IMMEDIATE ( 'DELETE ' || base_dataset_table || ' WHERE CONCAT(' || unique_key_columns || ') IN (SELECT CONCAT(' || unique_key_columns || ') FROM ' || base_dataset_table || '_staging)' );

		-- process _staging table DELETE (this is a soft delete because appended to history table already above
		EXECUTE IMMEDIATE ( 'INSERT into ' || base_dataset_table || ' select current_date as last_update, * EXCEPT(IUD_operation)  from ' || base_dataset_table || '_staging where IUD_operation <> "DELETE"' );

		-- clear the _staging table 
		EXECUTE IMMEDIATE ( ' TRUNCATE TABLE ' || base_dataset_table || '_staging' );
	END IF;

END


/*
https://medium.com/google-cloud/using-bigquery-sql-merge-e4cebf9f91fc

then use SYS tables to do smart Merge by column_name as opposed to ordinal_position

https://cloud.google.com/bigquery/docs/reference/standard-sql/dml-syntax#merge_statement

create or replace table generic.skytra_airport_history_json as ( SELECT iata_code,  TO_JSON_STRING( s ) as json_row FROM generic.skytra_airport_staging s )


MERGE generic.skytra_airport tgt
	USING src
	ON T.product = S.product
WHEN MATCHED AND IUD_operation = 'UPSERT' THEN
	UPDATE SET quantity = T.quantity + S.quantity
WHEN MATCHED AND IUD_operation = 'DELETE' THEN
	DELETE
WHEN NOT MATCHED AND IUD_operation = 'UPSERT' THEN
	-- ROW can be used to include all the columns of the source in the ascending sequence of their ordinal positions
	INSERT ROW
ELSE
	RAISE_ERROR
*/