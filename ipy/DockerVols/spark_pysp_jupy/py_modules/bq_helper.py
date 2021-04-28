from google.cloud import bigquery

class bqh:
    
    def __init__(self, proj_id, region, cred_fullpath = None):
        
        self.proj_id = proj_id
        self.region = region
        
        if cred_fullpath == None:
            self.client = bigquery.Client()
        else:
            self.client = bigquery.Client.from_service_account_json(cred_fullpath)


    # run_job is for big jobs where we don't want lots of data returned to client
    def run_job(self, job_sql):
        query_job = self.client.query(job_sql)


    # run_qry is for returning data to client
    def run_qry(self, qry_sql):
        query_job = self.client.query(qry_sql)
        #print("Reading table")
        results = query_job.result().to_dataframe()
        #print('Compiled the dataframe')
        #df_lines = len(results.index)
        #print('Processed {0} lines'.format(df_lines))
        return results