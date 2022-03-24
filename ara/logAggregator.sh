#!/bin/bash

USAGE="usage: logAggregator.sh [up|down]"

cmd=$1
if [ $cmd == "up" ]; then
    cmd="up"
    /usr/local/bin/docker-compose -f "docker-compose.yml" "$cmd" "-d" --force-recreate
    sleep 300
    /usr/local/bin/docker-compose -f "alert-docker-compose.yml" "$cmd" "-d" --force-recreate
else
    /usr/local/bin/docker-compose -f "docker-compose.yml" "$cmd"
    /usr/local/bin/docker-compose -f "alert-docker-compose.yml" "$cmd"
fi
