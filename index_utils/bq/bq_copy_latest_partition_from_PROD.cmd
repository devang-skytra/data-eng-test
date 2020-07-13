REM create or replace table scratch_PaD._ptnMax as (select 'kiwi' as ds, '20000101' as dt)
REM insert into scratch_PaD._ptnMax values('iata', '20000101')

REM GUI
REM delete scratch_PaD._ptnMax where dt = '2000-01-01'



REM ** KIWI **

delete scratch_PaD._ptnMax where ds = 'kiwi'

#LegacySQL
select 'kiwi' as ds, max(partition_id) as dt from [d-dat-digitalaircrafttransport.kiwi.X5b$__PARTITIONS_SUMMARY__] where partition_id <> '__NULL__'


REM -a eq --append   -n eq --no_clobber
select CONCAT('bq cp -a -n 'd-dat-digitalaircrafttransport:', p.ds, '.', t, '$', p.dt, "' ", p.ds, '.', t) as cp
from scratch_PaD._ptnMax p, UNNEST(['X4','X5a','X5b']) t
where  ds = 'kiwi'

bq cp -a -n 'd-dat-digitalaircrafttransport:kiwi.X4$20200701'  kiwi.X4
bq cp -a -n 'd-dat-digitalaircrafttransport:kiwi.X5a$20200701' kiwi.X5a
bq cp -a -n 'd-dat-digitalaircrafttransport:kiwi.X5b$20200701' kiwi.X5b



REM ** IATA.X1 **


REM every 10th day ending with '2' 12th etc, run following batch file to get 10 days of data from Migr to UAT
REM  then update af dag sched end_date to + 10 days also so it will catchup

SET ds_tb=iata.X1

bq query --use_legacy_sql=false "delete scratch_PaD._ptnMax where ds = '%ds_tb%'"

bq query --destination_table scratch_PaD._ptnMax --append_table --use_legacy_sql=true "select '%ds_tb%' as ds,cast(max(partition_id) as STRING) as dt from [d-dat-digitalaircrafttransport.%ds_tb%$__PARTITIONS_SUMMARY__] where partition_id <> '__NULL__'"

REM Manual unfort. https://stackoverflow.com/questions/6359820/how-to-set-commands-output-as-a-variable-in-a-batch-file
REM  bq | SET _result=%_test:~0,5% substring failed
REM We actually don't need to do 1st step above though, just incr. by 10 every 10 days and run, can also be rerun every day
SET ds_tb=iata.X1
SET dt=20200701
SET src_prj=d-dat-digitalaircrafttransport
SET dst_prj=skytra-benchmark-uat

bq rm -t -f %dst_prj%:%ds_tb%$%dt%

bq cp -a -n %src_prj%:%ds_tb%$%dt% %dst_prj%:%ds_tb%

REM SELECT min( file_date_int ), max(file_date_int), count(distinct file_date_int) FROM `skytra-benchmark-uat.iata.X1` where file_date_int > 0