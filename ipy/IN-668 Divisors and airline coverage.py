
# coding: utf-8

# In[120]:


#if restarting the script, please run first the cell at the bottom (the functions)
#pip install --upgrade google-cloud-bigquery
import google.auth
from google.cloud import bigquery
import numpy as np
import pandas as pd
import datalab.storage as gcs


client = bigquery.Client()


# In[121]:


query = "SELECT * FROM `dashboard_production.QC_matching_rate_airline_dt_issue` "


# In[122]:


#print(query)
query_job = client.query(query,
        # Location must match that of the dataset(s) referenced in the query.
        location="EU",)  # API request - starts the query

new_table_result = query_job.result().to_dataframe()


# In[123]:


region_pair = list(new_table_result.region_pair.unique())


# In[124]:


results_DF = pd.DataFrame( )
for region in region_pair:
    tmp_DF = new_table_result[new_table_result["region_pair"] == region]
    airlines = list(tmp_DF.op_carrier.unique())
    
    for airline in airlines:
        tmp_DF_airline = tmp_DF[tmp_DF["op_carrier"] == airline]
        tmp_DF_airline["diff_matching"] = tmp_DF_airline["non_matched_rate"].diff()
        tmp_DF_airline
        results_DF = results_DF.append(tmp_DF_airline)
        print(airline)
    #print(airlines)


# In[125]:


results_DF["diff_matching"] = abs(results_DF["diff_matching"])


# In[126]:


results_DF[(results_DF["weight_in_region"]>0.2 ) &  (results_DF["diff_matching"]>0.2 ) &  (results_DF["non_matched_rate"]>0.5 )]


# # Computing the NA-NA benchmark with a divisor accounting for the drop of AA

# In[159]:


#A version of X7 excluding AA

x7_modified = "WITH  x6_modified AS(  SELECT    * EXCEPT(n_pkg,      price,      key_type),  IF    ((mkt_carrier LIKE \"%AA%\"      OR op_carrier LIKE \"%AA%\")      AND region_pair = \"North America-North America\",      NULL,      n_pkg) AS n_pkg,  IF    ((mkt_carrier LIKE \"%AA%\"      OR op_carrier LIKE \"%AA%\")      AND region_pair = \"North America-North America\",      NULL,      price) AS price,  IF    ((mkt_carrier LIKE \"%AA%\"      OR op_carrier LIKE \"%AA%\")      AND region_pair = \"North America-North America\",      NULL,      key_type) AS key_type,  FROM    `matching.X6`  WHERE    dt_of_issue > \"2010-02-15\"), x6 AS (  SELECT ticket_id,    ANY_VALUE(dt_of_issue) AS dt_of_issue,    ANY_VALUE(first_flight_date_utc) AS first_flight_date_utc,    ANY_VALUE(leadtime) AS leadtime,    ANY_VALUE(region_pair) AS region_pair,    ANY_VALUE(od_mile)*1.60934 AS od_km,    ANY_VALUE(nb_legs) AS nb_legs,    ANY_VALUE(sumP) AS sumP,    MIN(price*fx) AS price  FROM `x6_modified` it  LEFT JOIN `generic.EURUSD` eurusd  ON it.dt_of_issue = eurusd.date  WHERE first_flight_date_utc > '2010-10-01'  GROUP BY ticket_id),spot AS (  SELECT * FROM  `generic.spot_window_regions_ext`),fd_range AS (  SELECT    DATE_ADD(f_issue,INTERVAL max_leadtime DAY) AS min_fd,    DATE_ADD(l_issue, INTERVAL min_leadtime DAY) AS max_fd  FROM (    SELECT      MIN(dt_of_issue) AS f_issue, MAX(dt_of_issue) AS l_issue,      MIN(min_leadtime) AS min_leadtime, MAX(max_leadtime) AS max_leadtime    FROM x6, spot  )),filtered_x6 AS (  SELECT x6_minp.*  FROM (      SELECT *, EXTRACT(DAYOFWEEK FROM first_flight_date_utc) AS index_day      FROM x6,fd_range      WHERE first_flight_date_utc >= min_fd      AND first_flight_date_utc <= max_fd  ) x6_minp  INNER JOIN spot  ON x6_minp.region_pair = spot.region_pair  AND x6_minp.index_day = spot.index_day  WHERE leadtime >= min_leadtime  AND leadtime <= max_leadtime),index_nleg AS (  SELECT    I_ind.region_pair, I_ind. first_flight_date_utc,    iata_index, skytra_index,    iata_rpk, skytra_rpk,    iata_tickets, IFNULL(skytra_tickets,0) AS skytra_tickets,    IF(skytra_rpk IS NULL,0,iata_rpk) AS w_leg  FROM (    SELECT      region_pair, first_flight_date_utc, nb_legs,      SUM(sumP)/SUM(od_km) AS iata_index,      SUM(od_km) AS iata_rpk, COUNT(*) AS iata_tickets      FROM filtered_x6    GROUP BY region_pair,  first_flight_date_utc, nb_legs  ) AS I_ind  LEFT JOIN (    SELECT      region_pair,  first_flight_date_utc, nb_legs,      SUM(price)/SUM(od_km) As skytra_index,      SUM(od_km) AS skytra_rpk, COUNT(*) AS skytra_tickets    FROM filtered_x6    WHERE price IS NOT NULL    AND price > 0    GROUP BY region_pair,  first_flight_date_utc , nb_legs) AS S_ind ON S_ind.region_pair = I_ind.region_pair  AND S_ind.first_flight_date_utc = I_ind.first_flight_date_utc  AND S_ind.nb_legs = I_ind.nb_legs  ORDER BY I_ind.first_flight_date_utc, I_ind.region_pair)SELECT region_pair,  first_flight_date_utc AS first_flight_date,SUM(iata_rpk*iata_index)/SUM(iata_rpk) AS iata_index,SUM(w_leg*skytra_index)/SUM(w_leg) AS skytra_index,SUM(iata_rpk) AS iata_rpk,SUM(skytra_rpk) AS skytra_rpk,SUM(iata_tickets) AS iata_tickets,SUM(skytra_tickets) AS skytra_tickets,100.*SUM(skytra_tickets)/SUM(iata_tickets) AS skytra_coverage FROM index_nleg GROUP BY region_pair, first_flight_date_utc ORDER BY region_pair, first_flight_date"


