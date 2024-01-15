FROM debian:buster-slim

SHELL ["/bin/bash", "-c"]

LABEL Build docker build --rm --tag kingstonduo/apache-dl-proxy/apache-upgrade .

# Add starters and installers
ADD ./container_files /opt

RUN apt-get -qq update && \
    apt-get -qq -y --no-install-recommends install \
        apache2 \
        libapache2-mod-shib2 && \
    rm -rf /var/lib/apt/lists/*

RUN rm /etc/localtime \
      && chmod +x /opt/bin/httpd-shib-foreground \
      && chmod +x /opt/bin/shibboleth_keygen.sh \
      && rm /etc/apache2/httpd.conf \
      && a2enmod shib2
	  
# Export this variable so that shibd can find its CURL library
RUN LD_LIBRARY_PATH="/opt/shibboleth/lib64"
RUN export LD_LIBRARY_PATH

RUN chown -R _shibd:_shibd /etc/shibboleth/
RUN chown -R _shibd:_shibd /var/cache/shibboleth/

#Script to start service, Added ssl default conf, Added shib module apache
RUN ln -s /opt/bin/httpd-shib-foreground  /usr/local/bin && ln -s /opt/etc/httpd/conf.d/ssl.conf /etc/apache2/ssl.conf && ln -s /opt/etc/httpd/conf.d/virt.conf /etc/apache2/virt.conf && ln -s /usr/share/zoneinfo/America/Detroit /etc/localtime && ln -s /opt/etc/httpd/conf.d/httpd.conf /etc/apache2/httpd.conf

# KPMP Specific Configuration - MAKE EDITS HERE
RUN curl https://ds.incommon.org/certs/inc-md-cert.pem -o /etc/ssl/certs/inc-md-cert.pem
COPY ./container_files/etc/shibboleth/attribute-map.xml /etc/shibboleth/attribute-map.xml

RUN echo "************** Built Apache WITH Shibboleth **************"

EXPOSE 80 443
ENTRYPOINT ["sh", "-c", "httpd-shib-foreground"]
