#!/bin/bash

## ##################################
## Initialize the ChitChat database
## ##################################

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE EXTENSION "uuid-ossp";
  CREATE EXTENSION pgcrypto;
EOSQL
