#!/usr/bin/env sh

if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

### Importing DB
if [ -z "$(ls -A dump/)" ];
then
  echo "Dump not set, sciping ..."
  exit
else
  echo "Importing DB dump ..."
  wp db import dump/dump.sql
  wp search-replace 'http://localhost' ${WP_URL} --skip-columns=guid
  wp option update siteurl ${WP_URL}
  wp option update home ${WP_URL}
  wp db check
fi