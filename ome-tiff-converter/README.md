# ome-tiff-converter

Converts tiffs or svs images into the ome-tiff format.

The project contains two key files, the Dockerfile and the process.sh as well as two folders,  toBeProcessed and processedData. Zipped or unzipped packages containing svs or tiff files can be placed into toBeProcessed and will be converted to ome-tiffs and placed into the processedData folder.

The dockerfile installs/contains project dependencies and runs the process.sh script.
The process.sh script looks at the toBeProcessed folder and if required will unzip any packages. It will then run the ome-tiff conversion step for each file in the package. It will then update the ome-tiff xml to set appropriate channel names 

## usage

1. Place package (with package's id as the foldername) into the toBeProcessedFolder

    (eg) - /toBeProcessed/c90c6596-2282-47ad-a284-d96db43c119a.zip

    (eg) - /toBeProcessed/c90c6596-2282-47ad-a284-d96db43c119a/A-3333-013188_FOO_1of2.tiff

2. Build the dockerfile:

    `$docker build -t kingstonduo/ome-tiff-converter:latest .`

3. Login to the docker instance and send the processed data to its final location:

    `$docker run -it kingstonduo/ome-tiff-converter:latest /bin/bash`

    3A. If sending to aws, configure your account:

    `$ aws configure set aws_access_key_id {aws_access_key_id} set aws_secret_access_key {aws_secret_access_key}`
    
    3B. If sending to aws, copy to s3:

    `$ aws s3 cp processed/{package_id}/ s3://knowledge-environment/{package_id}`

 
## helpers

`$ rebuild.sh` is available to assist with development, it combines the build and run steps of docker

```
docker build -t kingstonduo/ome-tiff-converter:latest .
docker run -it kingstonduo/ome-tiff-converter:latest /bin/bash
```