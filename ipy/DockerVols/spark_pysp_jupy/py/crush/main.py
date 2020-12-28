#!/usr/bin/python
"""
gcloud dataproc jobs submit pyspark gs://pysparkcode/crush/main.py --cluster=$cls --region=$reg --bucket=dp-staging-forfree 
# --jars=gs://spark-lib/bigquery/spark-bigquery-latest_2.12.jar

use '--' to separate arguments to your job from arguments to gcloud:
...main.py -- 7 2017-11-01
var = int(sys.argv[1]) if len(sys.argv) > 1 else 2
"""

import sys

# sys.argv[0] is program fullpath hence can check context ipy vs py
if 'ipy' in sys.argv[0]:
    """
    with open('./.vscode/launch.json', 'r') as config_file:
        config_dict = json.load(config_file)
    _arg = config_dict["configurations"][0]["linux"]["args"]
    """
    _arg = ['ipy','this is arg 1']
else:
    _arg = sys.argv

# print(_arg)
