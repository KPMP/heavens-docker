# Volumes and Mongo Data in Docker

We are using a Docker-managed volume for storing Mongo data (see https://docs.docker.com/storage/volumes/).
The Docker volumes are named using the parent directory of the docker-compose file and the volume name used in the docker-compose file,
i.e. DIRNAME_VOLUMENAME. Volumes are never deleted unless you explicitly tell Docker to do so. 

Some useful Docker commands:
- `docker volume ls`  //list all volumes
- `docker volume prune`  //remove unused volumes
- `docker image prune`  //remove unused images
- `docker container prune`  //remove unused containers
- `docker exec -it [container_name] bash`  //login to container
- `docker cp [local_file] [container_name]:[container_file]`  //copy file into container
- `docker images` list images
- `docker run --rm --volumes-from [container_name] -v [local_dir]:/backup ubuntu tar cvf /backup/backup.tar /[volume_name]`  //backup Docker volume
- `docker run --rm --volumes-from [container_name] -v [local_dir]:/backup ubuntu bash -c "cd /[volume_name] && tar xvf /backup/backup.tar --strip 1"`  //restore volume backup


