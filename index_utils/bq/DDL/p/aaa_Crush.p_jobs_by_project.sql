CREATE OR REPLACE PROCEDURE `forfree-288615.aaa_Crush.p_jobs_by_project`(region STRING, pj_include ARRAY<STRING>, pj_exclude ARRAY<STRING>, ds_include ARRAY<STRING>, ds_exclude ARRAY<STRING>)
BEGIN

  # CALL aaa_Crush.p_jobs_by_project('region-us', ['forfree-288615'], [], [], ['inf_sch_us','aaa_Crush'])

  DECLARE prjs ARRAY<STRING>;
  DECLARE prjs_STR STRING;
  DECLARE dsets STRING;
  DECLARE i INT64 DEFAULT 1;  # starting ORDINAL for an array is 1
  
  SET prjs = ARRAY( SELECT DISTINCT catalog_name FROM INFORMATION_SCHEMA.SCHEMATA 
    WHERE ( catalog_name IN UNNEST(pj_include) OR ARRAY_LENGTH(pj_include) = 0 ) AND schema_name NOT IN UNNEST(pj_exclude)
    # AND so.option_name = 'description'
  );
  SET prjs_STR = CONCAT("'", ARRAY_TO_STRING( prjs, "','" ), "'");


  SET dsets = ( SELECT CONCAT("'", ARRAY_TO_STRING( ARRAY_AGG(schema_name), "','" ), "'") FROM INFORMATION_SCHEMA.SCHEMATA 
                 WHERE ( schema_name IN UNNEST(ds_include) OR ARRAY_LENGTH(ds_include) = 0 ) AND schema_name NOT IN UNNEST(ds_exclude)
  );

  
  WHILE i <= ARRAY_LENGTH(prjs) DO
  BEGIN
    
    EXECUTE IMMEDIATE ( "DELETE aaa_Crush.t_job WHERE project_id = '" || prjs[ORDINAL(i)] || "'" );
  
    EXECUTE IMMEDIATE ( """INSERT INTO aaa_Crush.t_job   
      SELECT 
      jbp.project_id, 
      user_email, 
      job_id, 
      job_type, 
      statement_type, 
      start_time, 
      end_time, 
      query,
      reservation_id, 
      total_bytes_processed as total_bytes, 
      total_slot_ms, 
      cache_hit,
      destination_table.dataset_id, 
      destination_table.table_id, 
      ARRAY_AGG(DISTINCT CONCAT('`',r.project_id,'.',r.dataset_id,'.',r.table_id,'`')) as ref_tb_full,
      SUM(js.records_read) as recordsRead,
      SUM(js.records_written) as recordsWritten,
      SUM(parallel_inputs) as parallelInputs,
      SUM(completed_parallel_inputs) as completedParallelInputs,
      SUM(shuffle_output_bytes) as shuffleOutputBytes,
      SUM(shuffle_output_bytes_spilled) as shuffleOutputBytesSpilled,
      SUM(slot_ms) as slot_ms
      FROM `""" || region || """.INFORMATION_SCHEMA.JOBS_BY_PROJECT` jbp, UNNEST(referenced_tables) AS r, UNNEST(job_stages) AS js
      WHERE 
      jbp.project_id = '""" || prjs[ORDINAL(i)] || "' AND dataset_id IN (" || dsets || """)
      AND r.project_id IN (""" || prjs_STR || ") AND r.dataset_id IN (" || dsets || """) AND r.table_id not like 'INFORMATION_SCHEMA%'
      GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14""" 
    );
    
    EXCEPTION WHEN ERROR THEN
      RETURN;

    END;
    SET i = i + 1;
  END WHILE;
  
  /*
  CREATE OR REPLACE TABLE aaa_Crush.t_job as
  SELECT DISTINCT
  jbp.project_id, 
  user_email, 
  job_id, 
  job_type, 
  statement_type, 
  start_time, 
  end_time, 
  reservation_id, 
  total_bytes_processed as total_bytes, 
  total_slot_ms, 
  cache_hit,
  destination_table.dataset_id, 
  destination_table.table_id, 
  FROM `region-eu.INFORMATION_SCHEMA.JOBS_BY_PROJECT` jbp, UNNEST(referenced_tables) AS r # doubles up rows
  WHERE 
  ( r.table_id not like 'INFORMATION_SCHEMA%' and r.dataset_id not like 'inf_sch%' )
  and r.project_id <> 'bigquery-public-data'
  #and total_bytes_processed > 0
  ;


  CREATE OR REPLACE TABLE aaa_Crush.t_job_steps as
  SELECT DISTINCT
  job_id,
  js.id, 
  js.name,
  js.shuffle_output_bytes,
  js.shuffle_output_bytes_spilled,
  js_s.kind,
  array_to_string( js_s.substeps,' ' ) as step,
  #AVG(
  IF(js_s.kind = 'READ', js.records_read,0) as rows_read,
  #AVG(
  IF(js_s.kind = 'WRITE', js.records_written, 0) as rows_written
  FROM `region-eu.INFORMATION_SCHEMA.JOBS_BY_PROJECT` jbp, UNNEST(job_stages) js, UNNEST(steps) js_s, UNNEST(referenced_tables) AS r
  WHERE 
  ( r.table_id not like 'INFORMATION_SCHEMA%' and r.dataset_id not like 'inf_sch%' )
  and r.project_id <> 'bigquery-public-data'
  and  ( ( js_s.kind = 'READ' and substr(js_s.substeps[ORDINAL(1)],1,4) like '%:%' )  OR ( js.name like '%Output' and js_s.kind = 'WRITE') )
  ORDER BY job_id, js.id;
  
  
  CREATE OR REPLACE TABLE aaa_Crush.t_job_sources as
  SELECT 
  job_id,
  r.*
  FROM `region-eu.INFORMATION_SCHEMA.JOBS_BY_PROJECT` jbp, UNNEST(referenced_tables) AS r WITH OFFSET as offset
  WHERE 
  ( r.table_id not like 'INFORMATION_SCHEMA%' and r.dataset_id not like 'inf_sch%' )
  and r.project_id <> 'bigquery-public-data'
  ORDER BY job_id, offset;
  */
  
  
  /*
  SELECT 
  concat(src.dataset_id,'.',src.table_id) , s.step
  from
  inf_sch_us.job_steps s 
  inner join inf_sch_us.job_sources src on src.job_id = s.job_id
  and s.step like concat('%',src.dataset_id,'.',src.table_id,'%') 
  where  s.job_id = 'bquxjob_3782d374_174caf9c8b0'
  */
  
END;