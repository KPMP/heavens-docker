# shib-sp

Starting point template for Shibboleth enabled Apache web server front-end.

# Instructions
In order to take this infrastructure from a starting point to runnable, you must make some changes in the Dockerfile, ApacheTemplate.conf, ShibbolethTemplate.xml files. In the files, described below, we use a `{ mustache }` syntax for templating to indicate where the implementer must provide their own values.

# Apache
Template File = `./container_files/etc/httpd/conf.d/virt.conf`

In the template file:
- `ServerName {DomainName}`
  - Insert your domain name here. Must match SSL cert.
  - E.G. upload.kpmp.org, specimen.kpmp.org.
- In `<VirtualHost *:80>` directive:
  - `ServerAlias {DomainName}`
     - Mimic above `{DomainName}`
     - E.G. upload.kpmp.org
  - `RewriteRule {DomainName}`
     - Mimic above `{DomainName}`
     - This handles HTTPS redirects.
- In `<VirtualHost *:443>` directive:
  - `ServerAlias {DomainName}`
     - Mimic above `{DomainName}`
     - E.G. upload.kpmp.org
  - `ProxyPassMatch "^/api\S*" {ServerApiUri}`
     - The fully qualified network address of the Api.
     - E.G. http://spring:3001
  - `ProxyPass / {ClientAppUri}`
     - The fully qualified network address of the Client.
     - E.G. http://node:3000

# Shibboleth
Template File = `./container_files/etc/shibboleth/shibboleth2.xml`

In the template file:
- In `ApplicationDefaults` element:
  - entityID attribute `{DomainName}`
  - Must match the Apache `{DomainName}` value above.

# Dockerfile
File = `./Dockerfile`

##### NB: All of the target files must be in the build context at imaging time.

In the `KPMP Specific Configuration section`:
- `{ApacheSSLCert}` path to the SSL Certificate file.
- `{ApacheSSLCertKey}` path to the SSL Certificate Key file.
- `{ShibbolethCert}` path to the Shibboleth Certificate file.
- `{ShibbolethCertKey}` path to the Shibboleth Certificate Key file.
