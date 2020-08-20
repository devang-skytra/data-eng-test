

*******
Not sure how this got missed on several levels, but it seems the addition of X5b.n_prices 
got implemented in sql but the table didn't receive a bq update to add field so airflow has been dropping the result without error
n_prices not used in spX6 etc so surprising but feasible it was missed.

However if this cannot possibly be true, then we have the option of restoring X5b from up to 7 days ago to confirm somehow a column has been deleted - not easy to do so very unlikely

I've implemented X5b.n_prices so they show only from dag_kiwi_daily onward (July 23rd) which is currently running/backfilling



cd git\index2\bq\t
git branch

gcloud config set core/project skytra-benchmark-uat
gcloud config get-value core/project
bq update --schema ./kiwi.X5b.json in1603_FlatPOC.X5b

gcloud config set core/project d-dat-digitalaircrafttransport
gcloud config get-value core/project
bq update --schema ./kiwi.X5b.json kiwi.X5b





