FROM centos:centos8.4.2105

# Add starters and installers

ENV NODE_VERSION=12.22.1
RUN   yum -y update
RUN yum install -y curl
RUN yum install -y git
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

ENV NVM_DIR="$HOME/.nvm"

RUN . "$NVM_DIR/nvm.sh" && nvm install v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm --version 
ENV PATH="$NVM_DIR/versions/node/v${NODE_VERSION}/bin/:${PATH}"

WORKDIR $HOME
RUN . "$NVM_DIR/nvm.sh" && git clone https://github.com/vitessce/vitessce.git
RUN export NODE_OPTIONS=--max_old_space_size=4096
WORKDIR "$HOME/vitessce"
RUN . "$NVM_DIR/nvm.sh" && npm install
RUN yum clean all

EXPOSE 3000

CMD [ "node", "scripts/start-demo.js" ]
