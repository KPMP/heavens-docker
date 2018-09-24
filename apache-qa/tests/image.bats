#!/usr/bin/env bats

load ../common

@test "Shibd binary available" {
  docker run -i $maintainer/$imagename find /usr/sbin/shibd
}

@test "Shibboleth root available" {
  docker run -i $maintainer/$imagename find /etc/shibboleth
}

@test "Sample attribute map available" {
  docker run -i $maintainer/$imagename find /opt/etc/shibboleth/attribute-map.xml
}

@test "Includes InCommon cert" {
  docker run -i $maintainer/$imagename find /opt/etc/shibboleth/inc-md-cert.pem
}

@test "Includes Shibboleth keygenerator" {
  docker run -i $maintainer/$imagename find /opt/bin/shibboleth_keygen.sh
}

@test "Includes httpd + shibd startup script" {
  docker run -i $maintainer/$imagename find /opt/bin/httpd-shib-foreground
}