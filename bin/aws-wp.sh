#!/usr/bin/env sh

if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

if [ 'true' == ${USE_EXTERNAL_ASSETS} ]
then
aws s3api put-object --bucket ${ASSETS_BUCKET} --key app/${WP_HOST}/
fi