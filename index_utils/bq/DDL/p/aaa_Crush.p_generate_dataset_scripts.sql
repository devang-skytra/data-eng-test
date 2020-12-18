CREATE OR REPLACE PROCEDURE 
#data_eng
eu_aaa_Crush
.p_generate_dataset_scripts(prj STRING, region STRING, ds_include STRING, ds_exclude STRING)
BEGIN
  /*
  DECLARE prj DEFAULT 'skytra-benchmark-rnd';
  DECLARE region STRING DEFAULT 'region-eu';
  DECLARE ds_include STRING DEFAULT "'compliance_dashboard_v5'";
  DECLARE ds_exclude STRING DEFAULT "'na'";
  DECLARE dsets ARRAY<STRING> DEFAULT ['compliance_dashboard_v5'];
  DECLARE i INT64 DEFAULT 1;
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

    -- CONCAT('`', table_catalog, '.', table_schema, '.', table_name, '`') AS tb_full,
    -- AND table_name in('R3','R5','R6','R7_flights','R7_itineraries')
    -- AND substring(table_name,1,4) in('A001','A002','A004','A012','A013','A018','A019','A020','A021','R7_i')
    EXECUTE IMMEDIATE ( """INSERT INTO data_eng.t_schema_cols   
      SELECT 
      table_catalog as pj, table_schema as ds, table_name as tb,
      CONCAT("{{ dag_run.conf['dset'] if 'dset' in dag_run.conf else '""" || dsets[ORDINAL(i)] || """' }}", '.', table_name) AS tb_full,
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
    
    UPDATE data_eng.t_schema_cols SET script = (
      SELECT
        CONCAT(
          -- needs to be 'OR REPLACE TABLE' or 'TABLE IF NOT EXISTS' latter safely deploys only if doesn't already exist
          "CREATE {{ dag_run.conf['create_type'] if 'create_type' in dag_run.conf else 'TABLE IF NOT EXISTS' }} ",
          tb_full,
          '\n',
          data_eng.f_MakeColumnList(columns),
          data_eng.f_MakePartitionByClause(columns),
          data_eng.f_MakeClusterByClause(columns),
          data_eng.f_MakeOptionList(options),
          ';'
          ) 
        )
    WHERE ds = dsets[ORDINAL(i)];
    

    SELECT STRING_AGG(CONCAT(script,'\n') ORDER BY tb) from data_eng.t_schema_cols WHERE ts > TIMESTAMP_SUB(CURRENT_TIMESTAMP, INTERVAL 1 MINUTE);
    /*
    SELECT 
    STRING_AGG(
      CONCAT(
        SUBSTRING(tb,1,4),
        'Replace',
        " = op_gen.mk_BQO('",
        SUBSTRING(tb,1,4),
        "Replace', ",
        "'./sq/products/",
        tb,
        ".sql', ",
        '"{{ dag_run.conf[',
        "'dset'] }}.",
        tb,
        '", ',
        "'CREATE_NEVER', 'WRITE_TRUNCATE', 1, 1, DEBUG_MODE, None, None, conn) \n\n"
      )
    , '' ORDER BY tb
    ) as etl
    from data_eng.t_schema_cols 
    WHERE 
    tb between 'P001' and 'P003'  OR  tb between 'P019' and 'P026'
    */

    EXCEPTION WHEN ERROR THEN
      RETURN;

    END;
    SET i = i + 1;
  END WHILE;

  --  Options as arr< <str> > rather than str? Does fx support it?
END;


