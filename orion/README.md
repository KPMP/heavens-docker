# Orion

On your local machine

- Open your terminal of choice.
- `cd {kpmp_directory}`
- `mkdir data`
- `git clone git@github.com:KPMP/orion-data.git`
- `git clone git@github.com:KPMP/orion-web.git`
- `git clone git@github.com:KPMP/orion-docker.git`
- `cd orion-docker`
- `cp .env.example .env`
- Modify .env values to match your machine
- `docker-compose -f dev-docker-compose.yml up -d`
- Go to orion-web and install and build the react project
  - `cd ../orion-web`
  - `npm install`
  - `npm run build`
- Direct your browser to localhost

## NOTES

On the dev machine, production machine (or eventually qa) you will need to start the dataLakeProxyServer docker first because it houses the dataLake network that orion will connect to.  Also, you will no longer need to supply the '-f dev-docker-compose.yml' on the command line to bring it up.
