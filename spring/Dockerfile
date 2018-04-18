FROM openjdk:8-jdk-stretch

SHELL ["/bin/bash", "-lc"]

RUN apt-get update && apt-get install -y --no-install-recommends \
	curl \
	zip \
	unzip \
	&& rm -rf /var/lib/apt/lists/*
RUN curl -s "https://get.sdkman.io" | bash
RUN source "$HOME/.sdkman/bin/sdkman-init.sh"
RUN sdk install gradle 4.6

WORKDIR /build

COPY ./gradle/spring-boot.build.gradle /build/build.gradle
VOLUME ["/build"]
EXPOSE 8080
CMD java -jar build.jar
