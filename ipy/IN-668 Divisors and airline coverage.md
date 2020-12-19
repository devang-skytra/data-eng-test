

```python
#if restarting the script, please run first the cell at the bottom (the functions)
#pip install --upgrade google-cloud-bigquery
import google.auth
from google.cloud import bigquery
import numpy as np
import pandas as pd
import datalab.storage as gcs


client = bigquery.Client()

```


```python
query = "SELECT * FROM `dashboard_production.QC_matching_rate_airline_dt_issue` "
```


```python
#print(query)
query_job = client.query(query,
        # Location must match that of the dataset(s) referenced in the query.
        location="EU",)  # API request - starts the query

new_table_result = query_job.result().to_dataframe()
```


```python
region_pair = list(new_table_result.region_pair.unique())
```


```python
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
```

    /opt/conda/anaconda/lib/python3.6/site-packages/ipykernel_launcher.py:8: SettingWithCopyWarning: 
    A value is trying to be set on a copy of a slice from a DataFrame.
    Try using .loc[row_indexer,col_indexer] = value instead
    
    See the caveats in the documentation: http://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html#returning-a-view-versus-a-copy
      


    KC
    BG
    DI
    LY
    GF
    AI
    IB
    SK
    MU
    EK
    GA
    DY
    BA
    WY
    PK
    MF
    TK
    FZ
    CZ
    KU
    AF
    3U
    AZ
    MH
    LH
    HU
    JL
    U6
    PR
    TN
    ET
    SU
    BR
    TR
    SQ
    KE
    9W
    BI
    CA
    RJ
    MS
    CI
    OZ
    EY
    EW
    QR
    SV
    HY
    NZ
    OS
    LO
    VN
    VS
    UL
    S7
    GS
    KL
    JD
    NH
    CX
    TG
    SN
    OK
    PS
    QF
    LX
    AY
    IZ
    WK
    ZI
    MT
    IG
    ZH
    UA
    DL
    DE
    FM
    OM
    AA
    TV
    DV
    AC
    HO
    G9
    BF
    J2
    H1
    J9
    KQ
    MK
    AH
    XY
    OD
    WB
    WW
    TP
    AM
    LA
    AS
    TS
    KX
    AG
    3M
    9V
    CM
    XL
    AC
    WQ
    PY
    AA
    LA
    4M
    UA
    AM
    AR
    SY
    EQ
    UP
    4O
    VW
    AF
    OB
    B6
    TA
    DL
    WS
    H1
    O6
    CA
    BW
    AD
    JJ
    AV
    G3
    WG
    D8
    BA
    DI
    KL
    IB
    7Q
    TP
    VR
    S3
    VX
    7N
    AT
    3S
    LH
    NZ
    BA
    AH
    IG
    IB
    AC
    SV
    TK
    AZ
    EK
    TU
    QR
    VR
    VS
    SN
    TP
    AT
    LX
    AF
    LH
    DL
    EY
    KL
    MS
    ET
    SA
    SU
    RJ
    KQ
    S4
    UA
    OS
    CX
    SS
    PS
    UX
    JU
    DY
    SQ
    TB
    TC
    CA
    KU
    LA
    WK
    QF
    LY
    CZ
    DE
    EW
    BF
    3U
    SE
    JJ
    SZ
    BT
    7W
    KC
    TK
    W2
    DV
    5N
    SU
    ZM
    A9
    U6
    PS
    LO
    B2
    7R
    R3
    YE
    UT
    9U
    HZ
    5F
    M9
    S7
    QR
    HY
    H1
    YC
    J2
    LH
    AY
    OS
    Y7
    FZ
    KK
    JU
    IO
    EO
    PC
    N4
    AF
    RM
    OK
    Z9
    WZ
    AZ
    YK
    RO
    KL
    A3
    FB
    DP
    OZ
    EL
    LX
    7J
    CZ
    D2
    KE
    8Q
    LY
    MJ
    G9
    JP
    SN
    IG
    J2
    SK
    SU
    SQ
    B2
    OK
    PS
    PC
    KM
    6H
    7W
    KL
    AY
    FB
    AZ
    A9
    5F
    SN
    LH
    U6
    JP
    W2
    OU
    EL
    TK
    BT
    H1
    LY
    S7
    YE
    JU
    9U
    EE
    BA
    A3
    IB
    OM
    KC
    OS
    QR
    ST
    HY
    TP
    CO
    YM
    AF
    CY
    LX
    LO
    UT
    RO
    QS
    VY
    ZI
    7R
    DP
    KK
    RJ
    RM
    IZ
    DV
    MJ
    EY
    AT
    TU
    WZ
    5N
    FZ
    ME
    M9
    SZ
    8Q
    EK
    R3
    OZ
    GF
    D4
    G9
    CA
    0B
    XQ
    AH
    IB
    SA
    TK
    DT
    AT
    TP
    AZ
    LH
    AF
    LA
    ET
    VR
    KL
    DL
    BA
    EK
    UX
    AC
    VS
    QR
    DE
    SU
    LX
    SS
    WK
    JJ
    UA
    OS
    IG
    ZI
    SE
    SN
    LH
    BA
    KL
    LX
    TK
    QR
    KE
    PS
    AF
    J2
    HY
    AY
    OS
    SU
    TP
    AZ
    LO
    CA
    OZ
    EY
    EK
    IB
    SK
    JU
    CZ
    AT
    HU
    MS
    JD
    R3
    IG
    JL
    MU
    3U
    TK
    KK
    SV
    PK
    CX
    EK
    J9
    IR
    XQ
    XY
    QR
    KU
    RJ
    LX
    EY
    A3
    FZ
    PC
    MS
    G9
    8Q
    H1
    ME
    KL
    J2
    6S
    WY
    GF
    R5
    RQ
    PS
    LH
    W2
    SU
    KC
    RO
    NP
    AI
    ET
    AF
    TU
    BA
    9P
    E5
    9U
    OS
    6E
    SU
    EK
    TP
    LX
    AZ
    TK
    LH
    IB
    KL
    AF
    QR
    BA
    H1
    AY
    ET
    AT
    ZI
    N4
    HU
    PS
    IG
    OS
    CZ
    E5
    A3
    WB
    LH
    XY
    NP
    TU
    PC
    RJ
    AT
    W2
    AF
    UJ
    ET
    ME
    KQ
    WY
    AH
    MS
    3O
    FZ
    H1
    J9
    TK
    NE
    KU
    EK
    GF
    SV
    EY
    R5
    G9
    B8
    QR
    HM
    8U
    AZ
    P4
    BJ
    LN
    KL
    3J
    RO
    DY
    PS
    BA
    UL
    VY
    SM
    D8
    TB
    OS
    9P
    WK
    VL
    LX
    ZI
    EW
    SU
    TK
    PC
    SV
    FZ
    UT
    GF
    SU
    9U
    J2
    LH
    QR
    B2
    SZ
    KK
    PS
    HY
    U6
    EY
    RJ
    A3
    EK
    8Q
    KC
    G9
    ME
    S7
    AF
    DV
    UH
    RO
    J9
    OS
    R5
    RQ
    H1
    WY
    XY
    MS
    KU
    BT
    AZ
    LO
    7R
    KL
    AY
    BA
    OK
    A9
    N4
    JU
    CZ
    QS
    W2
    YK
    CY
    LX
    AT
    CO
    DP
    OZ
    7W
    XQ
    ET
    IR
    RM
    FB
    9K
    VC
    WS
    JV
    B6
    J5
    P1
    AS
    LF
    4B
    8P
    AA
    MW
    J1
    TS
    UA
    DL
    9X
    9M
    PB
    CX
    3E
    PR
    PD
    HA
    KS
    SY
    5T
    ZK
    YN
    7Q
    3H
    7H
    AC
    3M
    7F
    AN
    WG
    4P
    XE
    H1
    KG
    4N
    X4
    QF
    F8
    TJ
    PJ
    AM
    K3
    O2
    UP
    YP
    4O
    WP
    VX
    4K
    CM
    VS
    LX
    4A
    SU
    ET
    KL
    AF
    AC
    QR
    AT
    BA
    TK
    EK
    LH
    AZ
    CZ
    ZI
    LX
    WK
    DE
    MS
    CZ
    UL
    SA
    MK
    KQ
    KU
    WB
    SV
    HM
    FZ
    TK
    WY
    EK
    G9
    QF
    GF
    AF
    QR
    SU
    CA
    BA
    SQ
    AH
    EY
    CX
    ET
    RJ
    SN
    LH
    IG
    KL
    UU
    3U
    PS
    MD
    AZ
    TC
    LX
    J9
    ZI
    IB
    EW
    DY
    XY
    AC
    AI
    OS
    OZ
    AT
    DL
    HU
    KE
    DT
    MU
    BA
    SQ
    AF
    J2
    KL
    PS
    EY
    TK
    KU
    LX
    SU
    RJ
    QR
    MS
    SV
    LH
    AC
    VS
    ET
    AZ
    OS
    EK
    AT
    MU
    AI
    CA
    PR
    TU
    LO
    CX
    DY
    EI
    SK
    CZ
    KQ
    AH
    AY
    KE
    JU
    WK
    PK
    OZ
    TB
    UA
    3U
    9W
    D8
    SQ
    OS
    DV
    JL
    G9
    JD
    AY
    IO
    OM
    MU
    HY
    PS
    HZ
    FZ
    J2
    VN
    CZ
    SU
    TK
    HU
    CA
    LX
    3U
    EK
    TG
    QR
    LH
    EY
    KE
    7C
    S7
    OZ
    KC
    GF
    GS
    LO
    Y7
    U6
    KL
    BA
    8L
    ZE
    MR
    BX
    WY
    AF
    SZ
    J9
    R3
    GJ
    AZ
    HX
    ZM
    H1
    KU
    HO
    RJ
    UT
    MS
    EU
    FM
    OK
    IB
    N4
    SN
    XY
    UQ
    TW
    G5
    RQ
    7J
    EO
    ET
    SK
    SN
    2J
    5H
    KP
    FN
    AF
    ET
    TP
    TU
    MK
    5Z
    NP
    FA
    EK
    SV
    MS
    HF
    KQ
    H1
    TK
    QR
    L6
    EY
    MN
    SW
    JE
    AT
    BP
    RJ
    WB
    W2
    AH
    UU
    MD
    PW
    TM
    HM
    SA
    VL
    P0
    AZ
    DT
    BA
    UG
    AW
    P4
    LH
    8U
    3O
    LN
    TC
    UM
    HC
    JM
    WY
    VR
    G9
    QC
    NT
    IB
    XY
    B5
    KL
    E5
    C2
    BJ
    KM
    3J
    B8
    A3
    FZ
    SM
    VY
    KT
    ZI
    SS
    UJ
    S9
    IG
    HG
    EW
    GF
    ME
    E7
    3B
    TZ
    LX
    VS
    TB
    KU
    HU
    KE
    AI
    AZ
    EY
    AA
    TK
    VS
    CA
    MU
    DL
    SU
    TN
    OZ
    PS
    NZ
    AC
    AF
    FJ
    HA
    SV
    LX
    UA
    CZ
    HX
    CX
    BA
    9W
    JD
    PR
    NH
    MF
    JL
    LH
    BF
    IB
    BR
    3U
    QR
    QF
    EK
    CI
    AY
    KL
    ET
    SQ
    AM
    VA
    PK
    D7
    IG
    LJ
    TR
    MS
    JQ
    ID
    GA
    SN
    DI
    OS
    DY
    KQ
    LO
    RJ
    HY
    LY
    LA
    WK
    SA
    SK
    J2
    MT
    WW
    TP
    ET
    EW
    RJ
    SK
    KK
    XG
    PC
    ME
    EY
    AZ
    QR
    EK
    MS
    OS
    KU
    QS
    GF
    AF
    BA
    VS
    PK
    LH
    ZI
    LX
    AT
    JU
    AY
    A3
    XY
    ST
    FZ
    MT
    KL
    PS
    CY
    D8
    SV
    TK
    8Q
    DE
    SU
    CO
    XQ
    WY
    BI
    LO
    WK
    RO
    TB
    TU
    BT
    DY
    VY
    ZB
    G9
    OK
    TO
    AI
    J2
    EI
    GM
    B2
    AH
    9U
    IR
    W2
    9W
    HY
    HV
    J9
    H1
    BJ
    SN
    FB
    LG
    KQ
    3O
    KC
    E5
    4U
    QF
    S7
    WB
    OR
    BM
    IB
    U6
    LA
    JY
    AR
    BA
    AD
    AV
    TX
    W4
    UP
    BB
    7M
    KL
    XL
    AA
    CM
    W2
    ET
    TA
    2Z
    PY
    4O
    5U
    EK
    G3
    UA
    O6
    WM
    H2
    TK
    B6
    2M
    LI
    QR
    Z8
    9V
    H1
    A0
    3S
    AG
    9N
    KX
    AF
    AM
    2I
    QL
    OB
    P9
    DE
    7I
    VW
    9K
    BW
    OY
    CC
    EQ
    D8
    DL
    UX
    DN
    ZP
    TJ
    Z7
    3M
    AC
    8W
    5G
    VS
    V6
    IB
    EB
    LR
    WS
    CU
    GP
    R7
    7N
    PZ
    JJ
    A1
    SS
    LW
    SY
    TP
    AZ
    LH
    QR
    EK
    A3
    TK
    PC
    PS
    EY
    AF
    FZ
    OS
    RJ
    MS
    AT
    TP
    SU
    SN
    GF
    WY
    ET
    KL
    QS
    LX
    G9
    VY
    IB
    BA
    KM
    AH
    ZI
    JU
    ME
    RO
    TU
    SM
    IG
    KU
    SV
    BJ
    XY
    J9
    TK
    AA
    KL
    AZ
    NZ
    DL
    LH
    IB
    SA
    ET
    CZ
    SU
    QR
    EK
    LA
    AC
    BA
    UA
    AF
    HU
    CA
    QF
    NH
    AM
    AY
    LX
    TN
    ZI
    VS
    DI
    EW
    WK
    AT
    KE
    MT
    CX
    DE
    OS
    AY
    PS
    QS
    XG
    EK
    WW
    WK
    AZ
    UX
    OU
    IZ
    TK
    GR
    BT
    LG
    2N
    NT
    DY
    SU
    BM
    YM
    BE
    0B
    JU
    EW
    SK
    WX
    TB
    IG
    RC
    DE
    V7
    LH
    IB
    JP
    CY
    KL
    EI
    TO
    LX
    KK
    SP
    A3
    CE
    WA
    B2
    AF
    TP
    PC
    NY
    I2
    WF
    EL
    HU
    9U
    OS
    TF
    OA
    MT
    T7
    LM
    ZI
    9B
    S4
    EN
    SX
    LO
    A2
    ET
    RJ
    6H
    D8
    CO
    XK
    RO
    W2
    FI
    A5
    SE
    GQ
    VY
    H1
    KM
    LA
    OK
    SN
    ST
    FB
    LY
    GM
    BA
    BV
    U8
    3U
    C3
    2L
    6I
    TU
    PE
    HV
    DX
    MS
    VS
    2B
    HR
    VK
    PK
    5O
    PM
    E9
    HP
    QM
    ME
    A9
    PN
    S7
    GL
    5W
    GP
    AH
    J2
    AT
    XQ
    WP
    AP
    T3
    CA
    F7
    PU
    4U
    HG
    WB
    IS
    AB
    5F
    QR
    FZ
    KE
    U6
    BJ
    GF
    8H
    DW
    KU
    PR
    UL
    BS
    H9
    CA
    WY
    XY
    J9
    OZ
    SU
    PK
    FZ
    BG
    EK
    GF
    G9
    HY
    RA
    IX
    9W
    SV
    PS
    EY
    BI
    TG
    CX
    RJ
    MU
    KC
    CZ
    3U
    KE
    MH
    MS
    GA
    RX
    QR
    TK
    AI
    SQ
    ET
    LH
    RQ
    H1
    J2
    TR
    6S
    U6
    LO
    AF
    UK
    KL
    S7
    6E
    BA
    AY
    D7
    AZ
    OS
    IR
    QF
    OD
    HU
    AH
    UT
    WK
    TU
    VR
    SW
    TB
    EY
    SS
    PC
    IG
    NT
    UG
    WB
    KM
    QR
    ZI
    IB
    AZ
    AH
    DT
    TK
    SU
    BA
    AF
    UX
    AT
    A3
    YU
    ET
    KL
    ST
    VY
    PS
    WY
    FZ
    MS
    SV
    WK
    BJ
    RJ
    SE
    MT
    OS
    SA
    QS
    BF
    TO
    TP
    MK
    MD
    SN
    3O
    4D
    EK
    5O
    GF
    VS
    KQ
    LH
    DE
    LX
    BV
    ME
    LG
    E5
    L6
    HC
    LY
    UU
    DY
    EW
    8F
    RO
    S4
    OR
    JU
    D8
    XG
    W2
    GM
    C2
    SM
    HV
    KU
    HM
    G9
    CX
    E9
    XY
    V7
    H1
    HG
    4U
    VL
    2J
    UL
    VS
    PY
    BA
    SS
    TP
    AZ
    KL
    EB
    LA
    OR
    EW
    AF
    AM
    TK
    AV
    AD
    CA
    IB
    DL
    WK
    BV
    LX
    E9
    PU
    DE
    AR
    AT
    LH
    WS
    SE
    ET
    AC
    UX
    DI
    IG
    TB
    EK
    TX
    UA
    AA
    VR
    OB
    LV
    JJ
    AY
    ZI
    SU
    DT
    QR
    MT
    SA
    6O
    KF
    OS
    H1
    CM
    CU
    I2
    CI
    ZE
    G5
    PN
    RJ
    ZH
    GK
    QZ
    HX
    GJ
    NH
    9I
    NF
    CX
    MI
    AK
    BI
    RA
    RY
    VA
    JD
    FJ
    NU
    BD
    RX
    TL
    TW
    LT
    QR
    7C
    KE
    WE
    XJ
    JG
    9W
    HO
    UO
    NZ
    UQ
    8L
    IT
    B7
    ID
    GY
    FE
    VN
    JR
    BA
    GT
    GX
    QV
    MF
    Z2
    UK
    MU
    FY
    VJ
    AI
    DR
    8M
    UL
    LJ
    H1
    LA
    PR
    BK
    EU
    TR
    A6
    BX
    PK
    OD
    BG
    K6
    VT
    CA
    NS
    FU
    3K
    KY
    PX
    UA
    PG
    U6
    QD
    CN
    EK
    CZ
    KN
    QF
    FZ
    DZ
    5J
    SQ
    CG
    QW
    OM
    SB
    JQ
    OQ
    K7
    HU
    GS
    Y8
    FD
    OZ
    KA
    FM
    KQ
    SL
    BS
    3U
    S2
    KL
    BL
    EY
    MH
    AE
    9H
    RS
    IX
    ET
    JL
    2P
    GA
    TV
    BR
    WY
    TG
    XW
    UB
    NX
    SC
    TN
    MR
    LQ
    D7
    DL
    H9
    XT
    IE
    ZL
    W2
    KC
    7G
    S7
    MS
    ZA
    OL
    FP
    HA
    WB
    KR
    MK
    3C
    9D
    DD
    SV
    SU
    HY
    I5
    DJ
    TK
    YJ
    GZ
    DG
    G9
    GF
    RW
    JT
    KU
    FC
    ZM
    TN
    S4
    AA
    PS
    EW
    DL
    OR
    ET
    SU
    H1
    SS
    FI
    IG
    AC
    LH
    KL
    TS
    WK
    OS
    MT
    EI
    JU
    SK
    VS
    BF
    IB
    UA
    LX
    AZ
    TB
    DE
    DY
    DI
    LO
    9W
    D8
    EK
    AF
    TP
    WS
    SN
    WW
    AT
    AI
    NZ
    UX
    SE
    LY
    AY
    TK
    BA
    MS
    SQ
    RJ
    AM
    LV
    QR
    AH
    CA
    J2
    KE
    TU
    OZ
    B0
    TR
    AV
    HU
    CX
    SV
    EY
    MU
    HY
    PK
    NH
    CI
    JL
    3U
    BR
    CZ
    PJ
    GA
    JJ



