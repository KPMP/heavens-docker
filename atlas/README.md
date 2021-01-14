# Atlas and Knowledge Environment Docker

## Docker-compose files
* docker-compose.ke.yml -- The Knowledge Environment stack: KE Database (MariaDB, Adminer), File Service (MinIO, Flask/Python), Arranger Server, Arranger GUI, Elastic Search (ES, Kibana).
* docker-compose.prod.yml -- The Atlas web front-end (React/Apache) and Atlas ES index creation worker (Flask/Python). Requires the KE stack. 
* docker-compose.dev.yml -- The development version of the Atlas web front-end (React/Apache) and Atlas ES index creation worker (Flask/Python). Requires the KE stack. 

## Development
The docker-compose.dev.yml file should not be run on its own because it requires the Knowledge Environment services. Run atlas-dev.sh to bring up the KE services along with the Atlas web front-end.

## Environment Configuration

The .env file needs an AWS IAM user and access key/secret that has permissions to the bucket also named in the .env file:
- ENV_MINIO_ACCESS_KEY
- ENV_MINIO_SECRET_KEY
- ENV_BUCKET_NAME
