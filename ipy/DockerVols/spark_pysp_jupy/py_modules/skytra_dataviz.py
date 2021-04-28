import os
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib as mpl
from datetime import datetime
from google.cloud import bigquery
client = bigquery.Client()

sql_dir = os.path.join('..','py_modules','sql')

#-------------------------------------------------
# x7: benchmark 
#-------------------------------------------------
X7_types = {
        "date":"datetime64",
        "iata_rpk":"float32",
        "skytra_rpk":"float32",
        "iata_revenue":"float32",
        "skytra_revenue":"float32",
        "skytra_index":"float32",
        "iata_index":"float32",
        "skytra_coverage":"float32",
        "skytra_benchmark":"float32",
        "iata_benchmark":"float32",
        "index_correl":"float32",
        "benchmark_correl":"float32"
}

def build_benchmark_X7(table,corr_window=89,smooth_window=27,min_date='2020-01-01',region_pair='World-World',sql_dir=sql_dir,location="EU",qshow=False):
    """
    Take a X7 table as input
    return a smoothed benchmark version
    """
    
    with  open(os.path.join(sql_dir,"x7_benchmark.sql"), "r") as file_x7q:
        qx7 = file_x7q.read()
        
    benchmark_x7 =  qx7.format(x7=table,corr_window=corr_window,smooth_window= smooth_window,min_date=min_date,region_pair=region_pair)
    if qshow: 
        print(benchmark_x7)
    X7 = client.query(benchmark_x7,location=location).result().to_dataframe()

    return X7.astype(X7_types)

def plt_index_cov(df_x7,cov_lim=[70,95],rrpk_lim=[0.05,0.15],label=""):
    """
    Take a benchmark X7 input 
    Build a chart with:
    * Smoothed Coverage on the left
    * IATA and SKyTra indexes on the right
    """
    fig, axs = plt.subplots(figsize=(16,6),nrows=1, ncols=2, sharex=True)
    
    axs[0].set_ylabel("Skytra Coverage [%]")
    axs[0].set_title("X7 %s: Coverage" %label)
    axs[1].set_ylabel("RRPK [$/passenger/km]")
    axs[1].set_title("X7 %s: Indexes" %label)
    
    df_x7.plot(x='date',y= 'skytra_coverage',ax=axs[0],ylim=cov_lim)
    df_x7.plot(x='date',y= ['iata_benchmark','skytra_benchmark'],ax=axs[1],ylim=rrpk_lim)

def plt_corr(df_x7,ylim=[-1,1.],label=""):
    
    fig, ax = plt.subplots(figsize=(12,6))
    df_x7.plot(x='date',y= ['benchmark_correl','index_correl'],ax=ax,ylim=ylim)
    plt.ylabel("Correlation")
    plt.grid(which='major', axis='y')
    plt.title("X7 %s: Correlations" %label)    
    
def plt_raw_index_cov(df_x7,cov_lim=[70,95],rrpk_lim=[0.05,0.15],label=""):
    """
    Take a benchmark X7 input 
    Build a chart with:
    * Smoothed Coverage on the left
    * rws (noisy) daily IATA and SkyTra indexes on the right
    """
    fig, axs = plt.subplots(figsize=(16,6),nrows=1, ncols=2, sharex=True)
    
    axs[0].set_ylabel("Skytra Coverage [%]")
    axs[0].set_title("X7 %s: Coverage" %label)
    axs[1].set_ylabel("RRPK [$/passenger/km]")
    axs[1].set_title("X7 %s: Indexes" %label)
    
    df_x7.plot(x='date',y= 'skytra_coverage',ax=axs[0],ylim=cov_lim)
    df_x7.plot(x='date',y= ['iata_index','skytra_index'],ax=axs[1],ylim=rrpk_lim)    

def plt_totals(df_x7,label=""):
    """
    Take a benchmark X7 input 
    Build a chart with:
    * Smoothed RPK on the left
    * Smmothed revenue on the right
    """
    fig, axs = plt.subplots(figsize=(16,6),nrows=1, ncols=2, sharex=True)
    
    axs[0].set_ylabel("RPK [million km.passenger]")
    axs[0].set_title("X7 %s: RPK (smoothed over 28d)" %label)
    axs[1].set_ylabel("Revenue [million $]")
    axs[1].set_title("X7 %s: Revenue (smoothed over 28d)" %label)
    
    df_x7.plot(x='date',y= ['iata_rpk','skytra_rpk'],ax=axs[0])
    df_x7.plot(x='date',y= ['iata_revenue','skytra_revenue'],ax=axs[1])
    
