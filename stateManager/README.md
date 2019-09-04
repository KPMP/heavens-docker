# State Manager Service

This is intended to be a service available to other services and applications inside of KPMP.  It is not a stand-alone website, so there is only a Java project for the service layer.

It will run inside the dataLake network which is created by orion when running on a developer machine, or by the dataLakeProxyServer when running on our production-like and production instances.

## Set up on your local machine

- Change directory to heavens-docker/orion
- docker-compose -f docker-compose.dev.yml up -d
- Change directory to heavens-docker/stateManager
- docker-compose -f docker-compose.dev.yml up -d

At this point you should be able to interact with the service by hitting endpoints at http://localhost:3060

As you are working on changes, you should make sure to run ./gradlew build docker in order to create new docker images locally to be used inside docker.  After rebuilding the image, you will need to restart the docker container in order to pick up your changes.

When you are done with your local changes, you will need to push the latest image to cloud.docker.com

1) docker login
2) Provide username/password (see another developer for these values)
3) docker push kingstonduo/state-manager-service  // This will push to the 'latest' tag which we are using on our local development machines
4) docker image ls
5) Find the image you just built (should be at the top of the list) and grab the hash
6) docker tag <hash> kingstonduo/state-manager-service:<x.x>  // Where hash is the value you just grabbed, and x.x is the release version you are working on
7) docker push kingstonduo/state-manager-service:<x.x>

## Set up in dev, qa or prod

- Pull down the stateManagerService project at http://github.com/KPMP
- Change directory to heavens-docker/dataLakeProxyServer
- docker-compose up -d
- Change directory to heavens-docker/ara
- docker-compose up -d
- Change directory to heavens-docker/orion
- docker-compose -f docker-compose.shib.yml up -d
- Change directory to heavens-docker/stateManager
- docker-compose -f docker-compose.prod.yml up -d