```python
results_DF["diff_matching"] = abs(results_DF["diff_matching"])
```


```python
results_DF[(results_DF["weight_in_region"]>0.2 ) &  (results_DF["diff_matching"]>0.2 ) &  (results_DF["non_matched_rate"]>0.5 )]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>region_pair</th>
      <th>op_carrier</th>
      <th>dt_of_issue</th>
      <th>unmatched</th>
      <th>tickets</th>
      <th>tickets_region</th>
      <th>non_matched_rate</th>
      <th>weight_in_region</th>
      <th>diff_matching</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>4709</th>
      <td>Latin America-North America</td>
      <td>AA</td>
      <td>2018-05-14</td>
      <td>16077</td>
      <td>16774</td>
      <td>50684</td>
      <td>0.958448</td>
      <td>0.330953</td>
      <td>0.870919</td>
    </tr>
    <tr>
      <th>7972</th>
      <td>Latin America-North America</td>
      <td>AA</td>
      <td>2018-05-15</td>
      <td>18122</td>
      <td>18935</td>
      <td>57006</td>
      <td>0.957064</td>
      <td>0.332158</td>
      <td>0.877428</td>
    </tr>
    <tr>
      <th>9290</th>
      <td>Latin America-North America</td>
      <td>AA</td>
      <td>2019-01-26</td>
      <td>5008</td>
      <td>9654</td>
      <td>36239</td>
      <td>0.518749</td>
      <td>0.266398</td>
      <td>0.438315</td>
    </tr>
    <tr>
      <th>11588</th>
      <td>Latin America-North America</td>
      <td>AA</td>
      <td>2018-05-16</td>
      <td>17579</td>
      <td>18401</td>
      <td>55729</td>
      <td>0.955329</td>
      <td>0.330187</td>
      <td>0.880039</td>
    </tr>
    <tr>
      <th>12887</th>
      <td>Latin America-North America</td>
      <td>AA</td>
      <td>2019-01-27</td>
      <td>4577</td>
      <td>9115</td>
      <td>34009</td>
      <td>0.502139</td>
      <td>0.268017</td>
      <td>0.453189</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>783339</th>
      <td>Africa-Africa</td>
      <td>MS</td>
      <td>2018-03-25</td>
      <td>1657</td>
      <td>1726</td>
      <td>7784</td>
      <td>0.960023</td>
      <td>0.221737</td>
      <td>0.834522</td>
    </tr>
    <tr>
      <th>808023</th>
      <td>Africa-Africa</td>
      <td>MS</td>
      <td>2018-04-01</td>
      <td>1624</td>
      <td>1665</td>
      <td>7198</td>
      <td>0.975375</td>
      <td>0.231314</td>
      <td>0.918638</td>
    </tr>
    <tr>
      <th>833997</th>
      <td>Africa-Africa</td>
      <td>MS</td>
      <td>2018-04-08</td>
      <td>1283</td>
      <td>1343</td>
      <td>6325</td>
      <td>0.955324</td>
      <td>0.212332</td>
      <td>0.893090</td>
    </tr>
    <tr>
      <th>89085</th>
      <td>Africa-CIS</td>
      <td>TU</td>
      <td>2018-06-07</td>
      <td>334</td>
      <td>336</td>
      <td>1281</td>
      <td>0.994048</td>
      <td>0.262295</td>
      <td>0.660714</td>
    </tr>
    <tr>
      <th>553179</th>
      <td>Asia/Pacific-Middle East</td>
      <td>SV</td>
      <td>2019-06-15</td>
      <td>5482</td>
      <td>9883</td>
      <td>44223</td>
      <td>0.554690</td>
      <td>0.223481</td>
      <td>0.444279</td>
    </tr>
  </tbody>
</table>
<p>1114 rows × 9 columns</p>
</div>



# Computing the NA-NA benchmark with a divisor accounting for the drop of AA


```python
#A version of X7 excluding AA

