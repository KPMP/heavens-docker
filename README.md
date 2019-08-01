# Heavens-docker

This repository holds all of the docker-compose.yml files and Dockerfiles needed for the various KPMP applications developed at UMich.

|  **Directory Name** | **Description**   |
| ------------ | ------------ |
| ara  | Ara is the log aggregator.  It is intended to be a central repository for logs from the various apps hosted at UMich  |
| cassiopeia  | Cassiopeia is the code name for the Participant Whole Slide Image Viewer (mydata.kpmp.org)  |
| circinus | Circinus is the code name for the KPMP Demo site (demo.kpmp.org) |
| dataLakeProxyServer | Since we are running the datamanager tools and the DLU on the same machine, we needed a proxy server running to handle the requests.  This is that |
| delphinus  |  Delphinus is the code name for the Digital Pathology Repository (or DPR) (currently at demo.kpmp.org/dpr)  |
| eridanus  | Eridanus is the code name for the notification service. It is intended to notify individuals when particular events happen (no UI)  |
| images | This directory stores common docker images that we share across projects.  When we build an image, we store it on DockerHub |
| libra  | Libra is the code name for the datamanager tools (datamanager.kpmp.org)  |
| microscopium  | Microscopium is the code name for the initial Atlas Demo (a cell-type centric view) (demo.kpmp.org/atlas)  |
| orion  | Orion is the code name for the Data Lake Uploader (upload.kpmp.org)  |
| pictor  | Pictor is the code name for the second Atlas Demo (gene search and violin plots) (demo.kpmp.org/gene-search)  |
| scutum  | Scutum is the code name for the Authentication Service   |


Instructions on how to set up each project will be in individual README files under each directory.

There are a few directories that have a docker-compose.yml file and a dev-docker-compose.yml file.  The dev-docker-compose.yml file is intended
for developers to use on their local machines and will simplify running some of the projects.  If there is no dev-docker-compose.yml file, 
you can and should just use the docker-compose.yml file in the directory.

## Developer notes

Instructions on how to get your machine set up to run Docker for these projects
- Download and install Docker
- Launch Docker
- Go to Preferences
-- Go to the Advanced tab and change your memory to 4GB
-- (on a mac) Go to the File Sharing tab and at leas add your base directory (/Users)
-- (on a PC) Go to the Shared Drives tab and check the box next to the C drive
-- (on a PC) run 'set COMPOSE_CONVERT_WINDOWS_PATHS=1'
- Apply & restart docker

### Relationships between projects

Many of the projects are stand-alone, however there are increasingly more projects that are run in conjunction with one another.


#### Data Lake Suite

dataLakeProxyServer contains the Apache server and configuration for Shibboleth.  It also starts the dataLake network.

orion uses the dataLake network and is served from the dataLakeProxyServer Apache
libra uses the dataLake network and is served from the dataLakeProxyServer Apache. It also uses the mongo db created in orion
eridanus uses the dataLake network. It also uses the mongo db created in orion
      
