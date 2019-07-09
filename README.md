# Heavens-docker

This repository holds all of the docker-compose.yml files and Dockerfiles needed for the various KPMP applications developed at UMich.

|  **Project Name** | **Description**   |
| ------------ | ------------ |
| ara  | Ara is the log aggregator.  It is intended to be a central repository for logs from the various apps hosted at UMich  |
| cassiopeia  | Cassiopeia is the code name for the Participant Whole Slide Image Viewer (mydata.kpmp.org)  |
| circinus | Circinus is the code name for the KPMP Demo site (demo.kpmp.org) |
| delphinus  |  Delphinus is the code name for the Digital Pathology Repository (or DPR) (currently at demo.kpmp.org/dpr)  |
| eridanus  | Eridanus is the code name for the notification service. It is intended to notify individuals when particular events happen (no UI)  |
| libra  | Libra is the code name for the curation tools (curation.kpmp.org)  |
| microscopium  | Microscopium is the code name for the initial Atlas Demo (a cell-type centric view) (demo.kpmp.org/atlas)  |
| orion  | Orion is the code name for the Data Lake Uploader (upload.kpmp.org)  |
| pictor  | Pictor is the code name for the second Atlas Demo (gene search and violin plots) (demo.kpmp.org/gene-search)  |
| scutum  | Scutum is the code name for the Authentication Service   |

The images directory contains a set of shared docker images that we use across many of the projects.

## Instructions for setting up each project

### Ara

### Cassiopeia

### Circinus

### Delphinus

### Eridanus

### Libra

### Microscopium

### Orion 
  
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

### Pictor

### Scutum
