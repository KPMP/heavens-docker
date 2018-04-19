#!/bin/bash

set -e

npm install

if [[ $NODE_ENV == "test" ]]; then
	npm test

	exit $?
fi

exec "$@"
