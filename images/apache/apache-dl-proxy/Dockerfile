FROM oraclelinux:8.5

SHELL ["/bin/bash", "-c"]

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

RUN echo $'[shibboleth]\n\
name=Shibboleth (CentOS_7)\n\
type=rpm-md\n\
mirrorlist=https://shibboleth.net/cgi-bin/mirrorlist.cgi/CentOS_7\n\
gpgcheck=1\n\
gpgkey=https://shibboleth.net/downloads/service-provider/RPMS/repomd.xml.key\n\
        https://shibboleth.net/downloads/service-provider/RPMS/cantor.repomd.xml.key\n\
enabled=1' > /etc/yum.repos.d/shibboleth.repo

RUN yum -y update \
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
      && rm /etc/localtime \
      && chmod +x /opt/bin/httpd-shib-foreground \
      && chmod +x /opt/bin/shibboleth_keygen.sh
      
# Export this variable so that shibd can find its CURL library
RUN LD_LIBRARY_PATH="/opt/shibboleth/lib64"
RUN export LD_LIBRARY_PATH

RUN chown -R shibd:shibd /etc/shibboleth/
RUN chown -R shibd:shibd /var/cache/shibboleth/

#Script to start service, Added ssl default conf, Added shib module apache
RUN ln -s /opt/bin/httpd-shib-foreground  /usr/local/bin && ln -s /opt/etc/httpd/conf.d/ssl.conf /etc/httpd/conf.d/ssl.conf && ln -s /opt/etc/httpd/conf.d/virt.conf /etc/httpd/conf.d/virt.conf && ln -s /opt/etc/httpd/conf.modules.d/00-shib.conf /etc/httpd/conf.modules.d/00-shib.conf && ln -s /usr/lib64/shibboleth/mod_shib_24.so /etc/httpd/modules/mod_shib_24.so && ln -s /usr/share/zoneinfo/America/Detroit /etc/localtime

# KPMP Specific Configuration - MAKE EDITS HERE
RUN curl https://ds.incommon.org/certs/inc-md-cert.pem -o /etc/pki/tls/certs/inc-md-cert.pem
COPY ./container_files/etc/shibboleth/attribute-map.xml /etc/shibboleth/attribute-map.xml

RUN echo "************** Built Apache WITH Shibboleth **************"

EXPOSE 80 443
ENTRYPOINT ["sh", "-c", "httpd-shib-foreground"]
