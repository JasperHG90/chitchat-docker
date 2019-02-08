# Manually configure the ChitChat service

Below, you will find steps to manually configure the ChitChat Docker service

### 1. Compiling the ChitChat `jar` file

To compile `ChitChat`, you can simply build and run the `Dockerfile` in the 'build' folder.

```
docker build build/. -t chitchat/chitchat_build
```

```
docker run --rm --mount source=chitchat,target=/var/chitchat chitchat/chitchat_build
```

This command stores the chitchat .jar file in a [docker volume](https://docs.docker.com/storage/volumes/) called 'chitchat'.

### 2. Setting up the database

Next, we build and configure the database

```
docker build database/. -t chitchat/chitchat_db
```

```
docker build app/. -t chitchat/chitchat_app
```

We also need to copy our local `settings.yml` file to the `chitchat` docker volume. We do this by creating a small helper container so that we can access the volume.

```
docker run --mount source=chitchat,target=/var/chitchat --name helper busybox
```

Now, use `docker cp` to copy your local `settings.yml` file

```
docker cp settings.yml helper:/var/chitchat/settings.yml
```

You should also copy the `VERSION.txt` file to your host machine. This file contains the ChitChat version you're using

```
docker cp helper:/var/chitchat/VERSION.txt VERSION.txt
```

When you're done, shut the helper container down

```
docker rm helper
```

We can now start the database container quietly in the background

```
docker run -d --rm --mount source=chitchat_postgres,target=/var/lib/postgresql/data --env-file env.list --name chitchat_database chitchat/chitchat_db
```

Call the migration script

```
docker run --rm --mount source=chitchat,target=/var/chitchat --link=chitchat_database:database chitchat/chitchat_app db migrate settings.yml
```

Finally, stop the database container

```
docker stop chitchat_database
```

Your containers and volumes are now configured.
