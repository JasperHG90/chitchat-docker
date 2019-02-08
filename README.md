# README

## Compilation

To compile `ChitChat`, you can simply build and run the `Dockerfile` in the 'build' folder.

```
docker build build/. -t chitchat/chitchat_build
```

```
docker run --rm --mount source=chitchat,target=/var/chitchat chitchat/chitchat_build
```

This command stores the chitchat .jar file in a [docker volume](https://docs.docker.com/storage/volumes/) called 'chitchat'.

## Setting up the database

```
docker network create chitchat-net
```

```
docker build database/. -t chitchat/chitchat_db
```

```
docker run -d --net=chitchat-net --env-file env.list chitchat/chitchat_db
```

## Running chitchat

```
docker build app/. -t chitchat/chitchat_app && docker run --rm --mount source=chitchat,target=/var/chitchat chitchat/chitchat_app
```

## Updating settings

Run a helper docker container

```
docker run --mount source=chitchat,target=/var/chitchat --name helper busybox
```

Copy your `settings.yml` file

```
docker cp settings.yml . helper:/var/chitchat/settings.yml
```

### Technical notes on the docker setup

This docker setup generally follows the latest stable release of the ChitChat chatbot.

* the master branch uses the latest stable release of the chatbot
* the development branch may incorporate development code.
* previous versions are tagged by their ChitChat version number on the [releases](https://github.com/JasperHG90/chitchat-docker/releases) page. If you want a previous  version of the chatbot, you are advised to download the zip file from the releases page.

The docker setup depends on a rather static declaration of the chitchat version. This means the following:
