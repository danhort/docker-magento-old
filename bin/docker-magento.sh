#!/usr/bin/env bash

usage () {
    echo "
Usage:  docker-magento [options...]
Downloads the Docker Magento development environment from https://github.com/danhort/docker-magento.
 -h, --help          This help text
 -u, --update        Updates the docker-magento install script
"
}

init () {
    git clone git@github.com:danhort/docker-magento.git ops

    # Copy the Makefile sample to the project root
    cp ops/samples/Makefile.sample ./Makefile

    # Copy editor configuration file to the project root
    cp ops/samples/.editorconfig.sample ./.editorconfig

    # Copy the environment file to the ops directory
    cp ops/samples/docker.env.sample ops/docker.env

    # Copy the custom nginx file to the ops directory
    cp ops/samples/custom-nginx.conf.sample ops/custom-nginx.conf
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

while [ ! $# -eq 0 ]
do
	case "$1" in
        -h|--help)
            usage
            exit
            ;;
        -u|--update) update
            exit
            ;;
    esac
    shift
done

init
