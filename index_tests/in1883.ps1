
1883 off 1837 off 1818

IN-1886-v5-airtyx-dash-table-deployment-
	1886 off Develop
0. generated DDL and optimised with partitioning and clustering key tables from datasets products_IN1139 and Airtycks_v5_research_dashboard
1. ran dag_zops_p_tables_deploy - passing in params '{"dset":"in1883"}' to create non-default dataset and deploy P tables
2. ran dag_zops_airtyx_dash_deploy - passing in params '{"dset":"in1883_airtyx"}' to create non-default dataset and deploy Airtyx Dashboard tables
3. ran dag_products_v5_0_0 - passing in params '{"dset":"in1883","dset_Airtycks_v5":"in1883_airtyx"}' to run that pipeline against non-default datasets
4. £0 cost
