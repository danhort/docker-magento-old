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

    # Add path to git command
    local git="git -C ./ops"

    # Get the latest version
    LATEST_VERSION=$(echo $($git tag) | awk '{print $NF}')

    # Checkout the latest tag version
    $git checkout -q $LATEST_VERSION

    # Copy the Makefile sample to the project root
    cp ops/samples/Makefile.sample ./Makefile

    # Copy editor configuration file to the project root
    cp ops/samples/.editorconfig.sample ./.editorconfig

    # Copy the environment file to the ops directory
    cp ops/samples/docker.env.sample ops/docker.env

    # Copy the custom nginx file to the ops directory
    cp ops/samples/custom-nginx.conf.sample ops/custom-nginx.conf

    # create magneto root dir
    mkdir src

    # create external extensions dir
    mkdir extensions
}

update () {
    # Check if user root
    if [[ $EUID -ne 0 ]]; then
        echo "You have to be root to install Docker Magento. Try running with sudo."
        exit 1;
    fi

    echo 'Updating Docker Magento';

    # Move to bin folder
    cd /usr/bin

    local REMOTE_URL="https://github.com/danhort/docker-magento.git"

    # Get the all the available tag versions
    local AVIALABLE_VERSION=$(echo $(git ls-remote --refs -t -q $REMOTE_URL ) | tr " " "\n" | grep "refs" | tr "/" "\n" | grep "\.")

    # Get the lates version
    local LATEST_VERSION=$(echo $AVIALABLE_VERSION | awk '{print $NF}')

    # Download the script
    wget https://raw.githubusercontent.com/danhort/docker-magento/$LATEST_VERSION/bin/docker-magento.sh

    # Reomove the old script
    rm docker-magento

    # Rename the new script
    mv docker-magento.sh docker-magento

    # Set correct file mode
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