#-------------------------------------------------
# x6
# expected input
# X6 with 1 row per ticket
#-------------------------------------------------
def build_rrpk_X6(table,year=2020,month=[2,4,6],smooth=15,op_carrier=None,op_discard=False,sql_dir=sql_dir,location="EU",qshow=False):
    """
    
    """
    with  open(os.path.join(sql_dir,"x6_rrpk_distrib.sql"), "r") as file_rrpk_x6q:
        rrpk_x6q = file_rrpk_x6q.read()
    
    month_str = ','.join(map(str,month))
    if op_carrier == None:
        op_filters = ""
    elif op_discard:
        op_filters = "AND op_carrier NOT LIKE '%" + \
            "%' AND op_carrier NOT LIKE '%".join(op_carrier) + \
            "%'"
    else:
        op_filters = "AND (op_carrier LIKE '%" + \
            "%' OR op_carrier LIKE '%".join(op_carrier) + \
            "%')"
    extra_filters = op_filters
        
    rrpk_x6 = rrpk_x6q.format(x6=table,month=month_str,year=year,smooth=smooth,extra_filters =extra_filters )
    if qshow: 
        print(rrpk_x6)
        
    return client.query(rrpk_x6,location=location).result().to_dataframe()

def plt_rrpk_X6(df_rrpk,year=2020,month=[2,4,6],ylim=[0.,1],xlim=[1e-5,10]):
    """
    
    """
    fig = plt.figure(figsize=(12,15))
    plt.subplots_adjust(hspace = 0.3)
    xtitle = "Ticket RRPK [$/km]"
    ytitle ='RRPK density'
    
    month_key = [datetime(year,m,15).strftime('%B %Y') for m in month[0:3]]
    
    m_dict = {}
    for k,v in zip(month_key,[311,312,313]):
        m_dict[k] = v
   
    for k,iax in m_dict.items():
        ax_m = plt.subplot(iax)
        ax_m.grid(which='major',axis='x')
        plt.xlabel(xtitle)
        plt.ylabel(ytitle)
        df_rrpk.loc[df_rrpk.month==k].plot(x='rrpk',y=['iata_sdens','kiwi_sdens'],ax=ax_m,logx=True, xlim=xlim,ylim=ylim,title=k,grid=True)
        
        

def build_pareto_op_carrier_X6(table,year=2020,month=[2,4,6],n_op=30,op_carrier=None,op_discard=False,sql_dir=sql_dir,location="EU",qshow=False):
    """
    
    """
    with  open(os.path.join(sql_dir,"x6_pareto_op_carrier.sql"), "r") as file_pareto_x6q:
        pareto_x6q = file_pareto_x6q.read()
    
    month_str = ','.join(map(str,month))
    if op_carrier == None:
        op_filters = ""
    elif op_discard:
        op_filters = "AND op_carrier NOT LIKE '%" + \
            "%' AND op_carrier NOT LIKE '%".join(op_carrier) + \
            "%'"
    else:
        op_filters = "AND (op_carrier LIKE '%" + \
            "%' OR op_carrier LIKE '%".join(op_carrier) + \
            "%')"
    extra_filters = op_filters
        
    pareto_x6 = pareto_x6q.format(x6=table,month=month_str,year=year,n_op=n_op,extra_filters =extra_filters )
    if qshow: 
        print(pareto_x6)
        
    return client.query(pareto_x6,location=location).result().to_dataframe()



def plt_pareto_op_carrier_X6(df_pareto,year=2020,month=[2,4,6],ylim=[0.,1],xlim=[1e-5,10]):
    """
    
    """
    
    ynorm = df_pareto[['month','total']].groupby('month').max().to_dict()["total"]
    fig = plt.figure(figsize=(12,15))
    plt.subplots_adjust(hspace = 0.3)
   
    month_key = [datetime(year,m,15).strftime('%B %Y') for m in month[0:3]]
    
    m_dict = {}
    for k,v in zip(month_key,[311,312,313]):
        m_dict[k] = v
   
    xtitle = "Operating Carrier"
    ytitle = "Number of umatched tickets"
    labels = ['Pareto','Count']

    k = month_key[0]
    #-----------------------------------------------------------
    pes = m_dict[k]
    nax1  =  ynorm[k]
    ax1 = plt.subplot(pes)
    ax1.set_ylim([0,nax1]); ax1.set_xlabel(xtitle); ax1.set_ylabel(ytitle)
    secax1 = ax1.secondary_yaxis("right",functions=(lambda x: 100.*x/nax1,lambda x: 0.01*x*nax1))
    secax1.set_ylabel(labels[0])
    par = df_pareto.loc[df_pareto.month==k].plot(x='op_carrier',y='cum',ax=ax1,color='red',label=labels[0])
    cnt = df_pareto.loc[df_pareto.month==k].plot.bar(x='op_carrier',y='n',ax=ax1,title=k,label=labels[1])


    k = month_key[1]
    #-----------------------------------------------------------
    pes = m_dict[k]
    nax2  =  ynorm[k]
    ax2 = plt.subplot(pes)
    ax2.set_ylim([0,nax2]); ax2.set_xlabel(xtitle); ax2.set_ylabel(ytitle)
    secax2 = ax2.secondary_yaxis("right",functions=(lambda x: 100.*x/nax2,lambda x: 0.01*x*nax2))
    secax2.set_ylabel(labels[0])
    par = df_pareto.loc[df_pareto.month==k].plot(x='op_carrier',y='cum',ax=ax2,color='red',label=labels[0])
    cnt = df_pareto.loc[df_pareto.month==k].plot.bar(x='op_carrier',y='n',ax=ax2,title=k,label=labels[1])

    k = month_key[2]
    #-----------------------------------------------------------
    pes = m_dict[k]
    nax3  =  ynorm[k]
    ax3 = plt.subplot(pes)
    ax3.set_ylim([0,nax3]); ax3.set_xlabel(xtitle); ax3.set_ylabel(ytitle)
    secax3 = ax3.secondary_yaxis("right",functions=(lambda x: 100.*x/nax3,lambda x: 0.01*x*nax3))
    secax3.set_ylabel(labels[0])
    par = df_pareto.loc[df_pareto.month==k].plot(x='op_carrier',y='cum',ax=ax3,color='red',label=labels[0])
    cnt = df_pareto.loc[df_pareto.month==k].plot.bar(x='op_carrier',y='n',ax=ax3,title=k,label=labels[1])
        
