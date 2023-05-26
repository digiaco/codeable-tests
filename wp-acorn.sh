#!/usr/bin/sh

if [ "$#" -ne 1 ]; then
  echo ""
  echo "Usage: $0 \"Acorn command here\"" >&2
  exit 1
fi

docker-compose run --rm wp-cli wp acorn $1