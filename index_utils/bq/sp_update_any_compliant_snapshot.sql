
CREATE OR REPLACE PROCEDURE data_eng.sp_update_any_compliant_snapshot(base_dataset_table STRING, initialise BOOLEAN) 

	--NB: at the time of initialisation, the base table must exist and contain a date column named 'last_update'

	-- CALL data_eng.sp_update_any_compliant_snapshot('generic.skytra_airport', true)
	-- insert into generic.skytra_airport_staging select 'PaD' as iata_code, * EXCEPT(iata_code, last_update), 'UPSERT' as IUD_operation from generic.skytra_airport where iata_code = 'PHQ'
	-- CALL data_eng.sp_update_any_compliant_snapshot('generic.skytra_airport', false)
BEGIN

	IF initialise THEN
		
		--auto-create the correct schema for the _history table if does not already exist
		EXECUTE IMMEDIATE ( 'create table if not exists ' || base_dataset_table || """_history as
		( select *, SESSION_USER() as user, DATE'2000-01-01' as snapshot_date from """ || base_dataset_table || ' LIMIT 0)' );

		--auto-create the correct schema for the _staging table if does not already exist
		EXECUTE IMMEDIATE ( 'create table if not exists ' || base_dataset_table || """_staging as
		( select * EXCEPT(last_update), '' as IUD_operation from """ || base_dataset_table || ' LIMIT 0)' );

	ELSE
    
		-- idempotent deletes first ? YES!
	
		-- append entire base table into _history table recording user performing action and the current_date as snapshot_date
		EXECUTE IMMEDIATE ( 'INSERT into ' || base_dataset_table || '_history select *, SESSION_USER() as user, current_date as snapshot_date from ' || base_dataset_table );

		-- process _staging table according to the IUD_operation
		EXECUTE IMMEDIATE ( 'INSERT into ' || base_dataset_table || ' select * EXCEPT(IUD_operation), current_date as last_update from ' || base_dataset_table || '_staging where IUD_operation = "INSERT"' );

		-- clear the _staging table 
		EXECUTE IMMEDIATE ( ' DELETE ' || base_dataset_table || '_staging where 1=1' );
	END IF;

END


/*
need to pass in csv unique_key_columns which can be passed into a CONCAT() as is

IUD_operation only 2 types UPSERT (includes flagging bad_record/disable) or DELETE (which is a soft delete because goes into _history table anyway)


Merit of using ARRAY_AGG(ROW) -> STRUCT to insert into History table so don't have to maintain synch of base and _history??

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