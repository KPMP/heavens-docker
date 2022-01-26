#!/bin/bash
docker-compose -f "docker-compose.yml" "$@" -d
sleep 300
docker-compose -f "alert-docker-compose.yml" "$@" -d