x7_modified = "WITH\
  x6_modified AS(\
  SELECT\
    * EXCEPT(n_pkg,\
      price,\
      key_type),\
  IF\
    ((mkt_carrier LIKE \"%AA%\"\
      OR op_carrier LIKE \"%AA%\")\
      AND region_pair = \"North America-North America\",\
      NULL,\
      n_pkg) AS n_pkg,\
  IF\
    ((mkt_carrier LIKE \"%AA%\"\
      OR op_carrier LIKE \"%AA%\")\
      AND region_pair = \"North America-North America\",\
      NULL,\
      price) AS price,\
  IF\
    ((mkt_carrier LIKE \"%AA%\"\
      OR op_carrier LIKE \"%AA%\")\
      AND region_pair = \"North America-North America\",\
      NULL,\
      key_type) AS key_type,\
  FROM\
    `matching.X6`\
  WHERE\
    dt_of_issue > \"2010-02-15\"), \
x6 AS (\
  SELECT ticket_id,\
    ANY_VALUE(dt_of_issue) AS dt_of_issue,\
    ANY_VALUE(first_flight_date_utc) AS first_flight_date_utc,\
    ANY_VALUE(leadtime) AS leadtime,\
    ANY_VALUE(region_pair) AS region_pair,\
    ANY_VALUE(od_mile)*1.60934 AS od_km,\
    ANY_VALUE(nb_legs) AS nb_legs,\
    ANY_VALUE(sumP) AS sumP,\
    MIN(price*fx) AS price\
  FROM `x6_modified` it\
  LEFT JOIN `generic.EURUSD` eurusd\
  ON it.dt_of_issue = eurusd.date\
  WHERE first_flight_date_utc > '2010-10-01'\
  GROUP BY ticket_id\
),\
spot AS (\
  SELECT * FROM  `generic.spot_window_regions_ext`\
),\
fd_range AS (\
  SELECT\
    DATE_ADD(f_issue,INTERVAL max_leadtime DAY) AS min_fd,\
    DATE_ADD(l_issue, INTERVAL min_leadtime DAY) AS max_fd\
  FROM (\
    SELECT\
      MIN(dt_of_issue) AS f_issue, MAX(dt_of_issue) AS l_issue,\
      MIN(min_leadtime) AS min_leadtime, MAX(max_leadtime) AS max_leadtime\
    FROM x6, spot\
  )\
),\
filtered_x6 AS (\
  SELECT x6_minp.*\
  FROM (\
      SELECT *, EXTRACT(DAYOFWEEK FROM first_flight_date_utc) AS index_day\
      FROM x6,fd_range\
      WHERE first_flight_date_utc >= min_fd\
      AND first_flight_date_utc <= max_fd\
  ) x6_minp\
  INNER JOIN spot\
  ON x6_minp.region_pair = spot.region_pair\
  AND x6_minp.index_day = spot.index_day\
  WHERE leadtime >= min_leadtime\
  AND leadtime <= max_leadtime\
),\
index_nleg AS (\
  SELECT\
    I_ind.region_pair, I_ind. first_flight_date_utc,\
    iata_index, skytra_index,\
    iata_rpk, skytra_rpk,\
    iata_tickets, IFNULL(skytra_tickets,0) AS skytra_tickets,\
    IF(skytra_rpk IS NULL,0,iata_rpk) AS w_leg\
  FROM (\
    SELECT\
      region_pair, first_flight_date_utc, nb_legs,\
      SUM(sumP)/SUM(od_km) AS iata_index,\
      SUM(od_km) AS iata_rpk, COUNT(*) AS iata_tickets\
      FROM filtered_x6\
    GROUP BY region_pair,  first_flight_date_utc, nb_legs\
  ) AS I_ind\
  LEFT JOIN (\
    SELECT\
      region_pair,  first_flight_date_utc, nb_legs,\
      SUM(price)/SUM(od_km) As skytra_index,\
      SUM(od_km) AS skytra_rpk, COUNT(*) AS skytra_tickets\
    FROM filtered_x6\
    WHERE price IS NOT NULL\
    AND price > 0\
    GROUP BY region_pair,  first_flight_date_utc , nb_legs) AS S_ind ON S_ind.region_pair = I_ind.region_pair\
  AND S_ind.first_flight_date_utc = I_ind.first_flight_date_utc\
  AND S_ind.nb_legs = I_ind.nb_legs\
  ORDER BY I_ind.first_flight_date_utc, I_ind.region_pair\
)\
SELECT \
region_pair,  first_flight_date_utc AS first_flight_date,\
SUM(iata_rpk*iata_index)/SUM(iata_rpk) AS iata_index,\
SUM(w_leg*skytra_index)/SUM(w_leg) AS skytra_index,\
SUM(iata_rpk) AS iata_rpk,\
SUM(skytra_rpk) AS skytra_rpk,\
SUM(iata_tickets) AS iata_tickets,\
SUM(skytra_tickets) AS skytra_tickets,\
100.*SUM(skytra_tickets)/SUM(iata_tickets) AS skytra_coverage \
FROM index_nleg \
GROUP BY region_pair, first_flight_date_utc \
ORDER BY region_pair, first_flight_date"
```


```python
#Baseline version of X7, using all data
x7_baseline = "WITH\
  x6_modified AS(\
  SELECT\
    * \
  FROM\
    `matching.X6`\
  WHERE\
    dt_of_issue > \"2010-02-15\"), \
x6 AS (\
  SELECT ticket_id,\
    ANY_VALUE(dt_of_issue) AS dt_of_issue,\
    ANY_VALUE(first_flight_date_utc) AS first_flight_date_utc,\
    ANY_VALUE(leadtime) AS leadtime,\
    ANY_VALUE(region_pair) AS region_pair,\
    ANY_VALUE(od_mile)*1.60934 AS od_km,\
    ANY_VALUE(nb_legs) AS nb_legs,\
    ANY_VALUE(sumP) AS sumP,\
    MIN(price*fx) AS price\
  FROM `x6_modified` it\
  LEFT JOIN `generic.EURUSD` eurusd\
  ON it.dt_of_issue = eurusd.date\
  WHERE first_flight_date_utc > '2010-10-01'\
  GROUP BY ticket_id\
),\
spot AS (\
  SELECT * FROM  `generic.spot_window_regions_ext`\
),\
fd_range AS (\
  SELECT\
    DATE_ADD(f_issue,INTERVAL max_leadtime DAY) AS min_fd,\
    DATE_ADD(l_issue, INTERVAL min_leadtime DAY) AS max_fd\
  FROM (\
    SELECT\
      MIN(dt_of_issue) AS f_issue, MAX(dt_of_issue) AS l_issue,\
      MIN(min_leadtime) AS min_leadtime, MAX(max_leadtime) AS max_leadtime\
    FROM x6, spot\
  )\
),\
filtered_x6 AS (\
  SELECT x6_minp.*\
  FROM (\
      SELECT *, EXTRACT(DAYOFWEEK FROM first_flight_date_utc) AS index_day\
      FROM x6,fd_range\
      WHERE first_flight_date_utc >= min_fd\
      AND first_flight_date_utc <= max_fd\
  ) x6_minp\
  INNER JOIN spot\
  ON x6_minp.region_pair = spot.region_pair\
  AND x6_minp.index_day = spot.index_day\
  WHERE leadtime >= min_leadtime\
  AND leadtime <= max_leadtime\
),\
index_nleg AS (\
  SELECT\
    I_ind.region_pair, I_ind. first_flight_date_utc,\
    iata_index, skytra_index,\
    iata_rpk, skytra_rpk,\
    iata_tickets, IFNULL(skytra_tickets,0) AS skytra_tickets,\
    IF(skytra_rpk IS NULL,0,iata_rpk) AS w_leg\
  FROM (\
    SELECT\
      region_pair, first_flight_date_utc, nb_legs,\
      SUM(sumP)/SUM(od_km) AS iata_index,\
      SUM(od_km) AS iata_rpk, COUNT(*) AS iata_tickets\
      FROM filtered_x6\
    GROUP BY region_pair,  first_flight_date_utc, nb_legs\
  ) AS I_ind\
  LEFT JOIN (\
    SELECT\
      region_pair,  first_flight_date_utc, nb_legs,\
      SUM(price)/SUM(od_km) As skytra_index,\
      SUM(od_km) AS skytra_rpk, COUNT(*) AS skytra_tickets\
    FROM filtered_x6\
    WHERE price IS NOT NULL\
    AND price > 0\
    GROUP BY region_pair,  first_flight_date_utc , nb_legs) AS S_ind ON S_ind.region_pair = I_ind.region_pair\
  AND S_ind.first_flight_date_utc = I_ind.first_flight_date_utc\
  AND S_ind.nb_legs = I_ind.nb_legs\
  ORDER BY I_ind.first_flight_date_utc, I_ind.region_pair\
)\
SELECT \
region_pair,  first_flight_date_utc AS first_flight_date,\
SUM(iata_rpk*iata_index)/SUM(iata_rpk) AS iata_index,\
SUM(w_leg*skytra_index)/SUM(w_leg) AS skytra_index,\
SUM(iata_rpk) AS iata_rpk,\
SUM(skytra_rpk) AS skytra_rpk,\
SUM(iata_tickets) AS iata_tickets,\
SUM(skytra_tickets) AS skytra_tickets,\
100.*SUM(skytra_tickets)/SUM(iata_tickets) AS skytra_coverage \
FROM index_nleg \
GROUP BY region_pair, first_flight_date_utc \
ORDER BY region_pair, first_flight_date"
```


```python
#print(query)
query_job = client.query(x7_modified,
        # Location must match that of the dataset(s) referenced in the query.
        location="EU",)  # API request - starts the query

