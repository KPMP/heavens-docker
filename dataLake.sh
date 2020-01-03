#!/bin/bash

USAGE="usage: dataLake.sh [dev|prod] [up|down]"

environment=$1
cmd=$2
if [ $cmd == "up" ]; then
	cmd="up -d"
fi

if [ "$environment" == "" ] || [ "$cmd" == "" ]; then
	echo $USAGE
elif [ "$environment" == "dev" ] && [ "$2" == "down" ]; then
	cd eridanus
	docker-compose -f docker-compose.dev.yml $cmd
	cd ../stateManager
	docker-compose -f docker-compose.dev.yml $cmd
	cd ../orion
	docker-compose -f docker-compose.dev.yml $cmd
	cd ../metadataValidator
	docker-compose $cmd
elif [ "$environment" == "dev" ] && [ "$2" == "up" ]; then
	cd orion
	docker-compose -f docker-compose.dev.yml $cmd
	cd ../eridanus
	docker-compose -f docker-compose.dev.yml $cmd
	cd ../stateManager
	docker-compose -f docker-compose.dev.yml $cmd
	cd ../metadataValidator
	docker-compose $cmd
elif [ $environment == "prod" ] && [ "$2" == "down" ]; then
	cd eridanus
	docker-compose -f docker-compose.prod.yml $cmd
	cd ../stateManager
	docker-compose -f docker-compose.prod.yml $cmd
	cd ../orion
	docker-compose -f docker-compose.prod.yml $cmd
	cd ../dataLakeProxyServer
	docker-compose $cmd
	cd ../metadataValidator
	docker-compose $cmd
elif [ $environment == "prod" ] && [ "$2" == "up" ]; then
	cd dataLakeProxyServer
	docker-compose $cmd
	cd ../eridanus
	docker-compose -f docker-compose.prod.yml $cmd
	cd ../stateManager
	docker-compose -f docker-compose.prod.yml $cmd
	cd ../orion
	docker-compose -f docker-compose.prod.yml $cmd
	cd ../metadataValidator
	docker-compose $cmd
else
	echo $USAGE
fi
