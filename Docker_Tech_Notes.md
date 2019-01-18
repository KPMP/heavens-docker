# Volumes and Mongo Data in Docker

We are using a Docker-managed volume for storing Mongo data (see https://docs.docker.com/storage/volumes/) to avoid issues with mounting external file directories, especially in Windows and OSX, see https://docs.docker.com/samples/library/mongo/#where-to-store-data.

The Docker volumes are named using the parent directory of the docker-compose file and the volume name used in the docker-compose file,
i.e. DIRNAME_VOLUMENAME. Volumes are never deleted unless you explicitly tell Docker to do so. 

# Useful Docker Commands
- `docker volume ls`  //list all volumes
- `docker volume prune`  //remove unused volumes
- `docker image prune`  //remove unused images
- `docker container prune`  //remove unused containers
- `docker exec -it [container_name] bash`  //login to container
- `docker cp [local_file] [container_name]:[container_file]`  //copy file into container
- `docker images` //list images
-  `docker exec [container_name] sh -c 'exec mongodump -d [database_name] --archive' > /some/path/on/your/host/all-collections.archive` //backup Mongo data
- `docker run --rm --volumes-from [container_name] -v [local_dir]:/backup ubuntu tar cvf /backup/backup.tar /[volume_name]`  //backup Docker volume
- `docker run --rm --volumes-from [container_name] -v [local_dir]:/backup ubuntu bash -c "cd /[volume_name] && tar xvf /backup/backup.tar --strip 1"`  //restore volume backup

# Production Mongo Considerations

Most of these notes are from here: https://docs.mongodb.com/manual/administration/production-notes/

To get Mongo configurationin Mongo console (`mongo`): `db.runCommand( { serverStatus: 1 } )` 

- Make sure httpd interface is disabled - https://docs.mongodb.com/manual/administration/production-notes/#disable-http-interface
- Add access control 
- Use XFS filesystem - https://docs.mongodb.com/manual/administration/production-notes/#kernel-and-file-systems
- Adjust cache. Looks like Mongo on upload has 1.5 for cache. - https://docs.mongodb.com/manual/administration/production-notes/#id3
  - If you run mongod in a container (e.g. lxc, cgroups, Docker, etc.) that does not have access to all of the RAM available in a system, you must set storage.wiredTiger.engineConfig.cacheSizeGB to a value less than the amount of RAM available in the container. The exact amount depends on the other processes running in the container.
- Add montoring - https://docs.mongodb.com/manual/administration/free-monitoring/, https://www.mongodb.com/blog/post/introducing-free-cloud-monitoring-for-mongodb
- Noop scheduler when using VM - https://docs.mongodb.com/manual/administration/production-notes/#scheduling
- Use Enhanced Networking for EC2 - https://docs.mongodb.com/manual/administration/production-notes/#aws-ec2
- Adjust VMWare settings for Pathology-hosted - https://docs.mongodb.com/manual/administration/production-notes/#vmware
- Make backups - https://docs.mongodb.com/manual/core/backups/