new_table_result = query_job.result().to_dataframe()
```


```python
X7_without_AA_DF = new_table_result
```


```python
X7_without_AA_DF.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>region_pair</th>
      <th>first_flight_date</th>
      <th>iata_index</th>
      <th>skytra_index</th>
      <th>iata_rpk</th>
      <th>skytra_rpk</th>
      <th>iata_tickets</th>
      <th>skytra_tickets</th>
      <th>skytra_coverage</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Africa-Africa</td>
      <td>2017-11-20</td>
      <td>0.077175</td>
      <td>0.171181</td>
      <td>4.369806e+07</td>
      <td>3.234832e+07</td>
      <td>20046</td>
      <td>16510</td>
      <td>82.360571</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Africa-Africa</td>
      <td>2017-11-21</td>
      <td>0.069162</td>
      <td>0.160586</td>
      <td>3.280114e+07</td>
      <td>2.534273e+07</td>
      <td>15161</td>
      <td>12731</td>
      <td>83.972034</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Africa-Africa</td>
      <td>2017-11-22</td>
      <td>0.069789</td>
      <td>0.160918</td>
      <td>2.823861e+07</td>
      <td>2.185850e+07</td>
      <td>14250</td>
      <td>11811</td>
      <td>82.884211</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Africa-Africa</td>
      <td>2017-11-23</td>
      <td>0.068311</td>
      <td>0.159143</td>
      <td>2.856280e+07</td>
      <td>2.176048e+07</td>
      <td>15250</td>
      <td>12525</td>
      <td>82.131148</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Africa-Africa</td>
      <td>2017-11-24</td>
      <td>0.070827</td>
      <td>0.161903</td>
      <td>2.800741e+07</td>
      <td>2.091610e+07</td>
      <td>14804</td>
      <td>12526</td>
      <td>84.612267</td>
    </tr>
  </tbody>
