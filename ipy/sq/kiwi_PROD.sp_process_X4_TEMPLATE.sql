CREATE OR REPLACE PROCEDURE kiwi_PROD.sp_process_X4(IN from_date DATE, IN to_date DATE, IN debug_mode BOOL)
BEGIN

  --CALL kiwi_TEST.sp_process_X4('2019-05-17', '2019-05-17', TRUE);

  --DECLARE item DEFAULT (SELECT item FROM dataset1.products LIMIT 1);
  DECLARE dt DATE;
  DECLARE dset STRING DEFAULT 'kiwi_TEST';
  
  SET dt = from_date;
  
  WHILE dt <= to_date DO
    BEGIN

      --variables can have different scopes, so set WHILE scope variables here
      DECLARE bq_ts TIMESTAMP;
      DECLARE dtString STRING;
      DECLARE dtPrefix STRING;
      DECLARE proc_instance STRING;
      DECLARE dtbl STRING;

    --SET (variable_name_1, variable_name_2, …, variable_name_n) =
      --(expression_1, expression_2, …, expression_n);

      SET bq_ts = @@script.creation_time;
      SET dtString = CAST(dt as STRING);
      SET dtPrefix = CONCAT('%', REPLACE(dtString, '-', '/'), '%.gz.parquet');
      SET proc_instance = CONCAT('kiwi_TEST.sp_process_X4', ' ', dtString);
	  
      IF debug_mode THEN 
        INSERT INTO log.debug_any(ts, msg) VALUES( bq_ts, proc_instance );
      END IF;

    -- query: X4
    ------------------------------------------
      SET dtbl = 'X4_2019';
      
      IF debug_mode THEN
        
      ELSE
        DELETE kiwi_TEST.X4_2019 WHERE search_date = dt;

        [MAIN | ..\sq\X4_TEMPLATE.sql | %%X2%%,kiwi_TEST.ext_kiwi_pq_CurrentProcessingMonth | --%%ext-tbl-filter%%,_FILE_NAME like dtPrefix | %%ts%%,bq_ts | %%date%%,dt]

        [C:\git\index2\bq\sq\QC-aruk-and-na-legs.sql]

        INSERT INTO kiwi_TEST.X4_2019
        [--%%INSERT%%]

        insert into log.load(af_load_ts, ds, tb, af_task_instance) 
        values( bq_ts, dset, dtbl, proc_instance );

      END IF;

    EXCEPTION WHEN ERROR THEN
      --LOG EXCEPTION
      --@@error.stack_trace is ARRAY<STRUCT<line INT64, column INT64, filename STRING, location STRING>>
    END;
    
    

    SET dt = DATE_ADD(dt, INTERVAL 1 DAY);
  END WHILE;

  --SELECT SOMETHING IF WISH TO RETURN NON-OUT PARAMETER;
  

END;