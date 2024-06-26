#!/bin/bash

USAGE="usage: dataLake.sh [dev|prod] [up|down|restart]"

environment=$1
cmd=$2
up="up -d"
down="down"
if [ $cmd == "up" ]; then
	cmd="up -d"
fi

if [ "$environment" == "" ] || [ "$cmd" == "" ]; then
	echo $USAGE
elif [ "$environment" == "dev" ] && [ "$2" == "down" ]; then
	cd eridanus
	/usr/local/bin/docker compose -f docker-compose.dev.yml $cmd
	cd ../stateManager
	/usr/local/bin/docker compose -f docker-compose.dev.yml $cmd
	cd ../orion
	/usr/local/bin/docker compose -f docker-compose.dev.yml $cmd
  cd ../libra
  /usr/local/bin/docker compose -f docker-compose.local.yml $cmd
elif [ "$environment" == "dev" ] && [ "$2" == "up" ]; then
	cd orion
	/usr/local/bin/docker compose -f docker-compose.dev.yml $cmd
	cd ../eridanus
	/usr/local/bin/docker compose -f docker-compose.dev.yml $cmd
	cd ../stateManager
	/usr/local/bin/docker compose -f docker-compose.dev.yml $cmd
  cd ../libra
  /usr/local/bin/docker compose -f docker-compose.local.yml $cmd
elif [ "$environment" == "dev" ] && [ "$2" == "restart" ]; then
	cd orion
	/usr/local/bin/docker compose -f docker-compose.dev.yml $down
	cd ../eridanus
	/usr/local/bin/docker compose -f docker-compose.dev.yml $down
	cd ../stateManager
	/usr/local/bin/docker compose -f docker-compose.dev.yml $down
  cd ../libra
  /usr/local/bin/docker compose -f docker-compose.local.yml $down
	sleep 5s

	cd ../orion
	/usr/local/bin/docker compose -f docker-compose.dev.yml $up
	cd ../eridanus
	/usr/local/bin/docker compose -f docker-compose.dev.yml $up
	cd ../stateManager
	/usr/local/bin/docker compose -f docker-compose.dev.yml $up
  cd ../libra
  /usr/local/bin/docker compose -f docker-compose.local.yml $up
elif [ $environment == "prod" ] && [ "$2" == "down" ]; then
	cd eridanus
	/usr/local/bin/docker compose -f docker-compose.prod.yml $cmd
	cd ../stateManager
	/usr/local/bin/docker compose -f docker-compose.prod.yml $cmd
	cd ../orion
	/usr/local/bin/docker compose -f docker-compose.prod.yml $cmd
	cd ../dataLakeProxyServer
	/usr/local/bin/docker compose $cmd
	cd ../libra
	/usr/local/bin/docker compose -f docker-compose.prod.yml $cmd
elif [ $environment == "prod" ] && [ "$2" == "up" ]; then
	cd dataLakeProxyServer
	/usr/local/bin/docker compose $cmd
	cd ../eridanus
	/usr/local/bin/docker compose -f docker-compose.prod.yml $cmd
	cd ../stateManager
	/usr/local/bin/docker compose -f docker-compose.prod.yml $cmd
	cd ../orion
	docker compose -f docker-compose.prod.yml $cmd
	cd ../libra
	/usr/local/bin/docker compose -f docker-compose.prod.yml $cmd
elif [ $environment == "prod" ] && [ "$2" == "restart" ]; then
	cd orion
	/usr/local/bin/docker compose -f docker-compose.prod.yml $down
	cd ../eridanus
	/usr/local/bin/docker compose -f docker-compose.prod.yml $down
	cd ../stateManager
	/usr/local/bin/docker compose -f docker-compose.prod.yml $down
	sleep 5s

	cd ../orion
	/usr/local/bin/docker compose -f docker-compose.prod.yml $up
	cd ../eridanus
	/usr/local/bin/docker compose -f docker-compose.prod.yml $up
	cd ../stateManager
	/usr/local/bin/docker compose -f docker-compose.prod.yml $up
else
	echo $USAGE
fi
