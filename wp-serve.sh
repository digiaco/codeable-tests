#!/usr/bin/env sh

RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

if [ -f .env ]; then
  export $(echo $(cat .env | sed 's/#.*//g'| xargs) | envsubst)
fi

# A bash script to update a Cloudflare DNS A record with the external IP of the source server

# Check jq command
if ! command -v jq > /dev/null
then
    echo "jq could not be found, try to install"
    sudo apt update
    sudo apt install -y jq
    jq --version
fi

# Cloudflare zone is the zone which holds the record
zone=${CLOUDFLARE_ZONE}
# dnsrecord is the A record which will be updated
dnsrecord=${WP_HOST}

## Cloudflare authentication details
## keep these private
cloudflare_auth_email=${CLOUDFLARE_EMAIL}
cloudflare_auth_key=${CLOUDFLARE_AUTH_KEY}
cloudflare_a_ip=${CLOUDFLARE_A_IP}

# get the zone id for the requested zone
zoneid=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$zone&status=active" \
  -H "X-Auth-Email: $cloudflare_auth_email" \
  -H "Authorization: Bearer $cloudflare_auth_key" \
  -H "Content-Type: application/json" | jq -r '{"result"}[] | .[0] | .id')

echo -e "${GREEN}Zone id for $zone is $zoneid ${ENDCOLOR}"

# get the dns record id
dnsrecordid=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zoneid/dns_records?type=A&name=$dnsrecord" \
  -H "X-Auth-Email: $cloudflare_auth_email" \
  -H "Authorization: Bearer $cloudflare_auth_key" \
  -H "Content-Type: application/json" | jq -r '{"result"}[] | .[0] | .id')

  # Add the new record if not exist
if [ $dnsrecordid = "null" ]
then
  newrecord=$(curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$zoneid/dns_records" \
  -H "X-Auth-Email: $cloudflare_auth_email" \
  -H "Authorization: Bearer $cloudflare_auth_key" \
  -H "Content-Type: application/json" \
  --data "{\"type\":\"A\",\"comment\":\"Added from server\",\"name\":\"$dnsrecord\",\"content\":\"$cloudflare_a_ip\",\"ttl\":1,\"proxied\":true}" | jq -r '{"result"}[] | .[0] | .id')
else
   echo "${GREEN}DNS record id for $dnsrecord exist${ENDCOLOR}"
fi

# Remove nginx config if exist
sudo rm -rf /etc/nginx/sites-available/${WP_HOST}
sudo rm -rf /etc/nginx/sites-enabled/${WP_HOST}

# Copy nginx config from pattern
sudo sed -e "s/%sitename%/${WP_HOST}/g" -e "s/%port%/${WORDPRESS_PORT}/" -e "s/%phpmyadmin_port%/${PHPMYADMIN_PORT}/" configuration/vhost_config > /etc/nginx/sites-available/${WP_HOST}

sudo ln -s -f /etc/nginx/sites-available/${WP_HOST} /etc/nginx/sites-enabled/
cat /etc/nginx/sites-available/${WP_HOST}

# Test and restart nginx
sudo nginx -t
sudo service nginx restart

# Chmod content files 
sudo chmod -R 775 wp_data 
sudo chown -R ubuntu:www-data wp_data 

echo -e "${GREEN}Your site url: ${WP_URL}${ENDCOLOR}"
echo -e "${GREEN}Yuor DB manager: ${WP_URL}/pma/${ENDCOLOR}"