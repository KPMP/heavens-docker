#! /usr/bin/python3
import docker
import os
import requests
from dotenv import load_dotenv
import endpoint_check
import docker_container_reboot

load_dotenv()

expected_containers_string = os.environ.get('expected_containers')
environment = os.environ.get('environment')
slack_passcode = os.environ.get('slack_passcode')
expected_containers_list = expected_containers_string.split(', ')
slack_url = 'https://hooks.slack.com/services/' + slack_passcode

docker_client = docker.from_env()


def checkDockerContainers():
    running_containers = set()
    expected_containers = set(expected_containers_list)
    message = ""

    containers = docker_client.containers.list()

    for container in containers:
        running_containers.add(container.name)

    missing_containers = expected_containers.difference(running_containers)

    if len(missing_containers) > 0:
        message = "ALERT: The following containers are missing on " + \
            environment + ": " + \
            ', '.join(missing_containers) + \
            ' - Attempting to restart containers...'
        response = requests.post(slack_url, headers={
            'Content-type': 'application/json', }, data='{"text":"' + message + '"}')
        docker_container_reboot.restartContainers()
        checkDockerContainers()
        return
    else:
        message = "All containers are running as expected: " + \
            ', '.join(running_containers)
        print(message)

        healthy = endpoint_check.isHealthy()
        if(not healthy):
            message = "ALERT: The following service is not responding " + \
                environment + ' - Attempting to restart containers...'
            response = requests.post(slack_url, headers={
                'Content-type': 'application/json', }, data='{"text":"' + message + '"}')
            docker_container_reboot.restartContainers()
            checkDockerContainers()
        else:
            message = "Service is running as expected on: " + environment
            print(message)
            return message


if __name__ == "__main__":
    checkDockerContainers()
    print("completed container check")
