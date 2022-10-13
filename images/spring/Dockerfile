FROM node:12-alpine3.15

CMD ["gradle"]

ENV GRADLE_HOME /opt/gradle
ENV GRADLE_VERSION 7.4

RUN apk add openjdk8
ARG GRADLE_DOWNLOAD_SHA256=e66e69dce8173dd2004b39ba93586a184628bc6c28461bc771d6835f7f9b0d28
RUN wget -O gradle.zip "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip"
RUN set -o errexit -o nounset \
	&& echo "Installing build dependencies" \
	&& apk add --no-cache --virtual .build-deps \
		ca-certificates \
		openssl \
		unzip \
        && unzip gradle.zip \
	&& rm gradle.zip \
	&& mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/" \
	&& ln -s "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle 
RUN apk del .build-deps \
	\
	&& echo "Adding gradle user and group" \
	&& addgroup -S -g 1001 gradle \
	&& adduser -D -S -G gradle -u 1001 -s /bin/ash gradle \
	&& mkdir /home/gradle/.gradle \
	&& chown -R gradle:gradle /home/gradle \
	\
	&& echo "Symlinking root Gradle cache to gradle Gradle cache" \
	&& ln -s /home/gradle/.gradle /root/.gradle \
        && apk add --no-cache tzdata \
	&& apk add --no-cache rsync 

# Create Gradle volume
VOLUME "/home/gradle/.gradle"
WORKDIR /home/gradle

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
RUN apk update && apk add bash && apk add libstdc++ && apk add curl \
	&& npm install mongodb@3.7.2 -g && npm install assert -g && npm install uuid -g \
	&& npm install md5-file -g && npm install axios -g 

ENV LC_ALL=C
ENV NODE_PATH=/usr/local/lib
RUN cp /usr/share/zoneinfo/America/Detroit /etc/localtime
RUN echo "America/Detroit" > /etc/timezone

# Commenting out because this started causing permissions problems during build.
#USER gradle

RUN set -o errexit -o nounset \
	&& echo "Testing Gradle installation" \
	&& gradle --version

EXPOSE 8080 3030

CMD ["gradle", "bootRun"]
