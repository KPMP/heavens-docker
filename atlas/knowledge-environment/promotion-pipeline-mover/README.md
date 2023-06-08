# Promotion-pipline-mover
This is a docker container that takes in a file and uploads the file to Amazon S3.

## Getting started
Provide file to be moved to s3 inside of the container_files directory

Copy `.env.example` and rename it to `.env` 

AWS_KEY is the key for the user that has access to the bucket you want to upload to

AWS_SECRET_KEY is the key given to the user that is only shared once time when the user is created

Build the image with the provided Dockerfile

## Using the container

In the command line `docker run --env-file ./.env <image_name> -f <file_name> -d </home/name_of_file> -b <bucket_name>`

If any one of the arguments are invaild the container will shutdown and return an exit code (code 148).

If the container is successful, the container will upload the file to the S3 bucket and return a successful exit code (code 200)

To view these codes type `docker ps -a`

# Notes

If you want the file to be in a "directory" in Amazon S3, replace `<file_name>` in the command above with the directory to the file on your local machine.

The file name MUST have no spaces or the command will fail

the `file_dir` will always be /home/name_of_file since the Dockerfile copies files in ./container_files to /home/ inside the container

# Example

`docker run --env-file ./.env myimage/name:tag -f  -d /home/hello_world.txt -b my-bucket-name`