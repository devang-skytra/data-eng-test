
#1 change ext table defn source file

#just modify below files in cloud shell rather than source code
	#iata.ext_iata_csv.json
#then re-run...
	bq mk --external_table_definition=./iata.ext_iata_csv.json --schema ./iata.X1.json iata.ext_iata_csv


# subdag / sh step
#to call main dag / cloud composer run
