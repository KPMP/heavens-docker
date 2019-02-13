FROM kingstonduo/apache:apache-shib

# Define args and set a default value
ARG maintainer=tier
ARG imagename=shibboleth_sp
ARG version=2.6.1
ARG ENV_APACHE_SERVER_NAME

LABEL Maintainer=$maintainer
LABEL Vendor="Internet2"
LABEL ImageType="Base"
LABEL ImageName=$imagename
LABEL ImageOS=centos7
LABEL Version=$version

LABEL Build docker build --rm --tag $maintainer/$imagename .

# Add starters and installers
ADD ./container_files /opt

RUN echo "************** Built Apache WITH Shibboleth **************"

EXPOSE 80 443
ENTRYPOINT ["sh", "-c", "httpd-shib-foreground $ENV_APACHE_SERVER_NAME"]
