CREATE OR REPLACE PROCEDURE data_eng.p_generate_dataset_scripts(prj STRING, region STRING, ds_include STRING, ds_exclude STRING)
BEGIN
  /*
  DECLARE prj DEFAULT 'skytra-benchmark-rnd';
  DECLARE region STRING DEFAULT 'region-eu';
  DECLARE ds_include STRING DEFAULT "'compliance_dashboard_v5'";
  DECLARE ds_exclude STRING DEFAULT "'na'";
  */
  
  # CALL data_eng.p_generate_dataset_scripts( 'skytra-benchmark-rnd', 'region-eu',  "'compliance_dashboard_v5'", "'na'" ) 
  # https://github.com/GoogleCloudPlatform/training-data-analyst/blob/master/courses/data-engineering/demos/information_schema.md
  
  DECLARE dsets ARRAY<STRING>;
  DECLARE i INT64 DEFAULT 1;  # starting ORDINAL for an array is 1

  
  EXECUTE IMMEDIATE ("""CREATE OR REPLACE TABLE data_eng.ztmp_dsets as ( SELECT schema_name 
  FROM """ || CONCAT('`',prj,'.',region) || ".INFORMATION_SCHEMA.SCHEMATA` WHERE ( schema_name IN(" || ds_include || "  ) OR " || ds_include  || " = '' ) AND schema_name NOT IN(" || ds_exclude || "))"
  );

  SET dsets = ARRAY(SELECT schema_name FROM data_eng.ztmp_dsets);
  
  WHILE i <= ARRAY_LENGTH(dsets) DO
  BEGIN
  
    EXECUTE IMMEDIATE ( "DELETE data_eng.t_schema_cols WHERE ds = '" || dsets[ORDINAL(i)] || "'" );
  
    EXECUTE IMMEDIATE ( """INSERT INTO data_eng.t_schema_cols   
      SELECT 
      table_catalog as pj, table_schema as ds, table_name as tb,
      CONCAT('`', table_catalog, '.', table_schema, '.', table_name, '`') AS tb_full,
      '' AS script,
      CURRENT_TIMESTAMP AS ts,
      ARRAY_AGG(
        STRUCT(column_name, data_type, is_nullable, is_partitioning_column, clustering_ordinal_position)
        ORDER BY ordinal_position
      ) AS columns,
      ( SELECT ARRAY_AGG(STRUCT(option_name, option_value)) as tb_options
        FROM `""" || CONCAT(prj,'.',dsets[ORDINAL(i)]) || """.INFORMATION_SCHEMA.TABLE_OPTIONS` AS t2
        WHERE t.table_name = t2.table_name
      ) AS options

      FROM `""" || CONCAT(prj,'.',dsets[ORDINAL(i)]) || """.INFORMATION_SCHEMA.TABLES` AS t
      LEFT JOIN `""" || CONCAT(prj,'.',dsets[ORDINAL(i)]) || """.INFORMATION_SCHEMA.COLUMNS` USING (table_catalog, table_schema, table_name)
      WHERE table_type = 'BASE TABLE'
      GROUP BY table_catalog, table_schema, t.table_name""" 
    );
    
    EXCEPTION WHEN ERROR THEN
      RETURN;

    END;
    SET i = i + 1;
  END WHILE;

  UPDATE data_eng.t_schema_cols SET script = (
    SELECT
      CONCAT(
        'CREATE OR REPLACE TABLE ',
        tb_full,
        '\n',
        data_eng.f_MakeColumnList(columns),
        data_eng.f_MakePartitionByClause(columns),
        data_eng.f_MakeClusterByClause(columns),
        data_eng.f_MakeOptionList(options)
        ) 
      )
  WHERE ds = dsets[ORDINAL(i)];
  
  --  Options as arr< <str> > rather than str? Does fx support it?
END;


