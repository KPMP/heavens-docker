#!/bin/bash

# This file will run a container in the background
source common.bash .

echo "Cleaning up Docker image($maintainer/$imagename)"
docker stop $imagename >> /dev/null
docker rm $imagename
