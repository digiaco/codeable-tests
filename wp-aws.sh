#!/usr/bin/sh

if [ "$#" -ne 1 ]; then
  echo ""
  echo "Usage: $0 \"wp-aws command here\"" >&2
  exit 1
fi

docker-compose run --rm aws-cli $1