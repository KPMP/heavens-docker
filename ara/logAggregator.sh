#!/bin/bash
docker-compose -f "docker-compose.yml" "$@"
sleep 300
docker-compose -f "alert-docker-compose.yml" "$@"
