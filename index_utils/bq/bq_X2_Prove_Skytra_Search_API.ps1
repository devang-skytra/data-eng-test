

ENSURE DONE AFTER 11AM BST TO AVOID PROD API searches in 10AM folder

#########################
2021 04 19

bq load --project_id=skytra-benchmark-devandtest --location=EU --source_format=PARQUET --replace scratch_PaD.X2_skytra_api_check_20210419 "gs://ext-kiwi-excl-data/data/y=2021/m=04/d=19/hr=10/*.gz.parquet"



/*
CREATE TABLE scratch_PaD.X2_skytra_api_check_20210419_Grequests as (
	SELECT 
	data_list.element.booking_token.sid AS raw_sid, 
	data_list
	FROM scratch_PaD.X2_skytra_api_check_20210419 x2, UNNEST(data.list) AS data_list
	WHERE 
	#data_list.element.booking_token.sid in("eaaaca03-22f5-4a09-9931-e4bdfa787f64","807dca9e-53b7-4893-b21c-430159140d6a") OR 
	data_list.element.booking_token.partner = 'ab747' 

)
*/

select 
--FORMAT_TIMESTAMP("%Y%m%d%H%M", TIMESTAMP_SECONDS(data_list.element.dTimeUTC)) AS searchTS, -- NOT the searchTS unfortunately

/*
distinct
CONCAT(data_list.element.flyFrom,'.',data_list.element.flyTo) as rt,
FORMAT_TIMESTAMP("%Y%m%d", TIMESTAMP_SECONDS(route_list.element.dTimeUTC)) AS leg_arrTS,
FORMAT_TIMESTAMP("%Y%m%d", TIMESTAMP_SECONDS(route_list.element.dTimeUTC)) AS leg_depTS,
*/
from scratch_PaD.X2_skytra_api_check_20210419_Grequests, UNNEST(data_list.element.route.list) AS route_list

WHERE 
CONCAT(data_list.element.flyFrom,'.',data_list.element.flyTo) IN ('LXA.CTU','KHG.URC')
--ORDER BY 1,2,3






#########################
2021 03 13

bq load --project_id=skytra-benchmark-rnd --location=EU --replace --source_format=PARQUET scratch_SuK.X2_0313 "gs://ext-kiwi-excl-data/data/y=2021/m=03/d=13/*.gz.parquet"


WITH 
X2 AS (
  SELECT *, data.list[OFFSET(0)].element.booking_token.sid AS raw_sid
  FROM kiwi.X2_complianceRequest_20201202
),
unnested AS (
SELECT DISTINCT raw_sid, price_provider
FROM (
  SELECT raw_sid, 
    IF(TRIM(route_list.element.source) != TRIM(route_list.element.found_on),
      CONCAT(TRIM(route_list.element.source),':',TRIM(route_list.element.found_on)),
      TRIM(route_list.element.source)
    ) AS price_provider
  FROM (
    SELECT raw_sid, data_list.element.route
    FROM X2,UNNEST(data.list) AS data_list
    -- WHERE data_list.element.booking_token.partner = 'skyscanner' 
  ), UNNEST(route.list) AS route_list)
),
selected_searches AS (
  SELECT DISTINCT raw_sid
  FROM unnested
  WHERE price_provider = 'lcc-7G'
)
SELECT X2.* EXCEPT(raw_sid)
FROM X2
INNER JOIN selected_searches
ON X2.raw_sid = selected_searches.raw_sid




