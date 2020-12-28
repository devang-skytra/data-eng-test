## necessary import
import google.auth
from google.cloud import bigquery

# cred_devtest_gcc = 'C:\Users\PaulDesmond\OneDrive - SKYTRA LIMITED\Automation\gcp_keys\sky-devandtest-gcc.json'
cred_SDK = "C:\Users\PaulDesmond\OneDrive - SKYTRA LIMITED\Automation\gcp_keys\svc-pauldesmond-sdk-user.json"
client = bigquery.Client.from_service_account_json(cred_SDK)


#Module ASSUMES 3-part_ID for Tables ie prj.ds.tb
t1_split = []
t2_split = []

#   ASSUMES 3-part_ID ie prj.ds.tb
def not_valid_schema(table_1, table_2, uni_features, cat_features, con_features):
    """
    Verify that table table_1 and table_2 contians the columns as indicated in
    uni_features,cat_features,con_features
    If all is well return False
    Otherwise:
        print error, either missing table or missing colmuns
        then return True
    """
    
    col_1 = set(list(uni_features.keys()) + list(cat_features.keys()) + list(con_features.keys()))
    col_2 = set(list(uni_features.values()) + list(cat_features.values()) + list(con_features.values()))
    
    t1_split = table_1.split(".")
    t2_split = table_2.split(".")
    
    sq_1 = "SELECT column_name FROM %s.%s.INFORMATION_SCHEMA.COLUMNS WHERE table_name = '%s'" %(tuple(t1_split))
    sq_2 = "SELECT column_name FROM %s.%s.INFORMATION_SCHEMA.COLUMNS WHERE table_name = '%s'" %(tuple(t2_split))
    
    error = False
    try:
        t_col_1 = client.query(sq_1,location="EU",).result().to_dataframe()
    except:
        print('Missing table %r' %table_1)
        error = True
    try:
        t_col_2 = client.query(sq_2,location="EU",).result().to_dataframe()
    except:
        print('Missing table %r' %table_2)
        error = True
    if not error:
        if len(col_1 - set(t_col_1.column_name)) > 0:
            print("Missing column in %s" %table_1)
            print(col_1 - set(t_col_1.column_name))
            error = True
        if len(col_2 - set(t_col_2.column_name)) > 0:
            print("Missing column in %s" %table_2)
            print(col_2 - set(t_col_2.column_name))
            error = True
        
    return error



def test_dup1(table_1, uni_features, cat_features, con_features, p_filter = None):
    """
    Generate simple query removing and tracing duplicates for table 1
    where columns are kays in uni_features,cat_features,con_features
    """
    
     # Collect data from table 1 and remove duplication
    qp1 = "SELECT "+ ', '.join(list(uni_features.keys()))
    for feat in cat_features.keys():
        qp1 += ",\n\t ANY_VALUE(%s) AS %s_1" %(feat,feat)
    for feat in con_features.keys():
        qp1 += ",\n\t CAST(ANY_VALUE(%s) AS FLOAT64) AS %s_1" %(feat,feat)
    qp1 += ",\n\t COUNT(*) > 1 AS dup_1"
    qp1 += "\nFROM %s" %table_1
    if p_filter != None:
        qp1 += "\n"+p_filter
    qp1 += "\nGROUP BY " + ', '.join(list(uni_features.keys()))
    
    return qp1



def test_dup2(table_2, uni_features, cat_features, con_features, p_filter = None):
    """
    Generate simple query removing and tracing duplicates for table 1
    where columns are values in uni_features,cat_features,con_features
    """
    # Collect data from table 2 and remove duplication
    qp2 = "SELECT "+ ', '.join(list(uni_features.values()))
    for feat_k,feat_v in cat_features.items():
        qp2 += ",\n\t ANY_VALUE(%s) AS %s_2" %(feat_v,feat_k)
    for feat_k,feat_v in con_features.items():
        qp2 += ",\n\t CAST(ANY_VALUE(%s) AS FLOAT64) AS %s_2" %(feat_v,feat_k)   
    qp2 += ",\n\t COUNT(*) > 1 AS dup_2"
    qp2 += "\nFROM %s" %table_2
    if p_filter != None:
        qp2 += "\n"+ p_filter
    qp2 += "\nGROUP BY " + ', '.join(list(uni_features.keys()))
    
    return qp2 



