#!/bin/bash

# Build 'build' container
docker build build/. -t chitchat/chitchat_build

# Call build container
# By mounting the volume 'chitchat' it is created as persistent storage
docker run --rm --mount source=chitchat,target=/var/chitchat chitchat/chitchat_build

# Copy local settings to the 'chitchat' volume using the 'helper' container
docker run --mount source=chitchat,target=/var/chitchat --name helper busybox
docker cp settings.yml helper:/var/chitchat/settings.yml
# Copy the ChitChat version to the host
docker cp helper:/var/chitchat/VERSION.txt VERSION.txt
docker rm helper

# Build 'database' container
docker build database/. -t chitchat/chitchat_db

# Build 'app' container
docker build app/. -t chitchat/chitchat_app

# Start the database container
docker run -d --rm --mount source=chitchat_postgres,target=/var/lib/postgresql/data --env-file env.list --name chitchat_database chitchat/chitchat_db

# Configure the database
docker run --rm --mount source=chitchat,target=/var/chitchat --link=chitchat_database:database chitchat/chitchat_app db migrate settings.yml

# Stop the database
docker stop chitchat_database

# Finish
echo "Finished bootstrap. Exiting now ..."
