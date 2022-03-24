# Atlas and Knowledge Environment Docker

## Development

The development Docker Compose versions (docker-compose.dev.yml) of the Repository and Explorer require the Knowledge Environment stack. Either start the KE stack first or use the explorer-dev.sh and repository-dev.sh files. Any arguments are passed to the docker-compose execution, so to bring up the Explorer dev stack you'd execute:
- `./explorer-dev.sh up -d'

## Adding new applications under atlas

When adding a new application that isn't apart of the pegasus-web build, you must update the apache-atlas-ssl virt.vonf file along with the repository .env file for the specific app

## Environment Configuration

The .env file needs an AWS IAM user and access key/secret that has permissions to the bucket also named in the .env file:
- ENV_MINIO_ACCESS_KEY
- ENV_MINIO_SECRET_KEY
- ENV_BUCKET_NAME

## Overview
You will note that there are no docker-compose files right under the atlas directory. That is because this application runs on two separate machines. One is the web server, which will run the docker-compose found under the repository directory. The other server is the service layer, which will run the docker-compose found under the knowledge-environment directory.

Under knowledge-environment, we now have 3 docker-compose files. The -prod is used on QA/Dev/Prod machines to run the application in standard mode. The -dev compose file is used to bring up arranger-ui and the atlas-index-creation-worker so that we can either make changes to the ES indexing or we can recreate the ES indices. The -local compose is used to run on your local machine. It only runs a single ES node since they are very resource intensive.

## Setting up on your local machine
When running this project on your local machine, if you want to interact with the application, you have a few options.

### Connecting to qa-atlas KE (knowledge-environment)
At the moment, we have figured out how to run Atlas Explorer using the QA db rather than a local copy. In order to do so, you will need to modify your .env to change the following attributes:

    ENV_MYSQL_HOST=<GET QA IP ADDRESS FROM AWS OR FELLOW DEVELOPER>
    ENV_MYSQL_PASSWORD=<GET PASSWORD FROM PASSWORD VAULT>

This will NOT point your Atlas Repository at QA, however.

### Running your own KE
Since we haven't figured out how to point our Atlas Repositories at the QA KE, and since sometimes we need to do work on the database or ES indices, we need a way to run this locally.

We have created a -local compose script under knowledge-environment that is much more resource friendly to our local machines. It only runs a single ES node. In order to set up your initial application, you will need to go into the knowledge-environment project and open up the file under es-indices called elastic_search_index.txt and run the command within to create your ES index.

You can then either do an elasticdump from QA or Prod and import that into your local instance, or you can grab data from the QA or Prod db and populate that to run the index-creation-worker to populate your ES indices.
