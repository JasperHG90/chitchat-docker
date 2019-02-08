# README

## Initial setup

The initial setup of chitchat can be configured by calling:

```
bash bootstrap.sh
```

in a terminal. See 'manual setup' if you want to manually configure ChitChat

## Manual setup

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

```
docker build database/. -t chitchat/chitchat_db
```

```
docker build app/. -t chitchat/chitchat_app
```

Run a helper docker container

```
docker run --mount source=chitchat,target=/var/chitchat --name helper busybox
```

Copy your `settings.yml` file

```
docker cp settings.yml helper:/var/chitchat/settings.yml
```

When you're done, shut the helper container down

```
docker rm helper
```

```
docker run -d --rm --mount source=chitchat_postgres,target=/var/lib/postgresql/data --env-file env.list --name chitchat_database chitchat/chitchat_db
```

```
docker run --mount source=chitchat,target=/var/chitchat --link=chitchat_database:database chitchat/chitchat_app db migrate settings.yml
```

### 3. Running chitchat



```
docker run --rm --mount source=chitchat,target=/var/chitchat chitchat/chitchat_app
```

## Updating settings

Run a helper docker container

```
docker run --mount source=chitchat,target=/var/chitchat --name helper busybox
```

Copy your `settings.yml` file

```
docker cp settings.yml helper:/var/chitchat/settings.yml
```

When you're done, shut the helper container down

```
docker rm helper
```

### Technical notes on the docker setup

This docker setup generally follows the latest stable release of the ChitChat chatbot.

* the master branch uses the latest stable release of the chatbot
* the development branch may incorporate development code.
* previous versions are tagged by their ChitChat version number on the [releases](https://github.com/JasperHG90/chitchat-docker/releases) page. If you want a previous  version of the chatbot, you are advised to download the zip file from the releases page.

The docker setup depends on a rather static declaration of the chitchat version. This means the following:
