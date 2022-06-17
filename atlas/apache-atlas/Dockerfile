FROM centos:centos7.9.2009

# Add starters and installers
ADD ./container_files /opt

RUN   yum -y update \
      && yum -y install \
        httpd \
        mod_ssl \
        dos2unix \
      && yum clean all \
      && rm /etc/httpd/conf.d/autoindex.conf \
      && rm /etc/httpd/conf.d/ssl.conf \
      && rm /etc/httpd/conf.d/userdir.conf \
      && rm /etc/httpd/conf.d/welcome.conf


#Script to start service, Added ssl default conf, Added shib module apache
RUN ln -s /opt/bin/httpd-ssl-foreground  /usr/local/bin && ln -s /opt/etc/httpd/conf.d/ssl.conf /etc/httpd/conf.d/ssl.conf && ln -s /opt/etc/httpd/conf.d/virt.conf /etc/httpd/conf.d/virt.conf

RUN echo "************** Built Apache WITHOUT SSL **************"


EXPOSE 80 443

ENTRYPOINT ["sh", "-c", "httpd-ssl-foreground $ENV_APACHE_SERVER_NAME"]
