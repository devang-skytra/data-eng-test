# create or replace table scratch_PaD._ptnMax as (select 'kiwi' as ds, '20000101' as dt)
# insert into scratch_PaD._ptnMax values('iata', '20000101')

#GUI
delete scratch_PaD._ptnMax where dt = '2000-01-01'
delete scratch_PaD._ptnMax where ds = 'kiwi'

#LegacySQL
select 'kiwi' as ds, max(partition_id) as dt from [d-dat-digitalaircrafttransport.kiwi.X5b$__PARTITIONS_SUMMARY__] where partition_id <> '__NULL__'


# -a eq --append   -n eq --no_clobber
select CONCAT('bq cp -a -n 'd-dat-digitalaircrafttransport:', p.ds, '.', t, '$', p.dt, "' ", p.ds, '.', t) as cp
from scratch_PaD._ptnMax p, UNNEST(['X4','X5a','X5b']) t
where  ds = 'kiwi'

bq cp -a -n 'd-dat-digitalaircrafttransport:kiwi.X4$20200701'  kiwi.X4
bq cp -a -n 'd-dat-digitalaircrafttransport:kiwi.X5a$20200701' kiwi.X5a
bq cp -a -n 'd-dat-digitalaircrafttransport:kiwi.X5b$20200701' kiwi.X5b





# gsutil -m cp -r gs://out-product-dev/* gs://trillo-fm-skytra-benchmark-dev/groups/


bq cp 'd-dat-digitalaircrafttransport.index.X7' index.X7


gsutil -m cp -r gs://trillo-fm-skytra-benchmark-dev/groups/ASAS_SIDF/* gs://trillo-fm-skytra-benchmark-uat/groups/ASAS_SIDF/

gsutil -m cp -r gs://trillo-fm-skytra-benchmark-dev/groups/ASAS_SISVDF/* gs://trillo-fm-skytra-benchmark-uat/groups/ASAS_SISVDF/