# In[128]:


#Baseline version of X7, using all data
x7_baseline = "WITH  x6_modified AS(  SELECT    *   FROM    `matching.X6`  WHERE    dt_of_issue > \"2010-02-15\"), x6 AS (  SELECT ticket_id,    ANY_VALUE(dt_of_issue) AS dt_of_issue,    ANY_VALUE(first_flight_date_utc) AS first_flight_date_utc,    ANY_VALUE(leadtime) AS leadtime,    ANY_VALUE(region_pair) AS region_pair,    ANY_VALUE(od_mile)*1.60934 AS od_km,    ANY_VALUE(nb_legs) AS nb_legs,    ANY_VALUE(sumP) AS sumP,    MIN(price*fx) AS price  FROM `x6_modified` it  LEFT JOIN `generic.EURUSD` eurusd  ON it.dt_of_issue = eurusd.date  WHERE first_flight_date_utc > '2010-10-01'  GROUP BY ticket_id),spot AS (  SELECT * FROM  `generic.spot_window_regions_ext`),fd_range AS (  SELECT    DATE_ADD(f_issue,INTERVAL max_leadtime DAY) AS min_fd,    DATE_ADD(l_issue, INTERVAL min_leadtime DAY) AS max_fd  FROM (    SELECT      MIN(dt_of_issue) AS f_issue, MAX(dt_of_issue) AS l_issue,      MIN(min_leadtime) AS min_leadtime, MAX(max_leadtime) AS max_leadtime    FROM x6, spot  )),filtered_x6 AS (  SELECT x6_minp.*  FROM (      SELECT *, EXTRACT(DAYOFWEEK FROM first_flight_date_utc) AS index_day      FROM x6,fd_range      WHERE first_flight_date_utc >= min_fd      AND first_flight_date_utc <= max_fd  ) x6_minp  INNER JOIN spot  ON x6_minp.region_pair = spot.region_pair  AND x6_minp.index_day = spot.index_day  WHERE leadtime >= min_leadtime  AND leadtime <= max_leadtime),index_nleg AS (  SELECT    I_ind.region_pair, I_ind. first_flight_date_utc,    iata_index, skytra_index,    iata_rpk, skytra_rpk,    iata_tickets, IFNULL(skytra_tickets,0) AS skytra_tickets,    IF(skytra_rpk IS NULL,0,iata_rpk) AS w_leg  FROM (    SELECT      region_pair, first_flight_date_utc, nb_legs,      SUM(sumP)/SUM(od_km) AS iata_index,      SUM(od_km) AS iata_rpk, COUNT(*) AS iata_tickets      FROM filtered_x6    GROUP BY region_pair,  first_flight_date_utc, nb_legs  ) AS I_ind  LEFT JOIN (    SELECT      region_pair,  first_flight_date_utc, nb_legs,      SUM(price)/SUM(od_km) As skytra_index,      SUM(od_km) AS skytra_rpk, COUNT(*) AS skytra_tickets    FROM filtered_x6    WHERE price IS NOT NULL    AND price > 0    GROUP BY region_pair,  first_flight_date_utc , nb_legs) AS S_ind ON S_ind.region_pair = I_ind.region_pair  AND S_ind.first_flight_date_utc = I_ind.first_flight_date_utc  AND S_ind.nb_legs = I_ind.nb_legs  ORDER BY I_ind.first_flight_date_utc, I_ind.region_pair)SELECT region_pair,  first_flight_date_utc AS first_flight_date,SUM(iata_rpk*iata_index)/SUM(iata_rpk) AS iata_index,SUM(w_leg*skytra_index)/SUM(w_leg) AS skytra_index,SUM(iata_rpk) AS iata_rpk,SUM(skytra_rpk) AS skytra_rpk,SUM(iata_tickets) AS iata_tickets,SUM(skytra_tickets) AS skytra_tickets,100.*SUM(skytra_tickets)/SUM(iata_tickets) AS skytra_coverage FROM index_nleg GROUP BY region_pair, first_flight_date_utc ORDER BY region_pair, first_flight_date"


