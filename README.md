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

### Technical notes on the docker setup

The docker setup depends on a rather static declaration of the chitchat version. This means the following:

1. During the build process, the docker image responsible for building the chitchat jar file will use a specific commit as a reference point.
2. This means that, if you change this commit, you **must also make specific note of the version of chitchat**. This is information that is stored in the [pom.xml](https://bitbucket.org/arvid/chitchat/src/dfca7f03716a1850f945b37406753fc80d2847eb/pom.xml?at=master&fileviewer=file-view-default#pom.xml-9) file.
3. However, if you change the commit, you can also simply observe the build and copy the version from the final output of the build process. This **version should then be changed in the `env_file`**
