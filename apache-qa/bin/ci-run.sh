#!/bin/bash

# This file will run a container in the background
source common.bash .

docker run -d --name=$imagename -p 80:80 -p 443:443 $maintainer/$imagename