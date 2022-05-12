# About

Self-healing is a small group of modules that assist with alerting and redeployment of downed apps.

# Structure
1. Slack Messaging
    - we are currently logging alerts directly to Slack via webhooks
2. System Usage
    - We monitor for things such as disk space usage, memory usage, and CPU usage. When a utilization threshold is met, an alert is logged to Slack.
3. Docker Container Healing
    - We monitor for container outages and automatically respond with container reboots.
    - The monitoring here is at both the container and site-accessibility levels. We achieve this by monitoring the expected containers vs. which are actually online. We also perform health checks by sending requests to specific endpoints.
    - We are not currently monitoring/self-healing at the operating system level

# Installation

1. pip3 install -r requirements
2. Add environment and slack messaging variables to /heavens-docker/scripts/.env
3. add cronjob with crontab -e
    - */10 * * * *  /usr/bin/python3 /home/ubuntu/heavens-docker/scripts/selfhealing/System_Usage.py

# Tests
A small test suite is available by running:

$ python3 System_Usage.test.py