</table>
</div>




```python
#print(query)
query_job = client.query(x7_baseline,
        # Location must match that of the dataset(s) referenced in the query.
        location="EU",)  # API request - starts the query

new_table_result = query_job.result().to_dataframe()
X7_baseline_DF = new_table_result
```


```python
#conputes the benchnark for every region pair in the full dataset
benchmark_baseline_DF = pd.DataFrame()
for region in list(X7_baseline_DF.region_pair.unique()):
    index_tmp = X7_baseline_DF[X7_baseline_DF["region_pair"] == region]
    index_tmp["benchmark"] = index_tmp["skytra_index"].rolling(window=28).mean()
    benchmark_baseline_DF = benchmark_baseline_DF.append(index_tmp)

```

    Africa-Africa
    Africa-Asia/Pacific
    Africa-CIS
    Africa-Europe
    Africa-Latin America
    Africa-Middle East
    Africa-North America
    Asia/Pacific-Asia/Pacific
    Asia/Pacific-CIS
    Asia/Pacific-Europe
    Asia/Pacific-Latin America
    Asia/Pacific-Middle East
    Asia/Pacific-North America
    CIS-CIS
    CIS-Europe
    CIS-Latin America
    CIS-Middle East
    CIS-North America
    Europe-Europe
    Europe-Latin America
    Europe-Middle East
    Europe-North America
    Latin America-Latin America
    Latin America-Middle East
    Latin America-North America
    Middle East-Middle East
    Middle East-North America
    North America-North America


    /opt/conda/anaconda/lib/python3.6/site-packages/ipykernel_launcher.py:4: SettingWithCopyWarning: 
    A value is trying to be set on a copy of a slice from a DataFrame.
    Try using .loc[row_indexer,col_indexer] = value instead
    
    See the caveats in the documentation: http://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html#returning-a-view-versus-a-copy
      after removing the cwd from sys.path.



