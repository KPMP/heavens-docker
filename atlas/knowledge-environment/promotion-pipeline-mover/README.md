# Promotion-pipline-mover
s3Moves is a docker container that takes in a file and uploads the file to Amazon S3.

## Getting started
To use this docker container, pull the image from dockerhub `docker pull kingstonduo/promotion-pipeline-mover:1.0`

Copy `.env.example` and rename it to `.env` 

Provide file to be moved to s3 inside of the container_files directory

AWS_KEY is the key for the user that has access to the bucket you want to upload to

AWS_SECRET_KEY is the key given to the user that is only share once the user is created

CONTAINER_FILE_LOCATION is the absolute path the file inside of the container

BUCKET_NAME is the name of the desired bucket uploading files to

OBJECT_NAME will be the name of the file when it enters S3



## Using the container
Simply run `docker-compose up` and the container will spin up. When the file is uploaded the container will automatically shutdown and provide a successful exit code (code 200)

If CONTAINER_FILE_LOCATION or BUCKET_NAME are invalid the container will shutdown and return an exit code (code 148)