
REM cannot install docker so relying on python install of airflow
REM docker run -d -p 8080:8080 -v c:\dockerVols\airflow\:/usr/local/airflow/dags  puckel/docker-airflow webserver

REM commands run inside vscode powershell terminal

conda create -n airflow pip setuptools python=3.7

	Please update conda by running

		$ conda update -n base -c defaults conda

	The following NEW packages will be INSTALLED:

	  ca-certificates    pkgs/main/win-64::ca-certificates-2020.6.24-0
	  certifi            pkgs/main/win-64::certifi-2020.6.20-py37_0
	  openssl            pkgs/main/win-64::openssl-1.1.1g-he774522_0
	  pip                pkgs/main/win-64::pip-20.1.1-py37_1
	  python             pkgs/main/win-64::python-3.7.7-h81c818b_4
	  setuptools         pkgs/main/win-64::setuptools-47.3.1-py37_0
	  sqlite             pkgs/main/win-64::sqlite-3.32.3-h2a8f88b_0
	  vc                 pkgs/main/win-64::vc-14.1-h0510ff6_4
	  vs2015_runtime     pkgs/main/win-64::vs2015_runtime-14.16.27012-hf0eaf9b_3
	  wheel              pkgs/main/win-64::wheel-0.34.2-py37_0
	  wincertstore       pkgs/main/win-64::wincertstore-0.2-py37_0
	  zlib               pkgs/main/win-64::zlib-1.2.11-h62dcd97_4

conda update -n base -c defaults conda



conda activate airflow

pip install apache-airflow[postgres,gcp]==1.10.10 
REM --constraint https://raw.githubusercontent.com/apache/airflow/1.10.10/requirements/requirements-python3.7.txt


	 ERROR: Command errored out with exit status 1:
     command: 'c:\Anaconda3\python.exe' -u -c 'import sys, setuptools, tokenize; sys.argv[0] = '"'"'C:\\Users\\PAULDE~1\\AppData\\Local\\Temp\\pip-install-x92nwfrj\\setproctitle\\setup.py'"'"'; __file__='"'"'C:\\Users\\PAULDE~1\\AppData\\Local\\Temp\\pip-install-x92nwfrj\\setproctitle\\setup.py'"'"';f=getattr(tokenize, '"'"'open'"'"', open)(__file__);code=f.read().replace('"'"'\r\n'"'"', '"'"'\n'"'"');f.close();exec(compile(code, __file__, '"'"'exec'"'"'))' install --record 'C:\Users\PAULDE~1\AppData\Local\Temp\pip-record-epvsltdp\install-record.txt' --single-version-externally-managed --compile --install-headers 'c:\Anaconda3\Include\setproctitle'
         cwd: C:\Users\PAULDE~1\AppData\Local\Temp\pip-install-x92nwfrj\setproctitle\
    Complete output (5 lines):
    running install
    running build
    running build_ext
    building 'setproctitle' extension
    error: Microsoft Visual C++ 14.0 is required. Get it with "Build Tools for Visual Studio": https://visualstudio.microsoft.com/downloads/
    ----------------------------------------
	ERROR: Command errored out with exit status 1: 'c:\Anaconda3\python.exe' -u -c 'import sys, setuptools, tokenize; sys.argv[0] = '"'"'C:\\Users\\PAULDE~1\\AppData\\Local\\Temp\\pip-install-x92nwfrj\\setproctitle\\setup.py'"'"'; __file__='"'"'C:\\Users\\PAULDE~1\\AppData\\Local\\Temp\\pip-install-x92nwfrj\\setproctitle\\setup.py'"'"';f=getattr(tokenize, '"'"'open'"'"', open)(__file__);code=f.read().replace('"'"'\r\n'"'"', '"'"'\n'"'"');f.close();exec(compile(code, __file__, '"'"'exec'"'"'))' install --record 'C:\Users\PAULDE~1\AppData\Local\Temp\pip-record-epvsltdp\install-record.txt' --single-version-externally-managed --compile --install-headers 'c:\Anaconda3\Include\setproctitle' Check the logs for full command output.


pip install apache-airflow

	same error
	
conda deactivate	