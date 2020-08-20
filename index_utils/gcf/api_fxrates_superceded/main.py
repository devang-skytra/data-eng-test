
use http trigger and Operator to call GCF
https://airflow.readthedocs.io/en/latest/_api/airflow/providers/http/operators/http/index.html

Default AF http_default conn is http://www.google.com.

Either create a new Connection with HTTP Connection type or modify the http_default connection and change the host to https://us-central1-prj-sbe.cloudfunctions.net

Then update the endpoint field in your task to:

fxratesGet = SimpleHttpOperator(
        task_id= "fxrates_get",
        method='POST',
        http_conn_id='http_prj_sbe',
        endpoint='fxrates-http-get',
        data=({"schema": schema, "table": table}),
        headers={"Content-Type": "application/json"},
        xcom_push=False
    )
===========================================================================


gsutil cp data.csv 'gs://pd-fxrates/to/data.csv'

fxrates-http-get
"""
pd-fxrates-get-trg
gsutil cp f.csv 'gs://pd-fxrates-get-trg/f.csv'
gsutil cat 'gs://pd-fxrates/to/data.csv'
"""
-----------------------------------------

from forex_python.converter import CurrencyRates
from smart_open import open
from datetime import datetime, timedelta
import requests
import io
from io import StringIO
import os

b = 'gs://pd-fxrates/'
f = '/to/data.csv'
url_endpoint = 'http://www.bankofengland.co.uk/boeapps/iadb/fromshowcolumns.asp?csv.x=yes'
trg_f = 'f.csv'
day_offset = 1

def fx_get(request):
  
  yest = datetime.today().date() - timedelta(days = day_offset)
  s_yest = yest.strftime("%d/%m/%Y")
  s_dtfrom = yest.strftime("%d/%b/%Y")
  s_dtto = s_dtfrom
  
  #get our preferred rate easily using forex_python
  c = CurrencyRates()
  xe = c.get_rate('EUR', 'USD', yest)
  
  #Remainder of function is more complex backup rate from BOE
  #selects the series to be loaded
  payload = {
    'Datefrom'   : s_dtfrom,
    'Dateto'     : s_dtto,
    'SeriesCodes': 'XUDLERD',
    'CSVF'       : 'TN',
    'UsingCodes' : 'Y',
    'VPD'        : 'Y',
    'VFD'        : 'N'
  }
  #loads the time series
  response = requests.get(url_endpoint, params=payload)
  s_boe = io.BytesIO(response.content).read().decode('UTF-8')

  # BOE returns header + data row(s) but does not publish for non trading days (just header row) 
  #   so get last element returned [-1], test it later if float and fill with the previous value if needed
  s_boe_xe = s_boe.split(',')[-1]
  # csv read is necessary later anyway for appending the new line because GCS files immutable
  with open(b + f) as fin:
    csv = fin.read()
  
  # if not float, fill with the previous value
  # alt to below check is isinstance(yourNumber, numbers.Real)
  if s_boe_xe.replace('.','') .isnumeric():
    xe_boe = str(round(1 / float(s_boe_xe), 4))
  else:
    lines = csv.split('\n')
    xe_boe = lines[-2].split(',')[2]
  
  
  #Date,FX,BOE_FX
  l = ','.join([s_yest, str(xe), xe_boe + '\n'])

  with open(b + f, 'w') as fout:
    fout.write(csv + l)

  """
  try:
      float(s)
      return True
  except ValueError:
      return False
  """      
    
# Function dependencies, for example:
# package>=version
forex-python>=1.5
smart-open>=1.10.0

































