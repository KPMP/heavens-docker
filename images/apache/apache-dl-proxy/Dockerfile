FROM debian:bookworm-slim@sha256:jsdljsdjo;sdfjln

SHELL ["/bin/bash", "-c"]

ADD ./container_files /opt

RUN apt-get -qq update && \
    apt-get -qq -y --no-install-recommends install \
        apache2 \
        libapache2-mod-shib \
        curl \
        openssl \ 
        && rm -rf /var/lib/apt/lists/*

RUN rm /etc/localtime \
    && chmod +x /opt/bin/httpd-shib-foreground \
    && chmod +x /opt/bin/shibboleth_keygen.sh
	  
# Export this variable so that shibd can find its CURL library
RUN LD_LIBRARY_PATH="/opt/shibboleth/lib64"
RUN export LD_LIBRARY_PATH

RUN chown -R _shibd:_shibd /etc/shibboleth/
RUN chown -R _shibd:_shibd /var/cache/shibboleth/

RUN ln -s /opt/bin/httpd-shib-foreground /usr/local/bin && ln -s /opt/etc/httpd/conf.d/ssl.conf /etc/apache2/conf-enabled/ssl.conf && ln -s /opt/etc/httpd/conf.d/virt.conf /etc/apache2/conf-enabled/virt.conf && ln -s /usr/share/zoneinfo/America/Detroit /etc/localtime
RUN cp /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled && cp /etc/apache2/mods-available/socache_shmcb.load /etc/apache2/mods-enabled && cp /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled && cp /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled && cp /etc/apache2/mods-available/proxy.load /etc/apache2/mods-enabled && cp /etc/apache2/mods-available/proxy_http.load /etc/apache2/mods-enabled

RUN curl -k https://ds.incommon.org/certs/inc-md-cert.pem -o /etc/ssl/certs/inc-md-cert.pem
COPY ./container_files/etc/shibboleth/attribute-map.xml /etc/shibboleth/attribute-map.xml

RUN echo "************** Built Apache WITH Shibboleth **************"

EXPOSE 80 443
ENTRYPOINT ["sh", "-c", "httpd-shib-foreground"]
