#!/usr/bin/env sh

BOLD="\033[1m"
RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

#wp core download
wp core download  

# Install WordPress.
wp core install \
  --path="/var/www/html" \
  --url="${WP_URL}" \
  --title="${WORDPRESS_TITLE}" \
  --admin_user="${WORDPRESS_ADMIN_USER}" \
  --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
  --admin_email="${WORDPRESS_ADMIN_EMAIL}"

 #Update permalink structure.
 wp option update \
  permalink_structure "${WORDPRESS_PERMALINK_STRUCTURE}" \
  --skip-themes \
  --skip-plugins

# Theme installation
#wp theme delete --all --force
wp theme install "${WORDPRESS_THEME_TO_INSTALL}" --activate

#Plugin installation
#wp plugin uninstall --all

wp plugin install ${WORDPRESS_PLUGINS_TO_INSTALL} --activate

if [ 'true' == ${USE_EXTERNAL_ASSETS} ]
then
echo -e "${GREEN}Use s3 for uploads${ENDCOLOR}"
wp plugin install amazon-s3-and-cloudfront --activate
else
wp plugin deactivate amazon-s3-and-cloudfront
fi

#activate acorn
wp plugin activate acorn
wp plugin activate cloudflare-flexible-ssl
#wp theme activate sage

echo -e "\nREPORT\n"

# List users
echo "== User List =="
wp user list
echo ""

# Show installed plugin
echo "== Theme List =="
wp theme list
echo ""

# Show installed plugin
echo "== Plugin List =="
wp plugin list
echo ""

# # Show site url for local
# echo -e "+--------------------------------------------------+"
# if [ 'true' == ${USE_LOCAL} ]
# then
# echo -e "| ${GREEN}${BOLD}Your siteurl:${ENDCOLOR} | ${GREEN}${BOLD}${WP_URL}.loc${ENDCOLOR}      |"
# echo -e "+--------------------------------------------------+"
# echo -e "| ${RED}${BOLD}Dont forget to add this url to hosts file${ENDCOLOR}        |"
  # if [ 'false' == ${USE_EXTERNAL_DATABASE} ]
  # then
  # echo -e "+--------------------------------------------------+"
  # echo -e "| ${GREEN}${BOLD}Your PMA url:${ENDCOLOR} | ${GREEN}${BOLD}${WP_URL}.loc${ENDCOLOR}:${PHPMYADMIN_PORT} |"
  # fi
# fi  
# echo -e "+--------------------------------------------------+"