```python
#conputes the benchnark for every region pair in the dataset without AA
benchmark_withouAA_DF = pd.DataFrame()
for region in list(X7_without_AA_DF.region_pair.unique()):
    index_tmp = X7_without_AA_DF[X7_without_AA_DF["region_pair"] == region]
    index_tmp["benchmark"] = index_tmp["skytra_index"].rolling(window=28).mean()
    benchmark_withouAA_DF = benchmark_withouAA_DF.append(index_tmp)

```

    Africa-Africa
    Africa-Asia/Pacific
    Africa-CIS
    Africa-Europe
    Africa-Latin America
    Africa-Middle East
    Africa-North America
    Asia/Pacific-Asia/Pacific
    Asia/Pacific-CIS
    Asia/Pacific-Europe
    Asia/Pacific-Latin America
    Asia/Pacific-Middle East
    Asia/Pacific-North America
    CIS-CIS
    CIS-Europe
    CIS-Latin America
    CIS-Middle East
    CIS-North America
    Europe-Europe
    Europe-Latin America
    Europe-Middle East
    Europe-North America
    Latin America-Latin America
    Latin America-Middle East
    Latin America-North America
    Middle East-Middle East
    Middle East-North America
    North America-North America


    /opt/conda/anaconda/lib/python3.6/site-packages/ipykernel_launcher.py:4: SettingWithCopyWarning: 
    A value is trying to be set on a copy of a slice from a DataFrame.
    Try using .loc[row_indexer,col_indexer] = value instead
    
    See the caveats in the documentation: http://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html#returning-a-view-versus-a-copy
      after removing the cwd from sys.path.



