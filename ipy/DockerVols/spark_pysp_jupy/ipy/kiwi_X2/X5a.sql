--------------------------------------------------------------------------------------------------
-- KIWI       : X5a -- Unnesting and basic filtering, and package price extraction
-- Query name : X5a
-- Authors    : B KASSE, D TWEED
--------------------------------------------------------------------------------------------------
-- Input      : %%X2%%
-- Output     : %%X5a%%
--------------------------------------------------------------------------------------------------
-- remove searches where search goes to or from anywhere or radius,
-- first level unnesting itinerary
-- Eliminate itineraries with more than 6 legs
-- apply window function on leadtime (7 to 34 days inclusive)
-- Reference  : D1 to D5
--------------------------------------------------------------------------------------------------
WITH
api_u AS (
---loads the list of usernames used on the kiwi API by skytra
  SELECT ARRAY_AGG(DISTINCT username) AS skytra_user
  FROM generic.api_username
),

-- Unnesting itineraries within search
-- Drop unused fields
-- Reference D1, D2, D3
preK1 AS (
  -- Unnesting itineraries within search
  -- Drop unused fields
  -- Reference D1, D2, D3
  SELECT
    EXTRACT(date FROM TIMESTAMP_SECONDS(timestamp)) AS search_date,
    data_list.element.booking_token.sid AS sid,
    ind_sid,
    data_list.element.booking_token.id AS btid,
    data_list.element.booking_token.p AS p,
    ---checks if the search was done by skytra
    data_list.element.booking_token.partner IN UNNEST(skytra_user) AS skytra_search,
    data_list.element.route AS routes,
    ROW_NUMBER() OVER(PARTITION BY data_list.element.booking_token.sid, ind_sid) AS rank
  FROM kiwi.X2_{{ ds_nodash }},
    UNNEST(data.list) AS data_list WITH OFFSET ind_sid, api_u



  WHERE search_params.flyFrom_type NOT IN ('anywhere', 'radius')
    AND search_params.to_type NOT IN ('anywhere', 'radius')
    AND ARRAY_LENGTH(data_list.element.route.list) < 7 
),



pkg_prices AS (
SELECT sid,ind_sid, pkg_id, SUM(price) AS price
  FROM (
	    SELECT sid,ind_sid,
	      REGEXP_REPLACE(btid[SAFE_ORDINAL(i)],'_(\\d+)$','') AS pkg_id,
	      SAFE_CAST(p[SAFE_ORDINAL(i)] AS NUMERIC) AS price
	    FROM (
		      SELECT sid,ind_sid, SPLIT(btid,'|') AS btid, SPLIT(p,'|') AS p
		      FROM  preK1
		      -- Removed duplicated rows Reference D3
		      WHERE rank = 1
	   	),
		UNNEST(GENERATE_ARRAY(1,ARRAY_LENGTH(btid))) AS i
	  )
  GROUP BY sid, ind_sid, pkg_id
),

k_legs as (-- Unnest legs drop unused fields
    -- Reference D4
    SELECT sid, ind_sid, search_date,
      REGEXP_REPLACE(route_list.element.id,'_(\\d+)$','') AS pkg_id,
      FORMAT_TIMESTAMP("%Y%m%d%H%M", TIMESTAMP_SECONDS(route_list.element.dTimeUTC)) AS leg_depTS,
      CONCAT(route_list.element.flyFrom, '-', route_list.element.flyTo) AS leg_route,
      route_list.element.flyFrom as flyFrom,
      route_list.element.flyTo as flyTo,
      CONCAT('(', IFNULL(route_list.element.fare_classes,''),')') AS leg_class,
      route_list.element.vehicle_type != 'aircraft' AS not_aircraft,
      TRIM(route_list.element.fare_category) as fare_category,
      skytra_search
    FROM preK1, UNNEST(routes.list) AS route_list
    -- Removed duplicated rows Reference D3
    WHERE rank = 1),

legs_wit_distance as (SELECT k.*,
---we use the coordinate of the origin and destination airport to compute the distnace of the leg
ST_DISTANCE(ST_GEOGPOINT(a.lon,a.lat), ST_GEOGPOINT(b.lon,b.lat))/1000  AS leg_dist_km
FROM  k_legs k LEFT JOIN generic.skytra_airport a on k.flyFrom = a.iata_code LEFT JOIN generic.skytra_airport b on k.flyTo = b.iata_code  ),

pkg_legs AS (
  SELECT
    legs_wit_distance.sid, legs_wit_distance.ind_sid, legs_wit_distance.pkg_id, search_date,
    CONCAT(leg_depTS,'_',leg_route,leg_class) AS leg_map,
    leg_dist_km, 
    ---if a leg has no distance is because we do not know at least one of the airports
    IF(leg_dist_km is null,1,0) as unknown_leg,  skytra_search,
    fare_category,
    COUNTIF(not_aircraft) OVER(PARTITION BY sid,ind_sid) >0 AS invalid_itineraries
    
  FROM legs_wit_distance),
  
pkg_map as (  
  SELECT
    ANY_VALUE(search_date) AS search_date, sid,ind_sid, pkg_id,STRING_AGG(fare_category ORDER BY leg_map) as fare_category,
    STRING_AGG(leg_map ORDER BY leg_Map) AS package_map,
    SUM(leg_dist_km) AS dist_km, 
    ----unknown route is the sum of unknown legs
    sum(unknown_leg) as unknown_route, MAX(skytra_search) as skytra_search
  FROM pkg_legs
  -- Eliminate itineraries with invalid values
  -- Reference D5
  WHERE search_date =  '{{ ds }}'
    AND NOT invalid_itineraries 
  GROUP BY sid, ind_sid, pkg_id
)


