WITH
qtr AS ( 
  SELECT 
  CASE WHEN EXTRACT(QUARTER from q) > 2 THEN  EXTRACT(QUARTER from q) - 2 ELSE EXTRACT(QUARTER from q) + 2 END as q_fin,
  CASE WHEN EXTRACT(QUARTER from q) > 2 THEN  EXTRACT(YEAR    from q) + 1 ELSE EXTRACT(YEAR    from q) END as y_fin,
  FORMAT_DATE("%Y-Q%Q", q) as q_cal,
  q as q_start, 
  LAST_DAY(q, QUARTER) as q_end, 
  DATE_ADD(CURRENT_DATE, INTERVAL 6 QUARTER) as de
  FROM 
  UNNEST(GENERATE_DATE_ARRAY('2013-01-01', DATE_ADD(CURRENT_DATE, INTERVAL 6 QUARTER) , INTERVAL 1 QUARTER)) AS q
), 

dim AS ( 
  SELECT * FROM UNNEST(GENERATE_DATE_ARRAY('2013-01-01', DATE_ADD(CURRENT_DATE, INTERVAL 6 QUARTER) , INTERVAL 1 DAY)) AS d 
), 
  
dimqtr as (SELECT
  dim.d AS days,
  qtr.*,
  CONCAT( CAST(qtr.y_fin AS STRING), '-Q', CAST(qtr.q_fin AS STRING) ) AS quarter_delivery,
  DATE_ADD( dim.d, INTERVAL -365 DAY ) AS previous_year_date,
  CONCAT( CAST((qtr.y_fin-1) AS STRING), '-Q', CAST(qtr.q_fin AS STRING) ) as previous_quarter_delivery
FROM dim
JOIN qtr
ON  dim.d BETWEEN qtr.q_start and  qtr.q_end
ORDER BY 1)
  
select * from  dimqtr
 