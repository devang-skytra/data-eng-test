# bash / cloud shell only

fold='dags_r_UAT'

mkdir $fold
gsutil cp -r gs://europe-west2-benchmark-uat--2bf16b72-bucket/dags $fold
zip -r $fold.zip ./$fold



