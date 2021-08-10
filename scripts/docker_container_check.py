#! /usr/bin/python3
import docker
import os
import requests
from dotenv import load_dotenv

load_dotenv()

expected_containers_string = os.environ.get('expected_containers')
environment = os.environ.get('environment')
slack_passcode = os.environ.get('slack_passcode')
expected_containers_list = expected_containers_string.split(', ')
slack_url = 'https://hooks.slack.com/services/' + slack_passcode

docker_client = docker.from_env()
containers = docker_client.containers.list()

running_containers = set()
expected_containers = set(expected_containers_list)
message = ""

for container in containers:
    running_containers.add(container.name)

missing_containers = expected_containers.difference(running_containers)

if len(missing_containers) > 0:
    message = "ALERT: The following containers are missing on " + environment + ": " + ', '.join(missing_containers)
    response = requests.post(slack_url, headers={'Content-type': 'application/json',}, data='{"text":"' + message+ '"}')
else:
    message = "All containers are running as expected: " + ', '.join(running_containers)

print(message)