def test_outer(uni_features, cat_features, con_features):
    """
    Generate simple query that use:
        * test_dup1 to remove duplicates of table 1
        * test_dup2 to remove duplicates of table 2
        * perform an outer join between the two
        * count missing rows in either table
        * count the occurences of values mismaatch between matching rows
    the result would be a single row with one test per column
    """
    
    # Prep missing row test
    q12 = "SELECT\n\tCOUNTIF(dup_1 IS NULL) AS missing_1, COUNTIF(dup_2 IS NULL) AS missing_2"
    # Prep duplicated value test
    q12 += ",\n\tCOUNTIF(dup_1) AS n_dup_1, COUNTIF(dup_2) AS n_dup_2"
    # Prep categorical feature comparison test
    for feat in cat_features.keys():
        q12 += ",\n\tCOUNTIF(%s_1 != %s_2) AS test_%s" % (feat,feat,feat)
    for feat in con_features.keys():
        q12 += ",\n\tCOUNTIF(ABS(%s_1 - %s_2)>1e-5) AS test_%s" % (feat,feat,feat)
    q12 += ",\n\tCOUNT(*) AS total"
    q12 += ",\n\tCOUNTIF(dup_1 IS NOT NULL AND dup_2 IS NOT NULL) AS common_total"
    q12 += "\nFROM q1 FULL OUTER JOIN q2"
    first = True
    for k,v in uni_features.items():
        if first:
            q12 += "\nON IFNULL(SAFE_CAST(q1.%s AS STRING),'0') = IFNULL(SAFE_CAST(q2.%s AS STRING),'0')" %(k,v)
            first = False
        else:
            q12 += "\nAND IFNULL(SAFE_CAST(q1.%s AS STRING),'0') = IFNULL(SAFE_CAST(q2.%s AS STRING),'0')" %(k,v)
            
    return q12



def build_test_query(table_1, table_2, uni_features, cat_features, con_features, p_filter = None):
    """
    Generate simple query that use:
        * test_dup1 to remove duplicates of table 1
        * test_dup2 to remove duplicates of table 2
        * test_outer to identify differece between tables
        * reformat the output to display ione test per row 
    """
    
    qp1 = test_dup1(table_1,uni_features,cat_features,con_features, p_filter = p_filter)
    qp2 = test_dup2(table_2,uni_features,cat_features,con_features, p_filter = p_filter)
    q12 = test_outer(uni_features,cat_features,con_features)
    
    
    table_caption_3part_1 = t1_split[0][-4:] + '.' t1_split[1]+ t1_split[2][:10]
    table_caption_3part_2 = t2_split[0][-4:] + '.' t2_split[1]+ t2_split[2][:10]
    
    jq = "WITH\nq1 AS (\n%s\n),\nq2 AS (\n%s\n),\nq12 AS (\n%s\n)\n"  %(qp1,qp2,q12)
    s12 = "FROM q12"
    tid = 1
    
    # display missing row test
    jq += "\nSELECT %d AS id, 'Missing rows from %s' AS test, missing_1 AS nb_errors, 100.*missing_1/ total AS per_error %s" %(tid,table_caption_3part_1,s12)
    jq += "\nUNION ALL"
    tid +=1
    jq += "\nSELECT %d AS id, 'Missing rows from %s' AS test, missing_2 AS nb_errors, 100.*missing_2/ total AS per_error %s" %(tid,table_caption_3part_2,s12)
    # display missing row test
    jq += "\nUNION ALL"
    tid +=1
    jq += "\nSELECT %d AS id, 'Duplicated rows from %s' AS test, n_dup_1 AS nb_errors, 100.*n_dup_1/ total AS per_error %s" %(tid,table_caption_3part_1,s12)
    jq += "\nUNION ALL"
    tid += 1
    jq += "\nSELECT %d AS id, 'Duplicated rows from %s' AS test, n_dup_2 AS nb_errors, 100.*n_dup_2/ total AS per_error %s" %(tid,table_caption_3part_2,s12)
    # categorical feature test 
    for feat in list(cat_features.keys()):
        jq += "\nUNION ALL"
        tid += 1
        jq += "\nSELECT %d AS id, 'Column %s differs' AS test, test_%s AS nb_errors, 100.*test_%s/ common_total AS per_error %s" %(tid,feat,feat,feat,s12)
    # continuous feature test 
    for feat in list(con_features.keys()):
        jq += "\nUNION ALL"
        tid += 1
        jq += "\nSELECT %d AS id, 'Column %s differs' AS test, test_%s AS nb_errors , 100.*test_%s/ common_total AS per_error %s" %(tid,feat,feat,feat,s12)
    jq += "\nORDER BY id"
    return jq



