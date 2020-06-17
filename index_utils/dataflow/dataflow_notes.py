

https://beam.apache.org/documentation/programming-guide/#windowing



Google BigQuery I/O connector
https://beam.apache.org/documentation/io/built-in/google-bigquery/


Dataflow and BigQuery Tips
https://polleyg.dev/posts/data-engineering-tips/



https://medium.com/@gruby/extracting-data-from-bigquery-table-to-parquet-into-gcs-using-cloud-dataflow-and-apache-beam-c63ce819b06a

good example of Best Practice outlined here...
https://cloud.google.com/dataflow/docs/guides/templates/creating-templates#python


beam.io.Read(beam.io.BigQuerySource(query="SELECT gameId, seasonId, seasonType, year FROM `bigquery-publicdata.baseball.games_post_wide`", use_standard_sql=True))



"""Beam code for extracting data from BQ to parquet"""

from __future__ import absolute_import

import argparse
import logging

import apache_beam as beam
import pyarrow
from apache_beam.options.pipeline_options import PipelineOptions
from google.cloud import bigquery


def get_parquet_schema(project, dataset, table):
    project = project
    dataset_id = dataset
    table_id = table
    data_type_mapping = {
        'STRING': pyarrow.string(),
        'BYTES': pyarrow.string(),
        'INTEGER': pyarrow.int64(),
        'FLOAT': pyarrow.float64(),
        'BOOLEAN': pyarrow.bool_(),
        'TIMESTAMP': pyarrow.timestamp(unit='s'),
        'DATE': pyarrow.date64(),
        'DATETIME': pyarrow.timestamp(unit='s'),
        # 'ARRAY': pyarrow.list_(),
        # 'RECORD': pyarrow.dictionary()
    }
    client = bigquery.Client(project=project)
    dataset_ref = client.dataset(dataset_id, project=project)
    table_ref = dataset_ref.table(table_id)
    table = client.get_table(table_ref)
    parquet_schema = pyarrow.schema([])
    for f in table.schema:
        parquet_schema = parquet_schema.append(pyarrow.field(f.name, data_type_mapping[f.field_type]))
    return parquet_schema


def run(argv=None):
    """Main entry point: defines and runs the BQ extraction pipeline"""
    parser = argparse.ArgumentParser()
    # custom arguments for bigquery SQL and GCS output location
    parser.add_argument('--bql',
                        dest='bql',
                        help='bigquery sql to extract req columns and rows.')
    parser.add_argument('--output',
                        dest='output',
                        help='gcs output location for parquet files.')
    known_args, pipeline_args = parser.parse_known_args(argv)
    bq_table_source = known_args.bql.split('`')[1].split('.')
    parquet_schema = get_parquet_schema(bq_table_source[0], bq_table_source[1], bq_table_source[2])
    options = PipelineOptions(pipeline_args)

    # instantiate a pipeline with all the pipeline option
    p = beam.Pipeline(options=options)
    # processing and structure of pipeline
    p \
    | 'Input: QueryTable' >> beam.io.Read(beam.io.BigQuerySource(
        query=known_args.bql,
        use_standard_sql=True)) \
    | 'Output: Export to Parquet' >> beam.io.parquetio.WriteToParquet(
        file_path_prefix=known_args.output,
        schema=parquet_schema,
        file_name_suffix='.parquet'
    )

    result = p.run()
    result.wait_until_finish()  # Makes job to display all the logs


if __name__ == '__main__':
    logging.getLogger().setLevel(logging.INFO)
    run()    

#And to execute the above beam code, one needs to run below
    
python toParq.py --bql "SELECT gameId, seasonId, seasonType, year FROM `bigquery-publicdata.baseball.games_post_wide`" \
                 --output gs://bq-to-parquet/beam_output/ \
                 --project project_name \
                 --job_name bigquerytoparquet \
                 --staging_location gs://bq-to-parquet/staging_location \
                 --temp_location gs://bq-to-parquet/temp_location \
                 --region europe-west1 \
                 --runner DataflowRunner     

                 
                 
                 
CLOUD COMPOSER -  https://cloud.google.com/composer/docs/how-to/using/using-dataflow-template-operator#airflow-ui

    start_template_job = DataflowTemplateOperator(
        # The task id of your job
        task_id="dataflow_operator_transform_csv_to_bq",
        # The name of the template that you're using.
        # Below is a list of all the templates you can use.
        # For versions in non-production environments, use the subfolder 'latest'
        # https://cloud.google.com/dataflow/docs/guides/templates/provided-batch#gcstexttobigquery
        template="gs://dataflow-templates/latest/GCS_Text_to_BigQuery",
        # Use the link above to specify the correct parameters for your template.
        parameters={
            "javascriptTextTransformFunctionName": "transformCSVtoJSON",
            "JSONPath": bucket_path + "/jsonSchema.json",
            "javascriptTextTransformGcsPath": bucket_path + "/transformCSVtoJSON.js",
            "inputFilePattern": bucket_path + "/inputFile.txt",
            "outputTable": project_id + ":average_weather.average_weather",
            "bigQueryLoadingTemporaryDirectory": bucket_path + "/tmp/",
        },
    )                 