SELECT
  {{ ds_nodash }} AS pl_id,
  pkg_map.* except(skytra_search, unknown_route),
  pkg_prices.price,
  pkg_map.skytra_search
FROM  pkg_map
LEFT JOIN pkg_prices
ON  pkg_map.sid     = pkg_prices.sid
AND pkg_map.ind_sid = pkg_prices.ind_sid
AND pkg_map.pkg_id = pkg_prices.pkg_id 
---we remove routes that haver unknown legs
where unknown_route = 0



/*
root
 |-- timestamp: long (nullable = true)
 |-- search_params: struct (nullable = true)
 |    |-- flyFrom_type: string (nullable = true)
 |    |-- seats: struct (nullable = true)
 |    |    |-- adults: integer (nullable = true)
 |    |    |-- children: integer (nullable = true)
 |    |    |-- infants: integer (nullable = true)
 |    |    |-- passengers: integer (nullable = true)
 |    |-- to_type: string (nullable = true)
 |-- currency: string (nullable = true)
 |-- currency_rate: double (nullable = true)
 |-- data: array (nullable = true)
 |    |-- element: struct (containsNull = true)
 |    |    |-- booking_token: struct (nullable = true)
 |    |    |    |-- id: string (nullable = true)
 |    |    |    |-- infant_price: double (nullable = true)
 |    |    |    |-- infants: integer (nullable = true)
 |    |    |    |-- p: string (nullable = true)
 |    |    |    |-- partner: string (nullable = true)
 |    |    |    |-- passengers: integer (nullable = true)
 |    |    |    |-- sid: string (nullable = true)
 |    |    |-- flyFrom: string (nullable = true)
 |    |    |-- flyTo: string (nullable = true)
 |    |    |-- dTime: long (nullable = true)
 |    |    |-- dTimeUTC: long (nullable = true)
 |    |    |-- pnr_count: integer (nullable = true)
 |    |    |-- price: double (nullable = true)
 |    |    |-- route: array (nullable = true)
 |    |    |    |-- element: struct (containsNull = true)
 |    |    |    |    |-- aTimeUTC: long (nullable = true)
 |    |    |    |    |-- airline: string (nullable = true)
 |    |    |    |    |-- dTimeUTC: long (nullable = true)
 |    |    |    |    |-- fare_classes: string (nullable = true)
 |    |    |    |    |-- flight_no: integer (nullable = true)
 |    |    |    |    |-- flyFrom: string (nullable = true)
 |    |    |    |    |-- flyTo: string (nullable = true)
 |    |    |    |    |-- id: string (nullable = true)
 |    |    |    |    |-- operating_carrier: string (nullable = true)
 |    |    |    |    |-- vehicle_type: string (nullable = true)
 |    |    |    |    |-- source: string (nullable = true)
 |    |    |    |    |-- found_on: string (nullable = true)
 |    |    |    |    |-- fare_category: string (nullable = true)


root
 |-- timestamp: long (nullable = true)
 |-- search_params: struct (nullable = true)
 |    |-- flyFrom_type: string (nullable = true)
 |    |-- seats: struct (nullable = true)
 |    |    |-- adults: integer (nullable = true)
 |    |    |-- children: integer (nullable = true)
 |    |    |-- infants: integer (nullable = true)
 |    |    |-- passengers: integer (nullable = true)
 |    |-- to_type: string (nullable = true)
 |-- currency: string (nullable = true)
 |-- currency_rate: double (nullable = true)
 |-- data_flat: struct (nullable = true)
 |    |-- booking_token: struct (nullable = true)
 |    |    |-- id: string (nullable = true)
 |    |    |-- infant_price: double (nullable = true)
 |    |    |-- infants: integer (nullable = true)
 |    |    |-- p: string (nullable = true)
 |    |    |-- partner: string (nullable = true)
 |    |    |-- passengers: integer (nullable = true)
 |    |    |-- sid: string (nullable = true)
 |    |-- flyFrom: string (nullable = true)
 |    |-- flyTo: string (nullable = true)
 |    |-- dTime: long (nullable = true)
 |    |-- dTimeUTC: long (nullable = true)
 |    |-- pnr_count: integer (nullable = true)
 |    |-- price: double (nullable = true)
 |    |-- route: array (nullable = true)
 |    |    |-- element: struct (containsNull = true)
 |    |    |    |-- aTimeUTC: long (nullable = true)
 |    |    |    |-- airline: string (nullable = true)
 |    |    |    |-- dTimeUTC: long (nullable = true)
 |    |    |    |-- fare_classes: string (nullable = true)
 |    |    |    |-- flight_no: integer (nullable = true)
 |    |    |    |-- flyFrom: string (nullable = true)
 |    |    |    |-- flyTo: string (nullable = true)
 |    |    |    |-- id: string (nullable = true)
 |    |    |    |-- operating_carrier: string (nullable = true)
 |    |    |    |-- vehicle_type: string (nullable = true)
 |    |    |    |-- source: string (nullable = true)
 |    |    |    |-- found_on: string (nullable = true)
 |    |    |    |-- fare_category: string (nullable = true)




*/
