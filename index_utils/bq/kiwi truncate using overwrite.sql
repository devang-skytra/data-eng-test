

bq query --destination_table kiwi.X4 --replace --use_legacy_sql=false "SELECT * FROM kiwi.X4 where search_date = '1970-01-01' LIMIT 0"

bq query --destination_table kiwi.X5a --replace --use_legacy_sql=false "SELECT * FROM kiwi.X5a where search_date = '1970-01-01' LIMIT 0"
