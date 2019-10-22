FROM httpd:2.4-alpine
COPY ./container_files/apache2/htdocs /usr/local/apache2/htdocs/
COPY ./container_files/apache2/conf/  /usr/local/apache2/conf/
ENTRYPOINT ["/usr/local/apache2/bin/httpd", "-D", "FOREGROUND"]