```python
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
```


```python
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
```

    /opt/conda/anaconda/lib/python3.6/site-packages/ipykernel_launcher.py:13: SettingWithCopyWarning: 
    A value is trying to be set on a copy of a slice from a DataFrame.
    Try using .loc[row_indexer,col_indexer] = value instead
    
    See the caveats in the documentation: http://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html#returning-a-view-versus-a-copy
      del sys.path[0]



```python
final_benchmark_DF
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>region_pair</th>
      <th>first_flight_date</th>
      <th>iata_index</th>
      <th>skytra_index</th>
      <th>iata_rpk</th>
      <th>skytra_rpk</th>
      <th>iata_tickets</th>
      <th>skytra_tickets</th>
      <th>skytra_coverage</th>
      <th>benchmark</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Africa-Africa</td>
      <td>2017-11-20</td>
      <td>0.077175</td>
      <td>0.171181</td>
      <td>4.369806e+07</td>
      <td>3.234832e+07</td>
      <td>20046</td>
      <td>16510</td>
      <td>82.360571</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Africa-Africa</td>
      <td>2017-11-21</td>
      <td>0.069162</td>
      <td>0.160586</td>
      <td>3.280114e+07</td>
      <td>2.534273e+07</td>
      <td>15161</td>
      <td>12731</td>
      <td>83.972034</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Africa-Africa</td>
      <td>2017-11-22</td>
      <td>0.069789</td>
      <td>0.160918</td>
      <td>2.823861e+07</td>
      <td>2.185850e+07</td>
      <td>14250</td>
      <td>11811</td>
      <td>82.884211</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Africa-Africa</td>
      <td>2017-11-23</td>
      <td>0.068311</td>
      <td>0.159143</td>
      <td>2.856280e+07</td>
      <td>2.176048e+07</td>
      <td>15250</td>
      <td>12525</td>
      <td>82.131148</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Africa-Africa</td>
      <td>2017-11-24</td>
      <td>0.070827</td>
      <td>0.161903</td>
      <td>2.800741e+07</td>
      <td>2.091610e+07</td>
      <td>14804</td>
      <td>12526</td>
      <td>84.612267</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>21695</th>
      <td>North America-North America</td>
      <td>2019-12-30</td>
      <td>0.110457</td>
      <td>0.158834</td>
      <td>4.652115e+08</td>
      <td>4.584797e+08</td>
      <td>183606</td>
      <td>181157</td>
      <td>98.666166</td>
      <td>0.152145</td>
    </tr>
    <tr>
      <th>21696</th>
      <td>North America-North America</td>
      <td>2019-12-31</td>
      <td>0.090882</td>
      <td>0.133708</td>
      <td>4.153620e+08</td>
      <td>4.088752e+08</td>
      <td>159431</td>
      <td>157252</td>
      <td>98.633265</td>
      <td>0.151376</td>
    </tr>
    <tr>
      <th>21697</th>
      <td>North America-North America</td>
      <td>2020-01-01</td>
      <td>0.091170</td>
      <td>0.135748</td>
      <td>4.483521e+08</td>
      <td>4.413329e+08</td>
      <td>163704</td>
      <td>161470</td>
      <td>98.635342</td>
      <td>0.151208</td>
    </tr>
    <tr>
      <th>21698</th>
      <td>North America-North America</td>
      <td>2020-01-02</td>
      <td>0.104044</td>
      <td>0.153163</td>
      <td>5.264984e+08</td>
      <td>5.171521e+08</td>
      <td>194562</td>
      <td>191397</td>
      <td>98.373269</td>
      <td>0.151929</td>
    </tr>
    <tr>
      <th>21699</th>
      <td>North America-North America</td>
      <td>2020-01-03</td>
      <td>0.096573</td>
      <td>0.150164</td>
      <td>5.128031e+08</td>
      <td>5.038269e+08</td>
      <td>189323</td>
      <td>186257</td>
      <td>98.380545</td>
      <td>0.152229</td>
    </tr>
  </tbody>
</table>
<p>21700 rows × 10 columns</p>
</div>




```python
import datalab.storage as gcs #v1.1.5
gcs.Bucket('paulo_jupyter_notebooks').item('benchmark_timeseries_data.csv').write_to(final_benchmark_DF.to_csv(),'text/csv')
```

# testing that the divisor only changes for North America North America


```python
#computes the divisor
before_data_event = benchmark_baseline_DF[(pd.to_datetime(benchmark_baseline_DF.first_flight_date) == "2018-01-23")]
after_data_event = benchmark_withouAA_DF[(pd.to_datetime(benchmark_withouAA_DF.first_flight_date) == "2018-01-23") ]

#just showing the the NA-NA index is the only with a divisor different than 1
before_data_event[["region_pair", "benchmark"]]

