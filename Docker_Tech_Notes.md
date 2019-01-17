We are using a Docker-managed volume for storing Mongo data (see https://docs.docker.com/storage/volumes/).
The Docker volumes are named using the parent directory of the docker-compose file and the volume name used in the docker-compose file,
i.e. DIRNAME_VOLUMENAME. Volumes are never deleted unless you explicitly tell Docker to do so. You can list the docker volumes using the
command docker volume ls. 
