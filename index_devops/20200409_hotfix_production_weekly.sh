

#relates to in797b, in810-812, in826-834, in836-838
#PRJ="d-dat-digitalaircrafttransport"
#export COMPOSER_NAME="af-kiwi-2019"

PRJ="skytra-benchmark-devandtest"
#export COMPOSER_NAME="benchmark-airflow"


YAM_WILD="kiwi_2020_X2_3x*.yml"
#X*.sql only possible because as @ now because only 3x Kiwi sql's left in folder
SQL_WILD="X*.sql"
DAG_WILD="NoNewDagsToDeploy*.py"

gcloud config set core/project $PRJ


#---------------------------------------
#git checkout hotfix_production
#git checkout origin/skytra_search_update

#no kiwi tables so no bq rm needed
cd ~/indexproduction/bq/t/
bash kiwi.X4.sh
bq rm -t -f kiwi.X5a
bash kiwi.X5a.sh


#Either programmatically determine DAGS bucket location or manual option next line
#export bktDags="gs://-bucket/dags"
export bktDags=$(gcloud composer environments describe ${COMPOSER_NAME} --location ${COMPOSER_LOCATION} | grep 'dagGcsPrefix' | grep -Eo "\S+/")dags
#echo "bktDags is ${bktDags}"

# next use gsutil to deploy content - dags, yaml and sq
cd ~/indexproduction/af/dags
#gsutil -m cp -r yaml/$YAM_WILD ${bktDags}/yaml
gsutil -m cp -r sq/$SQL_WILD ${bktDags}/sq
#gsutil -m cp -r $DAG_WILD ${bktDags}


#---------------------------------------
#git checkout IN-799-identify-our-searches-in-x5b

cd ~/indexproduction/bq/t/
bash kiwi.X5b.sh

cd ~/indexproduction/af/dags
SQL_WILD="X5b.sql"
gsutil -m cp -r sq/$SQL_WILD ${bktDags}/sq




bkt_src="gs://ext-iata-excl-data/2020/"
bkt_dst="gs://ext-iata-excl-dev-data/2020"
wild="/*"
gsutil -m cp -R $bkt_src$wild $bkt_dst

gsutil -m mv -R $bkt_src$wild $bkt_dst


#table updates---------------------------------------
PRJ="d-dat-digitalaircrafttransport"
gcloud config set core/project $PRJ

cd ~/indexproduction/bq/t/
git checkout hotfix_production
git pull origin

bq update --schema ./kiwi.X4.json kiwi.X4
bq update --schema ./kiwi.X5a.json kiwi.X5a
bq update --schema ./kiwi.X5b.json kiwi.X5b

bq update --schema ./matching.X6.json matching.X6
