FROM postgres:10.5-alpine

# See: https://github.com/docker-library/docs/blob/master/postgres/README.md#how-to-extend-this-image
# seealso: https://stackoverflow.com/questions/26598738/how-to-create-user-database-in-script-for-docker-postgres

# Seealso: https://hdb.docs.pivotal.io/230/hawq/plext/using_pgcrypto.html
# seealso: https://www.linode.com/docs/applications/containers/docker-container-communication/

# The docker container will create user/db/pwd specified in the env.list file in the top-level folder.

# Copy init.sh
COPY init.sh /docker-entrypoint-initdb.d/
