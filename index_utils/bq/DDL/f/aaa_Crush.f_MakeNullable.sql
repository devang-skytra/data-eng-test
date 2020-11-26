CREATE OR REPLACE FUNCTION aaa_Crush.f_MakeNullable(data_type STRING, is_nullable STRING) AS (
IF(not STARTS_WITH(data_type, 'ARRAY<') and is_nullable = 'NO', ' NOT NULL', '')
);