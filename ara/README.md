#Ara, Log Aggregator

As a stopgap, Ara is secured with a simple Apache basic_auth proxy.  The secure htpasswd file is stored in the KPMP secure files repository.

Be sure to deploy the file to your environment and update your `.env` mapping accordingly.

When deploying to PROD or QA, be sure to grab the config files from kpmp-secure for elastalert and put them in the 'elastalert/rules' directory. Only grab the config file appropriate for the environment you are deploying to.
