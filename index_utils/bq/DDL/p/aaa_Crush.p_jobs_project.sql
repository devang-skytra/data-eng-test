CREATE OR REPLACE PROCEDURE aaa_Crush.p_jobs_project()
BEGIN
  
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
  FROM `region-eu.INFORMATION_SCHEMA.JOBS_BY_PROJECT` jbp, UNNEST(job_stages) js /*WITH OFFSET as offset1*/, UNNEST(steps) js_s /*WITH OFFSET as offset2*/, UNNEST(referenced_tables) AS r
  WHERE 
  ( r.table_id not like 'INFORMATION_SCHEMA%' and r.dataset_id not like 'inf_sch%' )
  and r.project_id <> 'bigquery-public-data'
  and  ( ( js_s.kind = 'READ' and substr(js_s.substeps[ORDINAL(1)],1,4) like '%:%' )  OR ( js.name like '%Output' and js_s.kind = 'WRITE') )
  ORDER BY job_id, js.id/*, offset1, offset2*/;
  
  
  CREATE OR REPLACE TABLE aaa_Crush.t_job_sources as
  SELECT 
  job_id,
  r.*
  FROM `region-eu.INFORMATION_SCHEMA.JOBS_BY_PROJECT` jbp, UNNEST(referenced_tables) AS r WITH OFFSET as offset
  WHERE 
  ( r.table_id not like 'INFORMATION_SCHEMA%' and r.dataset_id not like 'inf_sch%' )
  and r.project_id <> 'bigquery-public-data'
  ORDER BY job_id, offset;
  
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