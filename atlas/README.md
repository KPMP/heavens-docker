# Atlas and Knowledge Environment Docker

## Development

The development Docker Compose versions (docker-compose.dev.yml) of the Repository and Explorer require the Knowledge Environment stack. Either start the KE stack first or use the explorer-dev.sh and repository-dev.sh files. Any arguments are passed to the docker-compose execution, so to bring up the Explorer dev stack you'd execute:
- `./explorer-dev.sh up -d'

## Environment Configuration

The .env file needs an AWS IAM user and access key/secret that has permissions to the bucket also named in the .env file:
- ENV_MINIO_ACCESS_KEY
- ENV_MINIO_SECRET_KEY
- ENV_BUCKET_NAME
