# How to Use Self-Renewing Certificates

1. Add these volumes to your Apache service definition in the docker-compose.yml:
```
      - certbot-certs:/etc/letsencrypt                      
      - certbot-www:/var/www/certbot                       
```

2. Add the Certbot service and volumes to share the certificates to the docker-compose.yml:
```
  certbot:
    image: certbot/certbot
    container_name: certbot-service
    volumes:
      - certbot-certs:/etc/letsencrypt                      # shared with apache
      - certbot-www:/var/www/certbot                        # shared with apache
    entrypoint: /bin/sh
    command: ["-c", "trap exit TERM; while :; do certbot renew --webroot -w /var/www/certbot --quiet; sleep 12h & wait $!; done"]
    networks:
      local:

volumes:
  certbot-certs:
  certbot-www:
```

4. Add these lines (or edit existing VirtualHost directive) in the Apache config to allow Certbot to issue challenges, replacing [DOMAIN] with the host's domain:
```
<VirtualHost *:80>
  ServerName [DOMAIN]

  Alias /.well-known/acme-challenge/ /var/www/certbot/.well-known/acme-challenge/
  <Directory /var/www/certbot/.well-known/acme-challenge/>
    Options None
    AllowOverride None
    Require all granted
  </Directory>

  RewriteEngine on
  RewriteCond %{HTTPS} off
  RewriteCond %{REQUEST_URI} !^/.well-known/acme-challenge/
</VirtualHost>
```

5. Add/edit location of certificates in the Apache config file (usually the port 443 VirtualHost), replacing the [DOMAIN] with the host's domain:
```
  SSLCertificateFile    /etc/letsencrypt/live/[DOMAIN]/fullchain.pem
  SSLCertificateKeyFile /etc/letsencrypt/live/[DOMAIN]/privkey.pem
```

6. Bring down the Docker stack and bring it back up, which should also bring up the Certbot service:
```
docker compose [-f file] down
docker compose [-f file] up -d
```

7. Issue the certificate, replacing [DOMAIN] with the host's domain:
`docker exec certbot-service certbot certonly   --webroot -w /var/www/certbot   -d [DOMAIN]   --email kpmp-devs@umich.edu   --agree-tos --no-eff-email   --force-renewal`
 
8. Restart Apache:
`docker compose -f docker-compose.prod.yml restart apache`

9. Verify the site has working SSL and the certificate is from Let's Encrypt.

10. Set up a cron job to refresh the certificate periodically, replacing the [APACHE-SERVICE-NAME] with the service name, e.g. "repository-apache"
```
0 3 * * * docker exec [APACHE-SERVICE-NAME] apachectl graceful
```

