# Spring image builds

## Introduction

In order to build an image:
  
    $ docker-compose build
    $ docker images
    REPOSITORY                                      TAG                     IMAGE ID            CREATED             SIZE
    spring                                          latest              80b446cad51a        6 weeks ago         260MB
    ...    


    ## Capture the Image Id of the most recent image in the list.
    $ docker tag 80b446cad51a kingstonduo/kpmp-spring
    $ docker push kingstonduo/kpmp-spring
