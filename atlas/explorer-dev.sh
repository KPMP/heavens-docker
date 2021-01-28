#!/bin/bash
cd explorer
docker-compose -f "docker-compose.dev.yml" "$@"
cd "../knowledge-environment"
docker-compose -f "docker-compose.dev.yml" "$@"
