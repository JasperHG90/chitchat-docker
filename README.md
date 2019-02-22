# README

This repository contains a [Docker](https://www.docker.com/) setup for the [ChitChat](https://bitbucket.org/arvid/chitchat/overview) chatbot developed at the [Leiden University Center for Innovation](https://www.centre4innovation.org/).

## Required software

This software depends on a working installation of:

- [Docker](https://www.docker.com/get-started)
- [Docker-compose](https://docs.docker.com/compose/install/)

But that's pretty much all you need :-).

## Initial setup

**NOTE:** You may need to use superuser ('sudo') privileges for the commands below. You have two options if you see a permissions error:

1. Add yourself to the docker sudo group (recommended)

  - On linux: `sudo usermod -a -G docker $USER`

2. Prepend 'sudo' to the command (not recommended)

The initial setup of chitchat can be configured by calling:

```
bash bootstrap.sh
```

in a terminal. See 'manual setup' if you want to manually configure ChitChat.

For more information about the setup of the ChitChat docker environment, see [this](https://github.com/JasperHG90/chitchat-docker/blob/master/docs/chitchat_docker.md) document.

### Manual setup

You can follow the manual setup [here](https://github.com/JasperHG90/chitchat-docker/blob/master/docs/manual_setup.md)

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

After the (manual) configuration of ChitChat, you will find a file called `VERSION.txt` in the root folder that contains the ChitChat version you're currently using.

## Updating settings

If you update the `settings.yml` file in this directory, you will need to copy it to the `chitchat` docker volume for it to take effect.

First, stop the ChitChat services

```
docker-compose down
```

Then, run the following line in a terminal

```
bash update_settings.sh
```

You can now run `docker-compose up` with your changed settings:

```
docker-compose up -d
```

You may also do this [manually](https://github.com/JasperHG90/chitchat-docker/blob/master/docs/manual_settings.md)

## If you know what you're doing ...

If you would like to use a specific version of ChitChat (basically down to the commit), then you should change [this line](https://github.com/JasperHG90/chitchat-docker/blob/master/build/Dockerfile#L8) in `build/Dockerfile`.

Then, stop the ChitChat services

```
docker-compose down
```

You can easily rebuild ChitChat by executing

```
bash rebuild.sh
```

Then, execute

```
docker-compose up -d
```

and continue where you left off.

You may also do this [manually](https://github.com/JasperHG90/chitchat-docker/blob/master/docs/manual_rebuild.md)

## Creating a new user

See the docs [here](https://github.com/JasperHG90/chitchat-docker/blob/master/docs/createuser.md)

## Dumping and restoring databases

See the docs [here](https://github.com/JasperHG90/chitchat-docker/blob/master/docs/postgres.md)

## Hosting ChitChat

See an example [here](https://github.com/JasperHG90/chitchat-docker/blob/master/docs/configuring_and_hosting.md)

## Removing ChitChat

See the docs [here](https://github.com/JasperHG90/chitchat-docker/blob/master/docs/removing_chitchat.md)

## Downloading specific versions of ChitChat

This docker setup generally follows the latest stable release of the ChitChat chatbot.

* the master branch uses the latest stable release of the chatbot
* the development branch may incorporate development code.
* previous versions are tagged by their ChitChat version number on the [releases](https://github.com/JasperHG90/chitchat-docker/releases) page. If you want a previous  version of the chatbot, you are advised to download the zip file from the releases page.

<img src="docs/img/center-for-innovation.png" width="200">
