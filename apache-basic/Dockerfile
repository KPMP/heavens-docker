FROM tier/centos7base

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
RUN ln -s /opt/etc/httpd/conf.d/ssl.conf /etc/httpd/conf.d/ssl.conf && ln -s /opt/etc/httpd/conf.d/virt.conf /etc/httpd/conf.d/virt.conf

#Optional - HTTPS not required on dev
# COPY { ApacheSSLCert } /etc/pki/tls/certs/kpmp.crt
# COPY { ApacheSSLCertKey } /etc/pki/tls/private/kpmp.key
# RUN chmod 600 /etc/pki/tls/private/kpmp.key
#Optional

EXPOSE 80 443

ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
