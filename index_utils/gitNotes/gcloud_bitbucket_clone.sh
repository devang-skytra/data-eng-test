
git clone https://bitbucket.org/indexproduction_SK/indexproduction.git

git clone https://skydesmo@bitbucket.org/skydesmo/dataeng.git


#git checkout -- path/to/file/to/revert

cd indexproduction
git config --global credential.helper 'cache --timeout=30000'
git config --global user.email "paul.desmond@skytra.com"
git config --global user.name "skydesmo"

git pull origin

git stage  -m 'X'

paul.desmond@skytra.com
HL1

cd ../dataenggit 
git pull origin