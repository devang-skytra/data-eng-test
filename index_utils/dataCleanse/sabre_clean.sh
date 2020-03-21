
tr -d '\0' < Sabre_SampleData.csv  > sabre_cleaned.csv
gsutil cp sabre_cleaned.csv gs://d-dat-data-eng