# KPMP Docker Container Scripts 
This folder contains scripts for managing and monitoring the KPMP Docker containers.

# Scripts
1. **docker_container_check.py**: Run this manually or via cron to check the running containers against the list in the .env file. It outputs a list of containers that aren't found and sends a message to Slack.
   - Install required libraries: `pip3 install -r requirements.txt` 
   - Make sure the .env has all of the container names to check for.
   - Containers aren't named by default, so make sure the container has a name set in the docker-compose file.
   - Set the "environment" variable (i.e. the service / app being checked) and Slack passcode accordingly. 
