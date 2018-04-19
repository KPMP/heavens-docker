#!/bin/ash

set -e

if [[ "$SPRING_BOOT_ENVIRONMENT" == "test" ]]; then
	gradle test

	exit $?
fi

exec "$@"
