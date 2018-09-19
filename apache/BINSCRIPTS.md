# util

This repository is intended to be downloaded into a container repository during development for convenience purposes.  Since the major mechanisms of developing to the Docker container construction lifecycle are identical across container images, this repository allows for consistency and additional ease of use across all container images.

## Install

If you are reading this file in BINSCRIPTS.md, your container project is likely to be util-enabled.

To use these scripts yourself, issue this command:

```
curl "https://github.internet2.edu/raw/docker/util/master/bin/install.sh?token=AAAAETsVKUnOEAMM8TvUUZccPYi13wsnks5Xq46jwA%3D%3D" | bash
```

### common.bash

The installation process will create a common.bash file.  This file should be the central, canonical authority for management of environment variables.  While a subprocess may override them, the files in common.bash should be treated as authoritative defaults.  Processes (e.g. `docker build`, `bats`, inside `Jenkinsfile`) can read this file and process the results therein.

You should edit this file to change the image name, and add any other helpful environment variables.

### Jenkinsfile

This will also install a Jenkinsfile to your repository, if it doesn't have one.  This will ensure that your Jenkins pipeline can leverage these scripts in the way intended.  Ensuring the commands that you issue on your laptop match the commands issued by the build pipeline is critical to ensure predictable, reliable results.

## Use


### Building

#### build.sh
`bin/build.sh `
#### destroy.sh
#### rebuild.sh

### Running
### rerun.sh
### run.sh


### Testing
#### test.sh