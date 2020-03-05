#!/usr/bin/env bash
git clone git@github.com:danhort/docker-magento.git ops

# Copy the Makefile sample to the project root
cp ops/samples/Makefile.sample ./Makefile

# Copy editor configuration file to the project root
cp ops/samples/.editorconfig ./

# Copy the environment file to the ops directory
cp ops/samples/docker.env.sample ops/docker.env

# Delete self
rm -- "$0"
