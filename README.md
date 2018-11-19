# KPMP - Orion Docker Onboarding

- Install docker for your OS and register if needed.
- Launch Docker
- Go to Advanced tab and change your memory to 4GB (Apply & restart)
- Open your terminal of choice.
- `cd {kpmp_directory}`
- `mkdir data`
- `git clone git@github.com:KPMP/orion-data.git`
- `git clone git@github.com:KPMP/orion-web.git`
- `git clone git@github.com:KPMP/orion-docker.git`
- `cd orion-docker`
- `cp .env.example .env`
- Modify .env values to match your machine
- `docker-compose up -d`
- Go to orion-web and install and build the react project
  - `cd ../orion-web`
  - `npm install`
  - `npm run build`
- Direct your browser to localhost
