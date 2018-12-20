# Apache image builds

## Introduction

This directory is a set of Dockerfiles and a build script for creating our apache images.

There are two directories:

* apache-shib
  * Contains apache configuration using mod-shib and https.  All of the certificates are stored on the host machine.
* apache-ssl
  * Contains apache configuration using just https. All certificates are stored on the host machine. 
* apache-basic
  * Contains apache configuration with no mod-shib and no https.  This is used for local workstations

In order to build an image:

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
