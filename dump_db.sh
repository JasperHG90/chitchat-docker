#!/bin/bash

# Start the database container
docker run -d --rm --mount source=chitchat_postgres,target=/var/lib/postgresql/data --env-file env.list --name chitchat_database chitchat/chitchat_db

# Dump the database
docker exec -t chitchat_database pg_dumpall -c -U chitchat > chitchat_dump.sql

# Stop the container
docker stop chitchat_database
