#!/bin/bash

# Update settings.yml in the 'chitchat' docker volume
docker run --mount source=chitchat,target=/var/chitchat --name helper busybox

# Copy the 'settings.yml' file
docker cp settings.yml helper:/var/chitchat/settings.yml

# Remove the helper container
docker rm helper

echo "Successfully copied settings to the 'chitchat' volume ..."
