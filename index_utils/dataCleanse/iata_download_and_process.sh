
#For unzip size jump...
ls -l FinalOutput_2019-01-01_w_2019-01-07_Global.*
#2.0 -> 9.6 GB

#df
#/dev/sdb       4127419336 2220071048 1907331904  54% /home

cd /home/svc_iinet

sudo gsutil -m cp *.csv.gz gs://ext-iata-excl-data/2019/unzipped

sudo gsutil cp FinalOutput_2019-12-29_w_2019-12-31_Global.csv.gz gs://ext-iata-excl-data/2019/zipped
sudo gsutil cp FinalOutput_2020-01-01_w_2020-01-05_Global.csv.gz gs://ext-iata-excl-data/2019/zipped

gsutil ls gs://ext-iata-excl-data/2019/zipped/* | wc -l
#DU -c to include total -s for total only ( https://cloud.google.com/storage/docs/gsutil/commands/du )
gsutil du -s gs://ext-iata-excl-data/2019/zipped
gsutil du -c gs://ext-iata-excl-data/2019/zipped > iata_zipped_info.txt
# should be 58 and 113.971 GB once -1 file and -11 bytes for folder
# confirmed and in H:\git\BATCH_INDEX\Iata_2019_Checks.xlsx


#==> NOTE: You are performing a sequence of gsutil operations that may
#run significantly faster if you instead use gsutil -m -o ... Please
#see the -m section under "gsutil help options" for further information
#about when gsutil -m can be advantageous.



#Unavoidable due to no gsutil unzip command and 2GB GCF limit exceeded
#========================================================
sudo gunzip *.csv.gz 

#sudo gsutil -m cp *.csv gs://ext-iata-excl-data/2019

sudo gsutil -m cp *_w_2019-02*.csv gs://ext-iata-excl-data/2019/unzipped

ls *_w_2020*.csv

sudo gsutil -m cp *_w_2020*.csv gs://ext-iata-excl-data/2019/unzipped


#RECENTLY FOUND SAMPLE - pass to gunzip
gsutil cp gs://bucket_987234/compress_file.gz - | gunzip | tr -d '\000' | gsutil cp - gs://bucket_987234/uncompress_and_clean_file.



1)
gsutil -m mv gs://ext-iata-excl-data/2019/zipped/FinalOutput_*.csv.gz - | gunzip | gsutil cp - gs://ext-iata-excl-data/2019/loaded_to_bq/


gsutil setmeta -h "Content-Encoding:gzip" gs://ext-iata-excl-data/2019/zipped/*.csv.gz

bq load --replace --source_format=CSV iata_2019.X1_test \
    gs://ext-iata-excl-data/2019/zipped/FinalOutput_2019-01-15_w_2019-01-21_Global.csv.gz \
    ./iata.X1.json
    
--load is super slow with .gz, and cannot load .gz with external table defn, so must use unzipped for bigger loads

2)
X3.sql

3)
gsutil -m mv gs://ext-iata-excl-data/2019/unzipped/FinalOutput_2019-{}*.csv gs://ext-iata-excl-data/2019/loaded_to_bq/



sudo gsutil -m cp FinalOutput_2020-02*.csv.gz gs://ext-iata-excl-data/2020
164 MB/sec

VS

gsutil -m mv gs://ext-iata-excl-data/unzip-test/*.csv.gz - | gunzip | gsutil cp - gs://ext-iata-excl-data/unzip-test/unzipped/output.csv
CommandException: Destination object name needed when source is a stream
44 MB/sec
worked, did not delete orig csv.gz

However gunzip just as slow on VM therefore...

Conclusion - cp from VM, unzip from cloud console
cloud console
----------
gsutil -m mv gs://ext-iata-excl-data/2020/zipped/$filePrefix.csv.gz - | gunzip | gsutil cp - gs://ext-iata-excl-data/2020/unzipped/$filePrefix.csv
WRONG - cloud console has limits so need to unzip in VM and transfer both zip and unzip

#carefully move big folder hier
#gsutil -m mv gs://index_bucket_1/KIWI/2017_10 gs://ext-kiwi-excl-data/data/2017/10





#putty
#-----------
cd /home/svc_iinet 
ls -lh

filePrefix="FinalOutput_2020-04-27_w_2020-05-03_Global"
sudo gunzip -k $filePrefix.csv.gz

sudo gsutil -m cp $filePrefix.csv gs://ext-iata-excl-data/2020/unzipped

sudo gsutil -m cp $filePrefix.csv_sum.csv gs://ext-iata-excl-stat


#cloud shell - quickly check schema ends with DOC_AMOUNT_TYPE_INDICATOR and DOI range looks ok
#-----------
fileFull="FinalOutput_2020-04-27_w_2020-05-03_Global.csv"
gcsPath="gs://ext-iata-excl-data/2020/unzipped/"
#gsutil cat -r 0-2000 $gcsPath$fileFull



#bq gui
#-----------

select * 
from stat.iata_stats
where _FILE_NAME like '%FinalOutput_2020-04-27_w_2020-05-03_Global.csv_sum.csv'


DECLARE fileFull STRING DEFAULT 'FinalOutput_2020-04-27_w_2020-05-03_Global.csv';
#DECLARE fileFull STRING DEFAULT 'FinalOutput_2020-03-22_w_2020-03-29_missing_tkts_2_Global.csv';

insert into 
iata.int_X1_file_analysis 
select * 
EXCEPT(DOC_AMOUNT_TYPE_INDICATOR)
, _FILE_NAME as FILE_SOURCE 
, DOC_AMOUNT_TYPE_INDICATOR
from iata.ext_data
where _FILE_NAME like CONCAT('%',fileFull);


#cloud shell - move file
#-----------
echo $gcsPath
gcsDest="gs://ext-iata-excl-data/2020/loaded_to_bq"
gsutil mv -r $gcsPath* $gcsDest


#bq gui
#-----------

DECLARE fileFull STRING DEFAULT 'FinalOutput_2020-04-27_w_2020-05-03_Global.csv';
DECLARE dS DATE DEFAULT '2020-04-27';
DECLARE dE DATE DEFAULT '2020-05-03';

CALL iata_sp.sp_process_X3(dS, dE, fileFull, 'gs://ext-iata-excl-data/2020/unzipped/');
--select min(dt_of_issue), max(dt_of_issue) from iata.X3 where FILE_SOURCE like CONCAT('%',fileFull) and dt_of_issue > '2000-01-01'

CALL iata_sp.sp_process_I1(dS, dE, fileFull);
CALL iata_sp.sp_process_I2(dS, dE, fileFull);
CALL iata_sp.sp_process_I3(dS, dE, fileFull);



#select dt_of_issue, pl_id, count(*) from matching.X6 where dt_of_issue >= '2020-03-30' group by 1,2 order by 1,2
DECLARE dS DATE DEFAULT '2020-04-19';
DECLARE dE DATE DEFAULT '2020-04-29';
CALL matching_sp.sp_process_X6(dS, dE);












