#!/bin/bash

# Start the database container
docker run -d --rm --mount source=chitchat_postgres,target=/var/lib/postgresql/data --env-file env.list --name chitchat_database chitchat/chitchat_db

# restore the database
cat chitchat_dump.sql | docker exec -i chitchat_database psql -U chitchat

# Stop the container
docker stop chitchat_database
