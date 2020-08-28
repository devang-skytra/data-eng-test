
--af/dags/sq/X7.sql

gcloud auth login paul.desmond@skytraindices.com

SET s=skytra-benchmark-devandtest
SET d=d-dat-digitalaircrafttransport

SET t=generic.divisor_exclusions
bq cp %s%:%t% %d%:%t%

SET t=generic.divisor_keys_airline
bq cp %s%:%t% %d%:%t%


index.X7


gcloud config set core/project skytra-benchmark-devandtest

bq update --table --schema ./index.X7.json index.X7