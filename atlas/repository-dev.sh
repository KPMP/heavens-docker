#!/bin/bash
cd repository
docker-compose -f "docker-compose.dev.yml" "$@"
cd "../knowledge-environment"
docker-compose -f "docker-compose.dev.yml" "$@"
