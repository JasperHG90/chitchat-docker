#!/bin/bash

# Rebuild the ChitChat jar file
docker build build/. -t chitchat/chitchat_build
docker run --rm --mount source=chitchat,target=/var/chitchat chitchat/chitchat_build

# Retrieve the new VERSION.txt file
docker run --mount source=chitchat,target=/var/chitchat --name helper busybox
docker cp helper:/var/chitchat/VERSION.txt VERSION.txt
docker rm helper

# Read VERSION
ccversion=$( cat VERSION.txt )

echo "Finished building ${ccversion}"
