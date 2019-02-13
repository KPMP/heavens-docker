# Apache image builds

## Introduction

This directory is a set of Dockerfiles and a build script for creating our apache images.

There are three directories:

* apache-shib
  * Contains apache configuration using mod-shib and https.  All of the certificates are stored on the host machine.
* apache-ssl
  * Contains apache configuration using just https. All certificates are stored on the host machine. 
* apache-basic
  * Contains apache configuration with no mod-shib and no https.  This is used for local workstations
* apache-shib-demo
  * Contains the apache configuration using mod-shib, https, and rewrites specifically for `demo.kpmp.org` and its environments.

In order to build an image:
  
    ## Edit the .env file and set ENV_APACHE_TARGET to point at the directory containing the image you want to build.  
    $ vi .env
    $ docker-compose build
    $ docker images
    REPOSITORY                                      TAG                     IMAGE ID            CREATED             SIZE
    orion-docker_apache                             latest                  cb7c4dc7573f        6 days ago          548MB
    kingston-duo/apache                             apache-basic            615e894067ef        6 days ago          548MB
    kingstonduo/apache                              apache-basic            615e894067ef        6 days ago          548MB
    ...    

    ## Capture the Image Id of the most recent image in the list.

    $ docker tag cb7c4dc7573f kingstonduo/apache:apache-shib
        OR
    $ docker tag cb7c4dc7573f kingstonduo/apache:apache-basic
    $ docker push kingstonduo/apache:apache-shib
