

cd /home/svc_iinet/data_tdam_monthly
ls -lh

sudo gunzip -k FinalOutput2019m*.csv.gz
gsutil -m cp   gs://ext-iata-excl-data/repl-tdam/FinalOutput2019m*.csv gs://ext-iata-excl-data/2020/unzipped

insert into iata.int_X1_repl_tdam
select *, _FILE_NAME as FILE_SOURCE
from iata.ext_data_repl_tdam where _FILE_NAME like 'gs://ext-iata-excl-data/2020/unzipped/FinalOutput2019m%'




sudo gunzip -k FinalOutput2020m*.csv.gz
gsutil -m cp   FinalOutput2020m*.csv gs://ext-iata-excl-data/2020/unzipped
#cloud shell - move file
gsutil mv -r gs://ext-iata-excl-data/2020/unzipped/* gs://ext-iata-excl-data/repl-tdam



# cannot use ext tbl this because must have column count of ext tbl defn

  Error while reading table: iata.ext_data, error message: CSV table references column position 41, but line starting at position:262859280 contains only 7 columns.

  filePrefix="FinalOutput_2020-01-01_w_2020-03-15_missing_tkts_Global.csv"
  gcsPath=gs://ext-iata-excl-data/2020/unzipped/
  gsutil cat -r 0-2000 $gcsPath$filePrefix


create or replace table iata.int_X1_repl_tdam as ( 
select ticket_id,ticketing_carrier,transaction_code,dt_of_issue,segment_id,ticket_document_amount,DOC_AMOUNT_TYPE_INDICATOR, FILE_SOURCE
from iata.int_X1_file_analysis 
LIMIT 0 )


# manual create ext table iata.ext_data_repl_tdam using json below
[
  {
    "mode": "NULLABLE",
    "name": "TICKET_ID",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "TICKETING_CARRIER",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "TRANSACTION_CODE",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "DT_OF_ISSUE",
    "type": "STRING"
  },
  {
    "mode": "NULLABLE",
    "name": "SEGMENT_ID",
    "type": "STRING"
  },
  {
    "name": "TICKET_DOCUMENT_AMOUNT",
    "type": "STRING"
  },
  {
    "name": "DOC_AMOUNT_TYPE_INDICATOR",
    "type": "STRING",
    "description": "indicates if TDAM is Regressed or Industry Average TDAM (possible values are REG or IND)"
  }
]


# NO missign tickets should be auto-covered by newTDAM
# OR for missing_tkts*
# insert into iata.int_X1_repl_tdam
# select ticket_id,ticketing_carrier,transaction_code,dt_of_issue,segment_id,ticket_document_amount,DOC_AMOUNT_TYPE_INDICATOR, _FILE_NAME as FILE_SOURCE
# from iata.ext_data


# Reconcile

select FILE_SOURCE, dt_of_issue, count(*)
from iata.int_X1_repl_tdam
group by 1,2
order by 2,1

and 

select FILE_SOURCE, dt_of_issue, count(*)
from iata.int_X1_file_analysis
where FILE_SOURCE like '%2020-02-03_w_2020-02-09%'
group by 1,2
order by 2,1



# Confirm monthly contains each weekly

with w as (
select ticket_id, segment_id
from iata.int_X1_repl_tdam
where FILE_SOURCE = 'gs://ext-iata-excl-data/2020/unzipped/FinalOutput_2020-02-03_w_2020-02-09_tdam_rev_Global.csv'
--ticket_id = '2003700000001103942'
--order by FILE_SOURCE
),

m as (
select ticket_id, segment_id
from iata.int_X1_repl_tdam
where FILE_SOURCE = 'gs://ext-iata-excl-data/2020/unzipped/FinalOutput2020m0202_tdam_rev_Global.csv'
--ticket_id = '2003700000001103942'
--order by FILE_SOURCE
)

select w.* 
from w
left join m on w.ticket_id = m.ticket_id and w.segment_id = m.segment_id
where m.ticket_id is null






