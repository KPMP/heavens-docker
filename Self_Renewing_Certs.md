How to Use Self-Renewing Certificates

1. Add these volumes to your Apache service definition
```
      - certbot-certs:/etc/letsencrypt                      
      - certbot-www:/var/www/certbot                       
```
