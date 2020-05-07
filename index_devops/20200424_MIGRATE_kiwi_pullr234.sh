
gcloud config set core/project d-dat-digitalaircrafttransport

# extend X5b retention
#-------------------------------------

# done bq update --time_partitioning_expiration 31536000 kiwi.X5b


# done truncate X4

# done truncate X5a 


# X5a
#-------------------------------------
# done bq cp kiwi.X5a kiwi.X5a_bak

# --allow_large_results -> only for legacy sql

# done remove "classless_package_map" from json file

  
# done bq query --destination_table kiwi.X5a --replace --use_legacy_sql=false \
--time_partitioning_field search_date --require_partition_filter --time_partitioning_expiration 17280000 \
--destination_schema kiwi.X5a.json \
'SELECT * EXCEPT(classless_package_map) FROM kiwi.X5a where search_date > "2000-01-01"'


# X5b - big batch attempt
#-------------------------------------

# done bq cp kiwi.X5b kiwi.X5b_archive

# done confirm size and row count !!!!!!!!!!!!!!!!!!!!

# done bq rm -f -t kiwi.X5b


# done CORRECT BRANCH/X5B.JSON
bq mk --table --time_partitioning_field search_date --require_partition_filter --time_partitioning_expiration 30240000 --schema ./kiwi.X5b.json kiwi.X5b

# consider --dry_run

bq query --dry_run --destination_table kiwi.X5b --append_table --use_legacy_sql=false 'SELECT * EXCEPT(classless_journey_map) FROM kiwi.X5b_archive where search_date = "2020-04-01"'

etc

# tests
#-------------------------------------

select search_date, count(*) from kiwi.X5b_archive where search_date >= "2020-04-01" group by 1
--2020-04-01 1,253,733,633

select count(*) from kiwi.X5b_archive where search_date >= "2020-04-01"

select * from kiwi.X5b_archive where search_date >= "2020-04-01"

select * from kiwi.X5b where search_date >= "2020-04-01"




# do remainder on 2020-04-28 in1101
#-------------------------------------

start=`date +%s`

bq query --destination_table kiwi.X5b --append_table --use_legacy_sql=false 'SELECT * EXCEPT(classless_journey_map) FROM kiwi.X5b_archive where search_date between "2020-01-01" and "2020-01-31"'

bq query --destination_table kiwi.X5b --append_table --use_legacy_sql=false 'SELECT * EXCEPT(classless_journey_map) FROM kiwi.X5b_archive where search_date between "2019-12-01" and "2019-12-31"'

bq query --destination_table kiwi.X5b --append_table --use_legacy_sql=false 'SELECT * EXCEPT(classless_journey_map) FROM kiwi.X5b_archive where search_date between "2019-11-01" and "2019-11-30"'

bq query --destination_table kiwi.X5b --append_table --use_legacy_sql=false 'SELECT * EXCEPT(classless_journey_map) FROM kiwi.X5b_archive where search_date between "2019-10-01" and "2019-10-31"'

bq query --destination_table kiwi.X5b --append_table --use_legacy_sql=false 'SELECT * EXCEPT(classless_journey_map) FROM kiwi.X5b_archive where search_date between "2019-09-01" and "2019-09-30"'















