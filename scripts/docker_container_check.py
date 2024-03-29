#! /usr/bin/python3
import docker
import os
import requests
from dotenv import load_dotenv
import endpoint_check
import docker_container_reboot
import time
import sys
from pathlib import Path

load_dotenv()

expected_containers_string = os.environ.get('expected_containers')
environment = os.environ.get('environment')
slack_passcode = os.environ.get('slack_passcode')
expected_containers_list = expected_containers_string.split(', ')
slack_url = 'https://hooks.slack.com/services/' + slack_passcode
lock_name = os.environ.get('lock_name')

docker_client = docker.from_env()

def checkDockerContainers(checkAttempts=0):
    checkLimit = 3
    running_containers = set()
    expected_containers = set(expected_containers_list)
    message = ""

    if(checkAttempts >= checkLimit):
        message = 'Check attempts exceeded check limit, no longer attempting to restart containers'
        response = requests.post(slack_url, headers={'Content-type': 'application/json', }, data='{"text":"' + message + '"}')
        return message
    else:
        checkAttempts += 1
        containers = docker_client.containers.list()
        for container in containers:
            running_containers.add(container.name)
        missing_containers = expected_containers.difference(running_containers)

        if len(missing_containers) > 0:
            message = "ALERT: The following containers are missing on " + \
                environment + ": " + \
                ', '.join(missing_containers) + \
                ' - Attempting to restart containers...'

            response = requests.post(slack_url, headers={'Content-type': 'application/json', }, data='{"text":"' + message + '"}')
            
            docker_container_reboot.restartContainers()
            time.sleep(30)
            checkDockerContainers(checkAttempts)
            return
        else:
            message = "All containers are running as expected: " + \
                ', '.join(running_containers)
    
            healthy = endpoint_check.isHealthy()

            if(not healthy):
                message = "ALERT: The following service is not responding " + \
                    environment + ' - Attempting to restart containers...'
                response = requests.post(slack_url, headers={
                    'Content-type': 'application/json', }, data='{"text":"' + message + '"}')
                docker_container_reboot.restartContainers()
                time.sleep(30)
                checkDockerContainers(checkAttempts)
            else:
                message = "Service is running as expected on: " + environment
                return message

def setLock():
    try:
        with open(lock_name, 'w') as f:
            f.write('locked')
    except:
        print('Failed to create lock')

def removeLock():
    if Path(lock_name).exists():
        Path(lock_name).unlink()

def lockExists():
    if os.path.exists(lock_name):
        return True
    else:
        return False

if __name__ == "__main__":
    if lockExists():
        print('Lock file exists with name ' + lock_name + ', exiting...')
        sys.exit(0)
    else:
        setLock()
        checkDockerContainers()
        removeLock()
