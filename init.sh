#!/usr/bin/env bash

SOURCE_DIRECTORY=$(dirname "${BASH_SOURCE[0]}")
TARGET_DIRECTORY=$PWD

# Copy the Makefile sample to the project root
cp $SOURCE_DIRECTORY/samples/Makefile.sample $TARGET_DIRECTORY/Makefile

# Prepend the docker directory path to the Makefile
sed -i  "1iDOCKER_PATH := $SOURCE_DIRECTORY" $TARGET_DIRECTORY/Makefile

# Copy the environment file to the ops directory
cp $SOURCE_DIRECTORY/samples/docker.env.sample $SOURCE_DIRECTORY/docker.env

# Copy the Nginx configuration file to the ops directory
cp $SOURCE_DIRECTORY/samples/nginx.conf.sample $SOURCE_DIRECTORY/nginx.conf