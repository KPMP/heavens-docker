#! /usr/bin/python3
from dotenv import load_dotenv
import os

load_dotenv()

environment = os.environ.get('environment')


def restartContainers():
    composeDown = 'docker-compose -f docker-compose.prod.yml down'
    composeUp = 'docker-compose -f docker-compose.prod.yml up -d'

    if "atlas" in environment.lower():
        os.system('cd ../atlas/repository && ' + composeDown)
        os.system('cd ../atlas/knowledge-environment && ' + + composeDown)

        os.system('cd ../atlas/repository && ' + composeUp)
        os.system('cd ../atlas/knowledge-environment && ' + composeUp)
