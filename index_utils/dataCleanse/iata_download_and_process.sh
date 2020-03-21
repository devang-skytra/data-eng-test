
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

putty
----------
cd /home/svc_iinet 
ls -lh

filePrefix="FinalOutput_2020-03-09_w_2020-03-15_Global"
sudo gunzip -k $filePrefix.csv.gz
sudo gsutil -m cp $filePrefix.csv gs://ext-iata-excl-data/2020/unzipped

#sudo gsutil -m cp $filePrefix.csv.gz gs://ext-iata-excl-data/2020/zipped

sudo gsutil -m cp $filePrefix.csv_sum.csv gs://ext-iata-excl-stat


insert into iata.int_X1_file_analysis 
select *, _FILE_NAME as file_source 
from iata.ext_iata_2020
where _FILE_NAME like '%FinalOutput_2020-03-09_w_2020-03-15_Global%'

--CALL iata_sp.sp_process_X3('2020-03-09', '2020-03-15', 'FinalOutput_2020-03-09_w_2020-03-15_Global', 'gs://ext-iata-excl-data/2020/loaded_to_bq/');
--CALL iata_sp.sp_process_I1('2020-03-09', '2020-03-15', 'FinalOutput_2020-03-09_w_2020-03-15_Global.csv');



#gsutil -m mv gs://index_bucket_1/KIWI/2017_10 gs://ext-kiwi-excl-data/data/2017/10















