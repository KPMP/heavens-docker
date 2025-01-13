FROM ubuntu:20.04

# Add starters and installers
ADD ./container_files /opt
ENV DEBIAN_FRONTEND=noninteractive

RUN   apt-get -y update \
      && apt-get -y install --no-install-recommends \
        ca-certificates \
        apache2 \
        apache2-utils \
        openssl \
        dos2unix \
        libapache2-mod-evasive \
      && rm /etc/apache2/mods-available/*.conf \
      && rm /etc/apache2/conf-enabled/*.conf \
      && a2enmod ssl \
      && a2enmod proxy \
      && a2enmod proxy_http \ 
      && a2enmod rewrite \
      && a2enmod headers \
      && a2enmod evasive \
      && a2enmod proxy_balancer \
      && a2enmod lbmethod_bybusyness \
      && a2enmod status 


#Script to start service, Added ssl default conf, Added shib module apache
RUN ln -s /opt/bin/apache2-ssl-foreground /usr/local/bin \
    && ln -s /opt/etc/apache2/conf-enabled/ssl.conf /etc/apache2/conf-enabled/ssl.conf \
    && ln -s /opt/etc/apache2/conf-enabled/virt.conf /etc/apache2/conf-enabled/virt.conf \
    && ln -s /etc/mime.types /etc/apache2/mime.types

RUN rm /etc/apache2/mods-enabled/evasive.conf \
    && cp /opt/evasive.conf /etc/apache2/mods-enabled/evasive.conf 

RUN echo "************** Built Apache WITH SSL **************"

EXPOSE 80 443

ENTRYPOINT ["sh", "-c", "/opt/bin/httpd-ssl-foreground $ENV_APACHE_SERVER_NAME $ENV_ARRANGER_SERVER_ADDRESS $ENV_FILE_SERVER_ADDRESS $ENV_EXPLORER_DATA_SERVER_ADDRESS"]
