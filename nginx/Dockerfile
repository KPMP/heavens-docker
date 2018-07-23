FROM nginx:1.15

RUN mkdir -p /run/user/nginx-cache && mkdir /run/user/nginx-cache-tmp
RUN rm -f /etc/nginx/sites-enabled/*
COPY ./config/ /etc/nginx
RUN ln -s /etc/nginx/sites-available/* /etc/nginx/sites-enabled/

EXPOSE 80 443

CMD ["nginx"]