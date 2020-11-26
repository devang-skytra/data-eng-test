CREATE OR REPLACE PROCEDURE aaa_Crush.p_generate_dataset_scripts(ds_include ARRAY<STRING>, ds_exclude ARRAY<STRING>)
BEGIN

  # CALL inf_sch_us.sp_generate_dataset_scripts([],[]) #['inf_sch_us']
  # https://github.com/GoogleCloudPlatform/training-data-analyst/blob/master/courses/data-engineering/demos/information_schema.md
  
  DECLARE dsets ARRAY<STRING>;
  DECLARE i INT64 DEFAULT 1;  # starting ORDINAL for an array is 1
  
  SET dsets = ARRAY( SELECT schema_name FROM INFORMATION_SCHEMA.SCHEMATA 
    WHERE ( schema_name IN UNNEST(ds_include) OR ARRAY_LENGTH(ds_include) = 0 ) AND schema_name NOT IN UNNEST(ds_exclude)
    # AND so.option_name = 'description'
  );

  
  WHILE i <= ARRAY_LENGTH(dsets) DO
  BEGIN
  
    EXECUTE IMMEDIATE ( "DELETE aaa_Crush.t_schema_cols WHERE ds = '" || dsets[ORDINAL(i)] || "'" );
  
    EXECUTE IMMEDIATE ( """INSERT INTO aaa_Crush.t_schema_cols   
      SELECT 
      table_catalog as pj, table_schema as ds, table_name as tb,
      CONCAT('`', table_catalog, '.', table_schema, '.', table_name, '`') AS tb_full,
      ARRAY_AGG(
        STRUCT(column_name, data_type, is_nullable, is_partitioning_column, clustering_ordinal_position)
        ORDER BY ordinal_position
      ) AS columns,
      ( SELECT ARRAY_AGG(STRUCT(option_name, option_value)) as tb_options
        FROM """ || dsets[ORDINAL(i)] || """.INFORMATION_SCHEMA.TABLE_OPTIONS AS t2
        WHERE t.table_name = t2.table_name
      ) AS options

      FROM """ || dsets[ORDINAL(i)] || """.INFORMATION_SCHEMA.TABLES AS t
      LEFT JOIN """ || dsets[ORDINAL(i)] || """.INFORMATION_SCHEMA.COLUMNS USING (table_catalog, table_schema, table_name)
      WHERE table_type = 'BASE TABLE'
      GROUP BY table_catalog, table_schema, t.table_name""" 
    );
    
    EXCEPTION WHEN ERROR THEN
      RETURN;

    END;
    SET i = i + 1;
  END WHILE;

  /* UPDATE inf_sch_us.t_schema_cols SET script = (
    SELECT
      CONCAT(
        'CREATE OR REPLACE TABLE ',
        table_name,
        '\n',
        inf_sch_us.fx_MakeColumnList(columns),
        inf_sch_us.fx_MakePartitionByClause(columns),
        inf_sch_us.fx_MakeClusterByClause(columns),
        inf_sch_us.fx_MakeOptionList(options)
        ) as DDL_script
    FROM Components;
    
   )
  */
  
  /*
  Options as arr< <str> > rather than str? Does fx support it?
  */
  
END;

