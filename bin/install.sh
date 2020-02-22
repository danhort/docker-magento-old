#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
    echo "You have to be root to install Docker Magento. Try running with sudo."
    exit 1;
fi

echo 'Installing Docker Magento';
cp "docker-magento" /usr/bin
echo 'Installation complete. Run Docker Magento with the command "docker-magento".'
exit 0;