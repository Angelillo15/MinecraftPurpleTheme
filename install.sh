#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

installTheme(){
    cd /var/www/
    tar -cvf MinecraftPurpleThemebackup.tar.gz pterodactyl
    echo "Installing theme..."
    cd /var/www/pterodactyl
    git clone https://github.com/Angelillo15/MinecraftPurpleTheme.git
    cd MinecraftPurpleTheme
    rm /var/www/pterodactyl/resources/scripts/index.tsx
    mv index.tsx /var/www/pterodactyl/resources/scripts/index.tsx
    mv MinecraftPurpleTheme.css /var/www/pterodactyl/resources/scripts/MinecraftPurpleTheme.css
    cd /var/www/pterodactyl
    sudo yarn build:production
    sudo php artisan optimize:clear
}


while true; do
    read -p "Do you want to install the theme [Y/n]? " yn
    case $yn in
        [Yy]* ) installTheme; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

