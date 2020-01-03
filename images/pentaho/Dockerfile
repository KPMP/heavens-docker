FROM java:jre

ENV PDI_RELEASE=8.3 \
    PDI_VERSION=pdi-ce-8.3.0.0-371 \
    PDI_HOME=/opt/pentaho-di \
    KETTLE_HOME=/pentaho-di

RUN curl -k -L -o /tmp/${PDI_VERSION}.zip \
      https://phoenixnap.dl.sourceforge.net/project/pentaho/Pentaho%208.3/client-tools/${PDI_VERSION}.zip && \
    unzip -q /tmp/${PDI_VERSION}.zip -d $PDI_HOME && \
    rm /tmp/${PDI_VERSION}.zip

ENV PATH=$PDI_HOME/data-integration:$PATH

EXPOSE 8080

RUN mkdir -p $KETTLE_HOME/.kettle /docker-entrypoint.d /templates

COPY ./carte_config.xml $KETTLE_HOME/carte_config.xml

COPY ./repositories.xml $KETTLE_HOME/.kettle/repositories.xml

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["carte.sh", "/pentaho-di/carte_config.xml"]