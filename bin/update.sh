#!/usr/bin/env bash

while [ ! $# -eq 0 ]
do
	case "$1" in
        -p|--project) 
            PROJECT_NAME=$2
            ;;
        -d|--docker-path) 
            DOCKER_PATH=$2
            ;;
    esac
    shift
done

# Add path to git command
git="git -C $DOCKER_PATH"

# get current branch name
CURRENT_VERSION=$($git symbolic-ref --short HEAD 2>/dev/null)

if [[ ! -n "$CURRENT_VERSION" ]]; then
    # get tag name or short unique hash
    CURRENT_VERSION=$($git describe --tags --always 2>/dev/null)
fi

# Get the latest remote version versions
$git fetch -q
LATEST_VERSION=$(echo $($git tag) | awk '{print $NF}')

update () {
    # Check if running latest version
    if [[ $CURRENT_VERSION == $LATEST_VERSION ]]; then
        echo "You are currently running the latest Docker Magento version ($CURRENT_VERSION) for the $PROJECT_NAME project"
        exit 0;
    fi

    # TODO: check for breacking changes
    echo "You are currently running Docker Magento version $CURRENT_VERSION"
    echo "Updating Docker Magento for the $PROJECT_NAME project to version $LATEST_VERSION"

    # Checkout latest version
    $git checkout -q $LATEST_VERSION
    exit 0;
}

update