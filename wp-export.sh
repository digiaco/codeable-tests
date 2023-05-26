#!/usr/bin/sh

docker-compose run --rm wp-cli wp db export - > dump/dump.sql