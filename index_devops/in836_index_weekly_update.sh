




#set d-dat-digitalaircrafttransport active project
bq cp kiwi.X5b kiwi.X5b_bak_20200406
#delete X5b manually
bq cp skytra-benchmark-prod:kiwi.X5b d-dat-digitalaircrafttransport:kiwi.X5b
#below append backup/locally processed onto local copy from Prod
bq cp -a -n kiwi.X5b_bak_20200406 kiwi.X5b

#no perms to copy to prod so KhN can run later
#bq cp -a -n 'd-dat-digitalaircrafttransport:kiwi.X5b$20200318' skytra-benchmark-prod:kiwi.X5b



#should get 3,285,214,213
bq cp matching.X6 matching.X6_bak_20200406_pre_restore

#https://codechi.com/dev-tools/date-to-millisecond-calculators/
#https://currentmillis.com/
#3,288,993,047
bq cp matching.X6@1586170800000 matching.X6 
 
#3,288,993,047
bq cp matching.X6 matching.X6_bak_20200406_post_restore


DECLARE fd DATE DEFAULT '2020-03-12'; DECLARE td DATE DEFAULT '2020-04-01'; CALL matching_sp.sp_process_X6(fd, td);

SELECT * FROM log.proc_load WHERE DATE(_PARTITIONTIME) >= "2020-04-06" and tb = 'X6' order by 2