FROM tier/centos7base

# paused on this for the moment



# Add Conda
RUN yum -y update \
    && yum -y install curl bzip2 execstack unzip xmlstarlet python3-pip \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local/ \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3 \
    && conda update conda \
    && conda clean --all --yes \
    && rpm -e --nodeps curl bzip2 \
    && yum clean all

RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" 
RUN unzip awscli-bundle.zip 
RUN python3 ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

RUN wget https://downloads.openmicroscopy.org/latest/bio-formats5.8/artifacts/bftools.zip \
    && unzip bftools.zip \
    && rm -rf bftools.zip

RUN conda create --name bioformats python=3.8
RUN conda install -c ome bioformats2raw raw2ometiff

ADD toBeProcessed/ toBeProcessed/
RUN mkdir processedData

# create OME-TIFF
COPY process.sh process.sh