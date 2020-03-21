
# BIG ISSUE HAD WITH LOSING FOLDER STRUCTURE ALL DOWN TO AVOID USING ENDING / ON LAST PREFIX

# WORKED
gsutil cp -r gs://index_bucket_1/KIWI/2017_11/01 gs://ext-kiwi-excl-data/data/2017/11/01

# PROVES CAN RENAME WHILE CP/MV
gsutil cp -r gs://index_bucket_1/KIWI/2017_11/02 gs://ext-kiwi-excl-data/data/2017/11/002

# TEST WITH -m PROVES WORKS AS WELL
#  TO BE SURE MAKE SURE LAST DEST PREFIX DOES NOT EXISTS BECAUSE THIS IS WHAT WORKED/WAS TESTED HERE
gsutil -m cp -r gs://index_bucket_1/KIWI/2017_11/03 gs://ext-kiwi-excl-data/data/2017/11/003


# RESET
# gsutil -m cp gs://ext-kiwi-excl-data/data/2017/11/01/00/* gs://index_bucket_1/KIWI/2017_11/01/00/
# REMOVE FAILED ATTEMPTS
# gsutil -m rm gs://ext-kiwi-excl-data/data/2017/11/01/*.gz.parquet
# gsutil -m rm gs://ext-kiwi-excl-data/data/2018/01/**


gsutil -m cp -r gs://index_bucket_1/KIWI/2017_11 gs://ext-kiwi-excl-data/data/2017/11

gsutil -m cp -r gs://index_bucket_1/KIWI/2018_01 gs://ext-kiwi-excl-data/data/2018/01

gsutil du -s gs://index_bucket_1/KIWI/2018_01
gsutil du -s gs://ext-kiwi-excl-data/data/2018/01