def build_cov_by_airline_X6(table,year=2020,month=[2,4,6],n_op=20,op_carrier=None,op_discard=False,sql_dir=sql_dir,location="EU",qshow=False):
    """
    
    """
    with  open(os.path.join(sql_dir,"x6_coverage_by_carrier.sql"), "r") as file_coverage_x6q:
        coverage_x6q = file_coverage_x6q.read()
    
    month_str = ','.join(map(str,month))
    if op_carrier == None:
        op_filters = ""
    elif op_discard:
        op_filters = "AND op_carrier NOT LIKE '%" + \
            "%' AND op_carrier NOT LIKE '%".join(op_carrier) + \
            "%'"
    else:
        op_filters = "AND (op_carrier LIKE '%" + \
            "%' OR op_carrier LIKE '%".join(op_carrier) + \
            "%')"
    extra_filters = op_filters
        
    coverage_x6 = coverage_x6q.format(x6=table,month=month_str,year=year,n_op=n_op,extra_filters =extra_filters )
    if qshow: 
        print(coverage_x6)
        
    return client.query(coverage_x6,location=location).result().to_dataframe()
        
def plt_cov_by_airline_X6(df_cov, year=2020,month=[2,4,6],n_op=30):
    """
    
    """
    month_key = [datetime(year,m,15).strftime('%B %Y') for m in month[0:3]]
    
    m_dict = {}
    for k,v in zip(month_key,[311,312,313]):
        m_dict[k] = v
    
    fig = plt.figure(figsize=(12,15))
    plt.subplots_adjust(hspace = 0.3)

    k = month_key[0]
    #-----------------------------------------------------------
    pes = m_dict[k]
    ax1 = plt.subplot(pes)
    ax1.set_ylim([0,100.])
    ax1.set_xlabel("Operating Carrier")
    ax1.set_ylabel('Covarage [%]')
    pc = df_cov.loc[df_cov.month==k].plot.bar(x='op_carrier',y=['coverage','market'],ax=ax1,title=k)

    k = month_key[1]
    #-----------------------------------------------------------
    pes = m_dict[k]
    ax2 = plt.subplot(pes)
    ax2.set_ylim([0,100.])
    ax2.set_xlabel("Operating Carrier")
    ax2.set_ylabel('Covarage [%]')
    pc = df_cov.loc[df_cov.month==k].plot.bar(x='op_carrier',y=['coverage','market'],ax=ax2,title=k)

    k = month_key[2]
    #-----------------------------------------------------------
    pes = m_dict[k]
    ax3 = plt.subplot(pes)
    ax3.set_ylim([0,100.])
    ax3.set_xlabel("Operating Carrier")
    ax3.set_ylabel('Covarage [%]')
    pc = df_cov.loc[df_cov.month==k].plot.bar(x='op_carrier',y=['coverage','market'],ax=ax3,title=k)
    
#-------------------------------------------------
# r7
#-------------------------------------------------
def build_r7_reenue_by_op_carrier(table,min_date='2020-01-01',max_date='2020-06-31',smooth=7,op_carrier=None,op_discard=False,sql_dir=sql_dir,location="EU",qshow=False)
    """
    
    """
    with  open(os.path.join(sql_dir,"r7_by_operating_carrier.sql"), "r") as file_rev_op_r7q:
        rev_op_r7q = file_rev_op_r7q.read()
    
    if op_carrier == None:
        op_filters = ""
    elif op_discard:
        op_filters = "AND op_carrier NOT IN ('" + "','".join(op_carrier)+"')"
    else:
        op_filters = "AND op_carrier IN ('" + "','".join(op_carrier)+"')"
    extra_filters = op_filters
    