```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>region_pair</th>
      <th>benchmark</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>64</th>
      <td>Africa-Africa</td>
      <td>0.167344</td>
    </tr>
    <tr>
      <th>839</th>
      <td>Africa-Asia/Pacific</td>
      <td>0.103400</td>
    </tr>
    <tr>
      <th>1614</th>
      <td>Africa-CIS</td>
      <td>0.115396</td>
    </tr>
    <tr>
      <th>2389</th>
      <td>Africa-Europe</td>
      <td>0.132024</td>
    </tr>
    <tr>
      <th>3164</th>
      <td>Africa-Latin America</td>
      <td>0.148294</td>
    </tr>
    <tr>
      <th>3939</th>
      <td>Africa-Middle East</td>
      <td>0.131045</td>
    </tr>
    <tr>
      <th>4714</th>
      <td>Africa-North America</td>
      <td>0.135386</td>
    </tr>
    <tr>
      <th>5489</th>
      <td>Asia/Pacific-Asia/Pacific</td>
      <td>0.184871</td>
    </tr>
    <tr>
      <th>6264</th>
      <td>Asia/Pacific-CIS</td>
      <td>0.084026</td>
    </tr>
    <tr>
      <th>7039</th>
      <td>Asia/Pacific-Europe</td>
      <td>0.099126</td>
    </tr>
    <tr>
      <th>7814</th>
      <td>Asia/Pacific-Latin America</td>
      <td>0.120883</td>
    </tr>
    <tr>
      <th>8589</th>
      <td>Asia/Pacific-Middle East</td>
      <td>0.100351</td>
    </tr>
    <tr>
      <th>9364</th>
      <td>Asia/Pacific-North America</td>
      <td>0.102266</td>
    </tr>
    <tr>
      <th>10139</th>
      <td>CIS-CIS</td>
      <td>0.071123</td>
    </tr>
    <tr>
      <th>10914</th>
      <td>CIS-Europe</td>
      <td>0.118000</td>
    </tr>
    <tr>
      <th>11689</th>
      <td>CIS-Latin America</td>
      <td>0.118252</td>
    </tr>
    <tr>
      <th>12464</th>
      <td>CIS-Middle East</td>
      <td>0.117956</td>
    </tr>
    <tr>
      <th>13239</th>
      <td>CIS-North America</td>
      <td>0.098088</td>
    </tr>
    <tr>
      <th>14014</th>
      <td>Europe-Europe</td>
      <td>0.207452</td>
    </tr>
    <tr>
      <th>14789</th>
      <td>Europe-Latin America</td>
      <td>0.122956</td>
    </tr>
    <tr>
      <th>15564</th>
      <td>Europe-Middle East</td>
      <td>0.136828</td>
    </tr>
    <tr>
      <th>16339</th>
      <td>Europe-North America</td>
      <td>0.143522</td>
    </tr>
    <tr>
      <th>17114</th>
      <td>Latin America-Latin America</td>
      <td>0.212529</td>
    </tr>
    <tr>
      <th>17889</th>
      <td>Latin America-Middle East</td>
      <td>0.131373</td>
    </tr>
    <tr>
      <th>18664</th>
      <td>Latin America-North America</td>
      <td>0.150957</td>
    </tr>
    <tr>
      <th>19439</th>
      <td>Middle East-Middle East</td>
      <td>0.188127</td>
    </tr>
    <tr>
      <th>20214</th>
      <td>Middle East-North America</td>
      <td>0.121254</td>
    </tr>
    <tr>
      <th>20989</th>
      <td>North America-North America</td>
      <td>0.154252</td>
    </tr>
  </tbody>
</table>
</div>




```python
after_data_event[["region_pair", "benchmark"]]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>region_pair</th>
      <th>benchmark</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>64</th>
      <td>Africa-Africa</td>
      <td>0.167344</td>
    </tr>
    <tr>
      <th>839</th>
      <td>Africa-Asia/Pacific</td>
      <td>0.103400</td>
    </tr>
    <tr>
      <th>1614</th>
      <td>Africa-CIS</td>
      <td>0.115396</td>
    </tr>
    <tr>
      <th>2389</th>
      <td>Africa-Europe</td>
      <td>0.132024</td>
    </tr>
    <tr>
      <th>3164</th>
      <td>Africa-Latin America</td>
      <td>0.148294</td>
    </tr>
    <tr>
      <th>3939</th>
      <td>Africa-Middle East</td>
      <td>0.131045</td>
    </tr>
    <tr>
      <th>4714</th>
      <td>Africa-North America</td>
      <td>0.135386</td>
    </tr>
    <tr>
      <th>5489</th>
      <td>Asia/Pacific-Asia/Pacific</td>
      <td>0.184871</td>
    </tr>
    <tr>
      <th>6264</th>
      <td>Asia/Pacific-CIS</td>
      <td>0.084026</td>
    </tr>
    <tr>
      <th>7039</th>
      <td>Asia/Pacific-Europe</td>
      <td>0.099126</td>
    </tr>
    <tr>
      <th>7814</th>
      <td>Asia/Pacific-Latin America</td>
      <td>0.120883</td>
    </tr>
    <tr>
      <th>8589</th>
      <td>Asia/Pacific-Middle East</td>
      <td>0.100351</td>
    </tr>
    <tr>
      <th>9364</th>
      <td>Asia/Pacific-North America</td>
      <td>0.102266</td>
    </tr>
    <tr>
      <th>10139</th>
      <td>CIS-CIS</td>
      <td>0.071123</td>
    </tr>
    <tr>
      <th>10914</th>
      <td>CIS-Europe</td>
      <td>0.118000</td>
    </tr>
    <tr>
      <th>11689</th>
      <td>CIS-Latin America</td>
      <td>0.118252</td>
    </tr>
    <tr>
      <th>12464</th>
      <td>CIS-Middle East</td>
      <td>0.117956</td>
    </tr>
    <tr>
      <th>13239</th>
      <td>CIS-North America</td>
      <td>0.098088</td>
    </tr>
    <tr>
      <th>14014</th>
      <td>Europe-Europe</td>
      <td>0.207452</td>
    </tr>
    <tr>
      <th>14789</th>
      <td>Europe-Latin America</td>
      <td>0.122956</td>
    </tr>
    <tr>
      <th>15564</th>
      <td>Europe-Middle East</td>
      <td>0.136828</td>
    </tr>
    <tr>
      <th>16339</th>
      <td>Europe-North America</td>
      <td>0.143522</td>
    </tr>
    <tr>
      <th>17114</th>
      <td>Latin America-Latin America</td>
      <td>0.212529</td>
    </tr>
    <tr>
      <th>17889</th>
      <td>Latin America-Middle East</td>
      <td>0.131373</td>
    </tr>
    <tr>
      <th>18664</th>
      <td>Latin America-North America</td>
      <td>0.150957</td>
    </tr>
    <tr>
      <th>19439</th>
      <td>Middle East-Middle East</td>
      <td>0.188127</td>
    </tr>
    <tr>
      <th>20214</th>
      <td>Middle East-North America</td>
      <td>0.121254</td>
    </tr>
    <tr>
      <th>20989</th>
      <td>North America-North America</td>
      <td>0.142561</td>
    </tr>
  </tbody>
</table>
</div>




```python
divisor
```




    20989    0.933327
    Name: skytra_index, dtype: float64


