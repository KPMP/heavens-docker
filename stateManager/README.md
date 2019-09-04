# State Manager Service

This is intended to be a service available to other services and applications inside of KPMP.  It is not a stand-alone website, so there is only a Java project for the service layer.

It will run inside the dataLake network which is created by orion when running on a developer machine, or by the dataLakeProxyServer when running on our production-like and production instances.

## Set up on your local machine

- Pull down the stateManagerService project at http://github.com/KPMP
- Change directory to heavens-docker/orion
- docker-compose -f docker-compose.dev.yml up -d
- Change directory to heavens-docker/stateManager
- Copy the .env.example to .env
- Change the values in .env to point at your local statManager code
- docker-compose -f docker-compose.dev.yml up -d

At this point you should be able to interact with the service by hitting endpoints at http://localhost:3060

## Set up in dev, qa or prod

- Pull down the stateManagerService project at http://github.com/KPMP
- Change directory to heavens-docker/dataLakeProxyServer
- docker-compose up -d
- Change directory to heavens-docker/ara
- docker-compose up -d
- Change directory to heavens-docker/orion
- docker-compose -f docker-compose.shib.yml up -d
- Change directory to heavens-docker/stateManager
- Copy .env.example to .env
- Edit the values in .env to point at your local stateManager code
- docker-compose -f docker-compose.prod.yml up -d
