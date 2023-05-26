#!/usr/bin/sh
docker-compose run --rm aws-cli  sh -c 'sh /usr/local/bin/aws-wp' 
docker-compose run --rm mysql sh -c 'sh /usr/local/bin/mysql-wp'
docker-compose run --rm wp-cli sh -c 'sh /usr/local/bin/install-wp'

