#!/usr/bin/env sh

if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

if [ 'true' == ${USE_EXTERNAL_DATABASE} ]
then

mysql --user=${MYSQL_RDS_USER} --password=${MYSQL_RDS_PASSWORD} --host=${MYSQL_RDS_HOST} --database=${MYSQL_RDS_NAME} --execute="CREATE DATABASE IF NOT EXISTS ${WP_HOST//./_};"
fi