# In[161]:


#print(query)
query_job = client.query(x7_modified,
        # Location must match that of the dataset(s) referenced in the query.
        location="EU",)  # API request - starts the query

new_table_result = query_job.result().to_dataframe()


# In[162]:


X7_without_AA_DF = new_table_result


# In[163]:


X7_without_AA_DF.head()


# In[132]:


#print(query)
query_job = client.query(x7_baseline,
        # Location must match that of the dataset(s) referenced in the query.
        location="EU",)  # API request - starts the query

new_table_result = query_job.result().to_dataframe()
X7_baseline_DF = new_table_result


# In[133]:


#conputes the benchnark for every region pair in the full dataset
benchmark_baseline_DF = pd.DataFrame()
for region in list(X7_baseline_DF.region_pair.unique()):
    index_tmp = X7_baseline_DF[X7_baseline_DF["region_pair"] == region]
    index_tmp["benchmark"] = index_tmp["skytra_index"].rolling(window=28).mean()
    benchmark_baseline_DF = benchmark_baseline_DF.append(index_tmp)


# In[164]:


#conputes the benchnark for every region pair in the dataset without AA
benchmark_withouAA_DF = pd.DataFrame()
for region in list(X7_without_AA_DF.region_pair.unique()):
    index_tmp = X7_without_AA_DF[X7_without_AA_DF["region_pair"] == region]
    index_tmp["benchmark"] = index_tmp["skytra_index"].rolling(window=28).mean()
    benchmark_withouAA_DF = benchmark_withouAA_DF.append(index_tmp)


# In[187]:


##Putting the benchmark togeter
#before the 24th of Jan we use the baseline
final_benchmark_DF = benchmark_baseline_DF[pd.to_datetime(benchmark_baseline_DF.first_flight_date)< "2018-01-24"]

#for the second period after the 23rd of Jan we go to a world withou AA
#selecting the period for when we do not have AA, first filter the starting date
without_AA_tmp = benchmark_withouAA_DF[pd.to_datetime(benchmark_withouAA_DF.first_flight_date)> "2018-01-23"]
#filter the end date
without_AA_tmp = without_AA_tmp[pd.to_datetime(without_AA_tmp.first_flight_date)< "2019-04-14"]

#compute the divisor
before_data_event = benchmark_baseline_DF["benchmark"][(pd.to_datetime(benchmark_baseline_DF.first_flight_date) == "2018-01-23") & (benchmark_baseline_DF["region_pair"] == "North America-North America")]
after_data_event = benchmark_withouAA_DF["benchmark"][(pd.to_datetime(benchmark_withouAA_DF.first_flight_date) == "2018-01-23") & (benchmark_withouAA_DF["region_pair"] == "North America-North America")]
divisor = after_data_event/before_data_event

#applies the divisor
without_AA_tmp["benchmark"] = np.where(without_AA_tmp["region_pair"] == "North America-North America",
                                         without_AA_tmp["benchmark"] / float(divisor),
                                         without_AA_tmp["benchmark"])

final_benchmark_DF = final_benchmark_DF.append(without_AA_tmp)


# In[197]:


#bringing back AA data
#first compute the divisor

before_data_event = final_benchmark_DF["benchmark"][(pd.to_datetime(final_benchmark_DF.first_flight_date) == "2019-04-13") & (final_benchmark_DF["region_pair"] == "North America-North America")]
after_data_event = benchmark_baseline_DF["benchmark"][(pd.to_datetime(benchmark_baseline_DF.first_flight_date) == "2019-04-13") & (benchmark_baseline_DF["region_pair"] == "North America-North America")]
divisor = after_data_event/before_data_event

AA_back_tmp = benchmark_baseline_DF[pd.to_datetime(benchmark_baseline_DF.first_flight_date)> "2019-04-13"]

#applies the divisor
AA_back_tmp["benchmark"] = np.where(AA_back_tmp["region_pair"] == "North America-North America",
                                         AA_back_tmp["benchmark"] / float(divisor),
                                         AA_back_tmp["benchmark"])



final_benchmark_DF = final_benchmark_DF.append(AA_back_tmp)


# In[213]:


final_benchmark_DF


# In[215]:


import datalab.storage as gcs #v1.1.5
gcs.Bucket('paulo_jupyter_notebooks').item('benchmark_timeseries_data.csv').write_to(final_benchmark_DF.to_csv(),'text/csv')


# # testing that the divisor only changes for North America North America

# In[185]:


#computes the divisor
before_data_event = benchmark_baseline_DF[(pd.to_datetime(benchmark_baseline_DF.first_flight_date) == "2018-01-23")]
after_data_event = benchmark_withouAA_DF[(pd.to_datetime(benchmark_withouAA_DF.first_flight_date) == "2018-01-23") ]

#just showing the the NA-NA index is the only with a divisor different than 1
before_data_event[["region_pair", "benchmark"]]


# In[184]:


after_data_event[["region_pair", "benchmark"]]


# In[186]:


divisor

