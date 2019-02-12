# Dumping and restoring postgresql data

Dumping and restoring data from a sql dump is relatively easy.

To perform either of these operations, you must run a temporary container containing your chitchat data

## Dumping a database

Run a temporary container to access your data

```
docker run -d --rm --mount source=chitchat_postgres,target=/var/lib/postgresql/data --env-file env.list --name chitchat_database chitchat/chitchat_db
```

To dump a database to your current working directory, execute the following in a terminal

```
docker exec -t chitchat_database pg_dump -c -U chitchat -d chitchat > chitchat_dump.sql
```

Stop the temporary container

```
docker stop chitchat_database
```

You can now find a file called `chitchat_dump.sql` in your current directory.

## Restoring a database

If you want to restore a database, you need to first set up the environment (including the bootstrap script).

Run a temporary container to access your data

```
docker run -d --rm --mount source=chitchat_postgres,target=/var/lib/postgresql/data --env-file env.list --name chitchat_database chitchat/chitchat_db
```

Then, you can restore a dumped .sql database by executing the following in a terminal

```
cat chitchat_dump.sql | docker exec -i chitchat_database psql -U chitchat -d chitchat
```

Stop the temporary container

```
docker stop chitchat_database
```
