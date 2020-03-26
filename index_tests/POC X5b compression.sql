
# bq cp 'skytra-benchmark-prod:kiwi.X5b$20200101' skytra-benchmark-devandtest:scratch_PaD.poc_compression_X5b

CREATE TABLE scratch_PaD.poc_compression_X5b_TINY as (SELECT * FROM scratch_PaD.poc_compression_X5b WHERE search_date = '2020-01-01' LIMIT 50)


--CREATE OR REPLACE TABLE scratch_PaD.poc_compression_X5b_TINY_SPLIT as (
CREATE OR REPLACE TABLE scratch_PaD.poc_compression_X5b_SPLIT as (
select 
pl_id,
search_date,
CAST( SPLIT(leg_c, '_')[safe_ordinal(1)] AS INT64 ) AS l_ts,
CAST( SPLIT(leg_c, '_')[safe_ordinal(2)] AS STRING ) AS l,
CAST( SPLIT(leg_cl, '_')[safe_ordinal(1)] AS INT64 ) AS lcl_ts,
CAST( SPLIT(leg_cl, '_')[safe_ordinal(2)] AS STRING ) AS lcl,
price, 
classless_price
from
(
SELECT 
pl_id,
search_date, 
journey_map,
SPLIT(journey_map, ',')[safe_ordinal(unnested_maps)] as leg_c,
classless_journey_map, 
SPLIT(classless_journey_map, ',')[safe_ordinal(unnested_maps)] as leg_cl,
price, 
classless_price
FROM 
--scratch_PaD.poc_compression_X5b_TINY x5b cross join
scratch_PaD.poc_compression_X5b x5b cross join
unnest(generate_array(1, array_length(split(journey_map, ',')))) as unnested_maps
WHERE 
--journey_map in('202003050615_MXP-CTA(),202003081440_CTA-MXP()' , '202010121405_OSL-VIE(Z),202010130400_VIE-BCN()')
search_date = '2020-01-01'
) x
)

/*

Email

a) skytra-benchmark-devandtest.scratch_PaD.poc_compression_X5b
vs
b) skytra-benchmark-devandtest.scratch_PaD.poc_compression_X5b_SPLIT

The 2 columns from a)
  journey_map,
  classless_journey_map, 
  
have been split into b)
  l_ts,
  l,
  lcl_ts,
  lcl,
  
Notes:
i)
the 2 cols in a) can be multiples of multiples
so value journey_map = '202010121405_OSL-VIE(Z),202010130400_VIE-BCN()'
becomes 2 rows x 2 columns in b) ie 4 cells 202010121405 'OSL-VIE(Z)' 202010130400 'VIE-BCN()'
ii) I have decided not to break the strings above into further columns yet, this should already be enough to show some improvement 
iii) I have not attempted to nest remaining columns so the 4 columns common to a) and b) will now be more repeated rows and bytes in b), hence why b) is larger at 1.62TB vs 1.24TB

Therefore the most direct comparison for your PM's is sum(bytes journey_map, classless_journey_map) vs sum(bytes l_ts, l, lcl_ts, lcl)
*/