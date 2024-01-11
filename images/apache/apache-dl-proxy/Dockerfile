FROM httpd:2.4

SHELL ["/bin/bash", "-c"]

# Define args and set a default value
ARG maintainer=tier
ARG imagename=shibboleth_sp
ARG version=2.6.1

LABEL Build docker build --rm --tag $maintainer/$imagename .

# Add starters and installers
ADD ./container_files /opt

RUN apt update && apt-get upgrade -y --no-install-recommends
RUN apt install -y apache2 libapache2-mod-shib ntp --no-install-recommends
RUN apt install -y curl

RUN rm /etc/localtime \
      && chmod +x /opt/bin/httpd-shib-foreground \
      && chmod +x /opt/bin/shibboleth_keygen.sh
      
# Export this variable so that shibd can find its CURL library
RUN LD_LIBRARY_PATH="/opt/shibboleth/lib64"
RUN export LD_LIBRARY_PATH

#RUN chown -R shibd:shibd /etc/shibboleth/
#RUN chown -R shibd:shibd /var/cache/shibboleth/

#Script to start service, Added ssl default conf, Added shib module apache
RUN ln -s /opt/bin/httpd-shib-foreground  /usr/local/bin && ln -s /opt/etc/httpd/conf.d/ssl.conf /usr/local/apache2/conf/ssl.conf && ln -s /opt/etc/httpd/conf.d/virt.conf /usr/local/apache2/conf/virt.conf && ln -s /opt/etc/httpd/conf.modules.d/00-shib.conf /usr/local/apache2/conf/00-shib.conf && ln -s /usr/share/zoneinfo/America/Detroit /etc/localtime

# KPMP Specific Configuration - MAKE EDITS HERE
RUN curl https://ds.incommon.org/certs/inc-md-cert.pem -o /etc/ssl/certs/inc-md-cert.pem
COPY ./container_files/etc/shibboleth/attribute-map.xml /etc/shibboleth/attribute-map.xml

RUN echo "************** Built Apache WITH Shibboleth **************"

EXPOSE 80 443
ENTRYPOINT ["sh", "-c", "httpd-shib-foreground"]