def test_table(table_1, table_2, uni_features, cat_features, con_features, p_filter = None):
    
    # Verify that the test can be performed
    if not_valid_schema(table_1,table_2,uni_features,cat_features,con_features):
        print("Table missing or schema inacurate, test cannot be performed")
        return 
    else: 
        print("Test underway...")
     
    # prepare test
    query = build_test_query(table_1,table_2,uni_features,cat_features,con_features, p_filter = p_filter)
    
    # run query 
    test_result = client.query(query,location="EU",).result().to_dataframe()
    
    if sum(test_result.nb_errors) ==0:
        print("Test passed")
    else:
        print("Test failed with %d errors" %sum(test_result.nb_errors))
    
    return test_result



def diff_outer(uni_features, cat_features, con_features):
    """
    Generate simple query that use:
        * test_dup1 to remove duplicates of table 1
        * test_dup2 to remove duplicates of table 2
        * perform an outer join between the two
        * count missing rows in either table
        * count the occurences of values mismaatch between matching rows
    the result would be a single row with one test per column
    """
    
    # Prep missing row test
    q12 = "SELECT q1." + ", q1.".join(list(uni_features.keys()))
    # Prep categorical feature comparison test
    for feat in list(cat_features.keys())+list(con_features.keys()):
        q12 += ", %s_1, %s_2" % (feat,feat)
    q12 += "\nFROM q1 INNER JOIN q2"
    first = True
    for k,v in uni_features.items():
        if first:
            q12 += "\nON IFNULL(SAFE_CAST(q1.%s AS STRING),'0') = IFNULL(SAFE_CAST(q2.%s AS STRING),'0')" %(k,v)
            first = False
        else:
            q12 += "\nAND IFNULL(SAFE_CAST(q1.%s AS STRING),'0') = IFNULL(SAFE_CAST(q2.%s AS STRING),'0')" %(k,v)
    first = True
    for feat in cat_features.keys():
        if first: 
            q12 += "\nWHERE %s_1 != %s_2" % (feat,feat)
            first = False
        else:
            q12 += "\nOR %s_1 != %s_2" % (feat,feat)
    for feat in con_features.keys():
        if first:
            q12 += "\nWHERE ABS(%s_1 - %s_2)>1e-5" % (feat,feat)
            first = False
        else:
            q12 += "\nOR ABS(%s_1 - %s_2)>1e-5" % (feat,feat)
    
    return q12



def show_diff(table_1, table_2, uni_features, cat_features, con_features, p_filter = None, sort = '', limit = 100):
    
    qp1 = test_dup1(table_1,uni_features,cat_features,con_features, p_filter = p_filter)
    qp2 = test_dup2(table_2,uni_features,cat_features,con_features, p_filter = p_filter)
    q12 = diff_outer(uni_features,cat_features,con_features)
    
    query = "WITH\nq1 AS (\n%s\n),\nq2 AS (\n%s\n)\n%s\n%s\nLIMIT %d" %(qp1,qp2,q12,sort,limit)
    
    return client.query(query,location="EU",).result().to_dataframe()