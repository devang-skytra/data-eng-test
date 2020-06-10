/*

X6 file-based DAG test DevTest setup
=========================================================

iata      - fresh
kiwi      - not fresh
  bq cp -a -n 'd-dat-digitalaircrafttransport:kiwi.X5b$20200412' kiwi.X5b
  bq cp -a -n 'd-dat-digitalaircrafttransport:kiwi.X5b$20200411' kiwi.X5b
  
  bq cp -a -n 'd-dat-digitalaircrafttransport:kiwi.X5b$20200419' kiwi.X5b
  bq cp -a -n 'd-dat-digitalaircrafttransport:kiwi.X5b$20200418' kiwi.X5b


matching  - fresh - PROTECT
log       - na and no need to protect

create cutdown version (files and days) of DAG for DevTest
deploy new proc
-modify X5b to query Migrated project
-create X6_in1196 [ create table matching.X6_in1196 as ( select top 0 * from matching.X6 ) ]
-modify delte, insert etc to different X6_in1196



Reverse modifications above or delete/rename proc
*/

