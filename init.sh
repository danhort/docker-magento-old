#!/usr/bin/env bash
git clone git@github.com:danhort/docker-magento.git ops

SOURCE_DIRECTORY=$(dirname "${BASH_SOURCE[0]}")
TARGET_DIRECTORY=$PWD

# Copy the Makefile sample to the project root
cp ops/samples/Makefile.sample ./Makefile

# Copy the environment file to the ops directory
cp ops/samples/docker.env.sample ./docker.env