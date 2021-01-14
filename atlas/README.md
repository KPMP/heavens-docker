# Atlas Docker


## Development
The docker-compose.dev.yml file should not be run on its own because it requires the Knowledge Environment services. Run atlas-dev.sh to bring up the KE services along with the Atlas.  

## Environment Configuration

The .env file needs an AWS IAM user and access key/secret that has permissions to the bucket also named in the .env file:
- ENV_MINIO_ACCESS_KEY
- ENV_MINIO_SECRET_KEY
- ENV_BUCKET_NAME
