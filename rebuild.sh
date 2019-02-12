#!/bin/bash

# Rebuild the ChitChat jar file
docker build build/. -t chitchat/chitchat_build
docker run --rm --mount source=chitchat,target=/var/chitchat chitchat/chitchat_build

# Retrieve the new VERSION.txt file
docker run --mount source=chitchat,target=/var/chitchat --name helper busybox
docker cp helper:/var/chitchat/VERSION.txt VERSION.txt
docker cp settings.yml helper:/var/chitchat/settings.yml
docker rm helper

# Start the database container
docker run -d --rm --mount source=chitchat_postgres,target=/var/lib/postgresql/data --env-file env.list --name chitchat_database chitchat/chitchat_db

# Configure the database
docker run --rm --mount source=chitchat,target=/var/chitchat --link=chitchat_database:database chitchat/chitchat_app db migrate settings.yml

# Stop the database
docker stop chitchat_database

# Read VERSION
ccversion=$( cat VERSION.txt )

echo "Finished building ${ccversion}"
