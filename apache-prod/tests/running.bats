#!/usr/bin/env bats

load ../common

# These tests assume the pipeline will start and stop the container.

@test "Leaves running process" {
  result="$(docker ps | grep $imagename)"
  [ "$result" != '' ]
}

@test "Exposes running HTTP service" {
  result="$(docker exec -i $imagename curl http://localhost/)"
  [ "$result" != '' ]
}

@test "Exposes running SSO process" {
  result="$(docker exec -i $imagename curl http://localhost/Shibboleth.sso/Status)"
  [ "$result" != '' ]
}