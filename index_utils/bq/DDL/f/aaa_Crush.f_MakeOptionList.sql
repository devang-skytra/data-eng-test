CREATE OR REPLACE FUNCTION aaa_Crush.f_MakeOptionList(options ARRAY<STRUCT<option_name STRING, option_value STRING>>) AS (
IFNULL(
    CONCAT(
      'OPTIONS (\n',
      (SELECT STRING_AGG(CONCAT('  ', option_name, '=', option_value), ',\n') FROM UNNEST(options)),
      '\n)\n'),
    ''
  )
);