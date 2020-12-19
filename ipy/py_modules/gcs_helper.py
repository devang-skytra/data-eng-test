cred_path = "C:\\Users\\PaulDesmond\\OneDrive - SKYTRA LIMITED\\Automation\\gcp_keys\\"
from google.cloud import storage

class gcsh:
    
    def __init__(self, cred_code):
        if cred_code == 'default':
            self.client = storage.Client()
        else:
            d = {
            'pauldesmond': 'svc-pauldesmond-sdk-user.json',
            'devandtest':  'skytra-benchmark-devandtest-cloud-composer.json'
            }
            self.client = storage.Client.from_service_account_json(cred_path + d[cred_code])


    def bucket_get(self, bkt):
        return self.client.get_bucket(bkt)   


    def file_get(self, bkt, fle, decode):
        o_bkt = self.bucket_get(bkt)
        blob = o_bkt.blob(fle)
        csv = blob.download_as_string()
        # download_as_string returns bytes so decode to unicode string if requested
        if decode:
            return csv.decode()
        else:
            return csv


    def file_put(self, any_string, encode):
        # if encode requested > .encode('ascii')
        if encode:
            any_string = any_string.encode('ascii')

        blob.upload_from_string(any_string)
