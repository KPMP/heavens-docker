FROM gradle:4.6-jdk8-alpine

USER root

RUN mkdir /build

COPY ./gradle/spring-boot.build.gradle /home/gradle/build.gradle
COPY ./entrypoint.sh /build/entrypoint.sh

USER gradle

EXPOSE 8080 3030

ENTRYPOINT ["/build/entrypoint.sh"]
CMD ["gradle", "bootRun"]
