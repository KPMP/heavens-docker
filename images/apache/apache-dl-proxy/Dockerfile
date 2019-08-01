FROM tier/centos7base

# Define args and set a default value
ARG maintainer=tier
ARG imagename=shibboleth_sp
ARG version=2.6.1

LABEL Maintainer=$maintainer
LABEL Vendor="Internet2"
LABEL ImageType="Base"
LABEL ImageName=$imagename
LABEL ImageOS=centos7
LABEL Version=$version

LABEL Build docker build --rm --tag $maintainer/$imagename .

# Add starters and installers
ADD ./container_files /opt

RUN curl -o /etc/yum.repos.d/security:shibboleth.repo \
      http://download.opensuse.org/repositories/security://shibboleth/CentOS_7/security:shibboleth.repo \
      && yum -y update \
      && yum -y install \
        httpd \
        mod_ssl \
        shibboleth.x86_64 \
        dos2unix \
      && yum clean all \
      && rm /etc/httpd/conf.d/autoindex.conf \
      && rm /etc/httpd/conf.d/ssl.conf \
      && rm /etc/httpd/conf.d/userdir.conf \
      && rm /etc/httpd/conf.d/welcome.conf \
      && chmod +x /opt/bin/httpd-shib-foreground \
      && chmod +x /opt/bin/shibboleth_keygen.sh
      
# Export this variable so that shibd can find its CURL library
RUN LD_LIBRARY_PATH="/opt/shibboleth/lib64"
RUN export LD_LIBRARY_PATH

#Script to start service, Added ssl default conf, Added shib module apache
RUN ln -s /opt/bin/httpd-shib-foreground  /usr/local/bin && ln -s /opt/etc/httpd/conf.d/ssl.conf /etc/httpd/conf.d/ssl.conf && ln -s /opt/etc/httpd/conf.d/virt.conf /etc/httpd/conf.d/virt.conf && ln -s /opt/etc/httpd/conf.modules.d/00-shib.conf /etc/httpd/conf.modules.d/00-shib.conf && ln -s /usr/lib64/shibboleth/mod_shib_24.so /etc/httpd/modules/mod_shib_24.so

# KPMP Specific Configuration - MAKE EDITS HERE
COPY ./certs/inc-md-cert.pem /etc/pki/tls/certs/inc-md-cert.pem
COPY ./container_files/etc/shibboleth/attribute-map.xml /etc/shibboleth/attribute-map.xml

RUN echo "************** Built Apache WITH Shibboleth **************"

EXPOSE 80 443
ENTRYPOINT ["sh", "-c", "httpd-shib-foreground"]
