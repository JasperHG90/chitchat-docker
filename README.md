# README

This repository contains a [Docker](https://www.docker.com/) setup for the [ChitChat](https://bitbucket.org/arvid/chitchat/overview) chatbot developed at the [Leiden University Center for Innovation](https://www.centre4innovation.org/).

## Required software

This software depends on a working installation of:

- [Docker](https://www.docker.com/get-started)
- [Docker-compose](https://docs.docker.com/compose/install/)

But that's pretty much all you need :-).

## Initial setup

The initial setup of chitchat can be configured by calling:

```
bash bootstrap.sh
```

in a terminal. See 'manual setup' if you want to manually configure ChitChat.

## Manual setup

You can follow the manual setup [here](https://github.com/JasperHG90/chitchat-docker/blob/master/manual_setup.md)

## Running chitchat

To run ChitChat, execute

```
docker-compose up -d
```

in a terminal. The service will now be available at [http://localhost/api/v1/ui](http://localhost/api/v1/ui)

To shut down the service, execute

```
docker-compose down
```

## Which version of ChitChat am I using?

After the (manual) configuration of ChitChat, you will find a file called `VERSION.txt` in the root folder containing the ChitChat version.

## Updating settings

If you update the `settings.yml` file in this directory, you will need to copy it to the `chitchat` docker volume for it to take effect. We do this by creating a small helper container so that we can access the volume.

First, stop the ChitChat services

```
docker-compose down
```

Next, start a basic container

```
docker run --mount source=chitchat,target=/var/chitchat --name helper busybox
```

Now, use `docker cp` to copy your local `settings.yml` file

```
docker cp settings.yml helper:/var/chitchat/settings.yml
```

When you're done, shut the helper container down

```
docker rm helper
```

You can now run `docker-compose up` with your changed settings:

```
docker-compose up -d
```

## If you know what you're doing ...

If you would like to use a specific version of ChitChat (basically down to the commit), then you should change [this line](https://github.com/JasperHG90/chitchat-docker/blob/master/build/Dockerfile#L5) in `build/Dockerfile`.

Then, stop the ChitChat services

```
docker-compose down
```

At the very least, you should rebuild the `chitchat_build` image by executing

```
docker build build/. -t chitchat/chitchat_build
```

Build a new `jar` file by executing

```
docker run --rm --mount source=chitchat,target=/var/chitchat chitchat/chitchat_build
```

Retrieve the new `VERSION.txt` file

```
docker run --mount source=chitchat,target=/var/chitchat --name helper busybox
docker cp helper:/var/chitchat/VERSION.txt VERSION.txt
docker rm helper
```

It is possible that you have to re-initialize the postgresql database due to migrating to a new version. However, this is not common. You can most likely simply execute `docker-compose up` and continue where you left off.

```
docker-compose up -d
```

## Downloading specific versions of ChitChat

This docker setup generally follows the latest stable release of the ChitChat chatbot.

* the master branch uses the latest stable release of the chatbot
* the development branch may incorporate development code.
* previous versions are tagged by their ChitChat version number on the [releases](https://github.com/JasperHG90/chitchat-docker/releases) page. If you want a previous  version of the chatbot, you are advised to download the zip file from the releases page.

<img src="img/center-for-innovation.png" width="200">
