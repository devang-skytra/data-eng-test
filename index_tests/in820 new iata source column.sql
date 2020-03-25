/*
cd indexproduction
git pull origin
git checkout feature/IN-820-modify-iata-x1-for-new-doc_amt_ty
bq mk --table --schema ./bq/t/iata.X1.json data_eng.in820_X1
*/

insert into data_eng.in820_X1
select *
, _FILE_NAME as FILE_SOURCE 
from iata.ext_data
where _FILE_NAME like '%FinalOutput_2020-03-16_w_2020-03-22_Global.csv'

--result - Identical
select FARE_TYPE_INDICATOR, DOC_AMOUNT_TYPE_INDICATOR, COUNT(*) from data_eng.in820_X1 GROUP BY 1,2

drop table data_eng.in820_X1

--------------------------------------------------

--bq mk --table --schema ./iata.X1.json data_eng.in820_X1_MISSING

insert into data_eng.in820_X1_MISSING
--iata.int_X1_file_analysis 
select * 
--EXCEPT(DOC_AMOUNT_TYPE_INDICATOR)
, _FILE_NAME as FILE_SOURCE 
from iata.ext_data
where _FILE_NAME like '%FinalOutput_2020-01-01_w_2020-03-15_missing_tkts_Global.csv'