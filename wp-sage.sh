#!/usr/bin/sh
#Check composer
if ! command -v composer > /dev/null
then
    echo "composer could not be found, try to install"
    sudo apt update
    sudo apt install -y composer
fi
#Check Node TODO: add nvm install
if ! command -v node > /dev/null
then
    echo "Node could not be found, try to install"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # It will load nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # It will load nvm bash_completion    
    nvm install node 18
fi

cd wp_data/wp-content/themes/sage
composer install -o
yarn && yarn dev
