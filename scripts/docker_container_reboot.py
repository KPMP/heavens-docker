#! /usr/bin/python3
from dotenv import load_dotenv
import os

load_dotenv()

environment = os.environ.get('environment')


def restartContainers():
    composeDown = '/usr/local/bin/docker-compose -f docker-compose.prod.yml down'
    composeUp = '/usr/local/bin/docker-compose -f docker-compose.prod.yml up -d'

    if "atlas" in environment.lower():
        if "ke" in environment.lower():
            os.system(
                'cd /home/ubuntu/heavens-docker/atlas/knowledge-environment && ' + + composeDown)
            os.system(
                'cd /home/ubuntu/heavens-docker/atlas/knowledge-environment && ' + composeUp)
        else:
            os.system(
                'cd /home/ubuntu/heavens-docker/atlas/repository && ' + composeDown)
            os.system(
                'cd /home/ubuntu/heavens-docker/atlas/repository && ' + composeUp)
    elif "uploader" in environment.lower():
        if "dev" in environment.lower():
            os.system('cd /home/kpmp-appuser/heavens-docker/ && ./dataLake.sh dev down && ./dataLake.sh dev down && ./dataLake.sh dev up')
        elif "qa" in environment.lower():
            os.system('cd /home/kpmp-appuser/heavens-docker/ && ./dataLake.sh dev down && ./dataLake.sh dev down && ./dataLake.sh dev up')
        elif "prod" in environment.lower():
            os.system('cd /home/kpmp-appuser/heavens-docker/ && ./dataLake.sh prod down && ./dataLake.sh prod down && ./dataLake.sh prod up')
    elif "dpr" in environment.lower():
        os.system('cd /home/ubuntu/heavens-docker/delphinus/ && ' + composeDown)
        # double down to attempt to resolve possible apache issues
        os.system('cd /home/ubuntu/heavens-docker/delphinus/ && ' + composeDown)
        os.system('cd /home/ubuntu/heavens-docker/delphinus/ && ' + composeUp)
    elif "logaggregator" in environment.lower():
        os.system('cd /home/ubuntu/heavens-docker/ara/ && ' + composeDown)
        os.system('cd /home/ubuntu/heavens-docker/ara/ && ' + composeUp)

