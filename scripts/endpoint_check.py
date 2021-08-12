#! /usr/bin/python3
import os
import requests
from dotenv import load_dotenv

load_dotenv()

healthcheck_endpoint = os.environ.get('healthcheck_endpoint')


def isHealthy():
    healthy = True
    if(healthcheck_endpoint):
        try:
            r = requests.get(healthcheck_endpoint)
            if(r.status_code == 200):
                healhty = True
            else:
                healhty = False
        except requests.exceptions.RequestException as e:
            healthy = False

    return healthy


if __name__ == "__main__":
    healthy = isHealthy()
    print('isHealthy: ' + str(healthy))
