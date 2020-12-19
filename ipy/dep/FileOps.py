import os
import glob
from datetime import datetime as dt

class fs:


    def getFileByPattern(self, pthRoot, dbs, objName, latest = True):
        if latest == True:
            fp = max(glob.iglob(os.path.join(pthRoot, dbs, 't') + f'/*{objName}_Create.sql'), key=os.path.getctime)
        return fp
        #files = [f for f in os.listdir(os.path.join(pthRoot, dbs)) if re.match(r'[0-9]+.*\.jpg', f)]
        #latest_file = max(list_of_files, key=os.path.getctime)
    
    def getStrFromFile(self, fp):
        with open(fp, 'r') as file:
            self.StrFromFile = file.read().replace('\n', ' ')
        return self.StrFromFile 

    def getLinesFromFile(self, fp):
        with open(fp, 'r') as file:
            self.LinesFromFile = file.read()
        return self.LinesFromFile 
		
    def uTest(self):
        l = [
            ['dbo.customer_address',   'dbo.customer_address', 'm', 'Merge'],
            ['dbo.customer_address',   'dbo.customer_address', 't', 'Create']
            ]
        for i in l:
            print( '' )

#ufs = fs()
#ufs.uTest()            