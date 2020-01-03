# Metadata Validation Service
This is a Docker container running a Pentaho Carte server for remote execution of Pentaho jobs and transformations. It is based on the Docker container here: https://github.com/aloysius-lim/docker-pentaho-di

## Mounted Directories in .env File
* The ENV_DATALAKE_FILE_DIR setting should point to the location of the Data Lake files.
* The ENV_PENTAHO_SCRIPT_DIR setting should point the location of the Pentaho scripts. 

## Running in Dev Mode
When you run this in dev mode, it exposes the port to the host for testing. In prod mode it's only available within the Docker dataLake network. 

## Authentication
Authentication uses basic HTTP authentication with the username and password "cluster".

## API Documentation
https://help.pentaho.com/Documentation/8.2/Developer_Center/REST_API/Carte

### Basic Commands
* Run a transformation: http://metadata-validation:8080/kettle/runTrans/?trans=transformation_name&level=Debug
* Get status of all jobs and transformations (HTML): http://metadata-validation:8080/kettle/status
* Get status of transformation (XML): http://metadata-validation:8080/kettle/transStatus/?name=transformation_name&xml=Y
