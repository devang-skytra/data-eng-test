WITH preK1 AS (
-- Unnesting itineraries within search 
-- Drop unused fields
-- Reference D1, D2, D3 
  SELECT
    EXTRACT(date FROM TIMESTAMP_SECONDS(timestamp)) AS search_date,
    data_list.element.booking_token.sid AS sid,
    ind_sid,
    data_list.element.booking_token.id AS btid,
    data_list.element.booking_token.p AS p,
    data_list.element.route AS routes
  FROM %%X2%%,
    UNNEST(data.list) AS data_list WITH OFFSET ind_sid -- Reference D1
  WHERE 
    -- Reference D1
	--%%ext-tbl-filter%%
    search_params.flyFrom_type != 'anywhere'
    AND search_params.to_type != 'anywhere'
    AND search_params.flyFrom_type!='radius'
    AND search_params.to_type!='radius'
    -- Reference D3
    AND ARRAY_LENGTH(data_list.element.route.list) < 7
),

itinerary_unduplicated AS (
-- Removed duplicated rows
-- Reference D3
  SELECT 
    ANY_VALUE(search_date) AS search_date, sid, ind_sid,
    ANY_VALUE(btid) AS btid, ANY_VALUE(p) AS p, ANY_VALUE(routes) AS routes
  FROM preK1
  GROUP BY sid, ind_sid
), 

routes_unfiltered AS (
-- Unnest legs drop unused fileds 
-- Reference D4
  SELECT
    search_date, sid, ind_sid,btid,p,
    route_list.element.id AS leg_id,
    route_list.element.flyFrom AS leg_origin,
    route_list.element.flyTo AS leg_dest,
    route_list.element.dTimeUTC AS leg_depTS,
    route_list.element.fare_classes AS leg_class,
    COUNTIF(route_list.element.vehicle_type != 'aircraft') OVER(PARTITION BY sid,ind_sid) AS not_aircraft,
    COUNTIF(route_list.element.fare_category NOT IN ('M','W')) OVER(PARTITION BY sid,ind_sid) AS not_eco
  FROM itinerary_unduplicated, UNNEST(routes.list) AS route_list
)

--%%INSERT%%
-- Eleminate itineraries with invalid values
-- Reference D5
-- Create output X.4
SELECT
  %%ts%% AS af_load_ts,
  search_date, sid, ind_sid, btid, p, 
  REGEXP_REPLACE(leg_id,'_(\\d+)$','') AS pkg_id,
  leg_origin, leg_dest, leg_depTS, leg_class
FROM routes_unfiltered
WHERE search_date = %%date%%
AND not_aircraft = 0
AND not_eco = 0  
