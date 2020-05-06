WITH tbls as ( 
SELECT table_schema, table_name FROM index.INFORMATION_SCHEMA.TABLES where table_name like 'X7%'    UNION ALL
SELECT table_schema, table_name FROM matching.INFORMATION_SCHEMA.TABLES where table_name like 'X6%' UNION ALL
SELECT table_schema, table_name FROM iata.INFORMATION_SCHEMA.TABLES where table_name like 'I%'
),

cols as ( --INFORMATION_SCHEMA.TABLES INFORMATION_SCHEMA.COLUMNS INFORMATION_SCHEMA.COLUMN_FIELD_PATHS
SELECT * FROM index.INFORMATION_SCHEMA.COLUMNS      WHERE table_name in(select table_name from tbls) UNION ALL
SELECT * FROM matching.INFORMATION_SCHEMA.COLUMNS  WHERE table_name in(select table_name from tbls) UNION ALL
SELECT * FROM iata.INFORMATION_SCHEMA.COLUMNS WHERE table_name in(select table_name from tbls)
)

select * from 
(
SELECT table_schema, table_name, table_name as c1, -1 as c2 FROM tbls
UNION ALL
SELECT table_schema, table_name, '-' as c1, 0 as c2 FROM tbls
UNION ALL
SELECT table_schema, table_name, '' as c1, 99 as c2 FROM tbls
UNION ALL
SELECT
table_schema, table_name, CONCAT( column_name, ' ', data_type, ' ', IF(is_partitioning_column='YES','UNIQUE ',''), IF(clustering_ordinal_position > 0, 'UNIQUE','') ) as c1, ordinal_position as c2
FROM cols
)
order by 1,2,4

# https://app.quickdatabasediagrams.com/#/

/* Allowed relationship types are:

-     - one TO one
-<    - one TO many
>-    - many TO one
>-<   - many TO many
-0    - one TO zero or one
0-    - zero or one TO one
0-0   - zero or one TO zero or one
-0<   - one TO zero or many
>0-   - zero or many TO one

*/