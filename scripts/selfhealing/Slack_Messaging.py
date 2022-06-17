import requests
import os
from dotenv import load_dotenv

load_dotenv()

SLACK_HOOK_PASSCODE = os.environ.get('slack_passcode')

if SLACK_HOOK_PASSCODE is None:
    raise ValueError('slack_passcode variable not set in the .env file')
    
def send_slack_message(message):
    slackHookUrl = f'https://hooks.slack.com/services/{SLACK_HOOK_PASSCODE}'
    requests.post(slackHookUrl,
                  headers={'Content-type': 'application/json', },
                  data='{"text":"' + message + '"}')