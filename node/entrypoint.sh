#!/bin/bash

set -e

npm install

if [[ $NODE_ENV == "test" ]]; then
	CI=true npm test

	exit $?
fi

exec "$@"
