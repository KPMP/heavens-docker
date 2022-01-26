#!/bin/bash

USAGE="usage: logAggregator.sh [up|down]"

cmd=$1
if [ $cmd == "up" ]; then
	cmd="up"
    detatched="-d"
    docker-compose -f "docker-compose.yml" "$cmd" detatched
    sleep 300
    docker-compose -f "alert-docker-compose.yml" "$cmd" detatched
else
    docker-compose -f "docker-compose.yml" "$cmd"
    docker-compose -f "alert-docker-compose.yml" "$cmd"
fi
