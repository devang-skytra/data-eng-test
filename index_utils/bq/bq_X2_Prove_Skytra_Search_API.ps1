
bq load --project_id=skytra-benchmark-devandtest --location=EU --source_format=PARQUET --replace scratch_PaD.X2_skytra_api_check_20210121 "gs://ext-kiwi-excl-data/data/y=2021/m=01/d=20/hr=16/*.gz.parquet"



CREATE TABLE FROM scratch_PaD.X2_skytra_api_check_20210121_result(
	SELECT 
	data_list.element.booking_token.sid AS raw_sid, 
	data_list
	FROM scratch_PaD.X2_skytra_api_check_20210121 x2, UNNEST(data.list) AS data_list
	WHERE 
	data_list.element.booking_token.sid in("eaaaca03-22f5-4a09-9931-e4bdfa787f64","807dca9e-53b7-4893-b21c-430159140d6a")
	OR data_list.element.booking_token.partner = 'ab747' 
)