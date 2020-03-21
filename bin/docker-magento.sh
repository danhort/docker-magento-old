#!/usr/bin/env bash

usage () {
    echo "
Usage:  docker-magento [options...]
 -h, --help          This help text
 -u, --update        Updates the docker-magento install script
"
}

install () {
    git clone git@github.com:danhort/docker-magento.git ops

    # Copy the Makefile sample to the project root
    cp ops/samples/Makefile.sample ./Makefile

    # Copy editor configuration file to the project root
    cp ops/samples/.editorconfig ./

    # Copy the environment file to the ops directory
    cp ops/samples/docker.env.sample ops/docker.env
}

update () {
    if [[ $EUID -ne 0 ]]; then
        echo "You have to be root to install Docker Magento. Try running with sudo."
        exit 1;
    fi

    echo 'Updating Docker Magento';
    cd /usr/bin
    wget https://raw.githubusercontent.com/danhort/docker-magento/master/bin/docker-magento.sh
    rm docker-magento
    mv docker-magento.sh docker-magento
    chmod +x docker-magento
    echo 'Update complete. Run Docker Magento with the command "docker-magento".'
    exit 0;
}

while test $# -gt 0; do
  case "$1" in
    -h|--help) usage
        break
        ;;
    -u|--update) update
        break
        ;;
    \?) install
        break
        ;;
  esac
done
