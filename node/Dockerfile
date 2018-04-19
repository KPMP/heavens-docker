FROM node:8.7

ENV DEBIAN_FRONTEND=noninteractive

RUN npm i -g pm2
RUN mkdir /build
COPY ./entrypoint.sh /build/entrypoint.sh

WORKDIR /usr/src/app

EXPOSE 3000
ENTRYPOINT ["/build/entrypoint.sh"]
CMD ["npm", "start"]
