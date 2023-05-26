#!/usr/bin/env sh

site_port=$(comm -23 <(seq 3000 3500) <( ss -tan | awk '{print $4}' | cut -d':' -f2 | grep "[0-9]\{1,5\}" | sort | uniq) | shuf | head -n 1)
pma_port=$(comm -23 <(seq 3500 4000) <(ss -tan | awk '{print $4}' | cut -d':' -f2 | grep "[0-9]\{1,5\}" | sort | uniq) | shuf | head -n 1)

echo "Repo name: ${RNAME}"
echo "Site port: ${site_port}"
echo "PMA port: ${pma_port}"
cd ${RNAME}
ls
sed  -i -e "s/USE_LOCAL=true/USE_LOCAL=false/" -e "s/WORDPRESS_PORT=80/WORDPRESS_PORT=${site_port}/"  -e "s/PHPMYADMIN_PORT=3000/PHPMYADMIN_PORT=${pma_port}/"  .env

sh wp-build.sh
sleep 5
sh wp-init.sh && sudo sh wp-serve.sh