# README

This repository contains a [Docker](https://www.docker.com/) setup for the [ChitChat](https://bitbucket.org/arvid/chitchat/overview) chatbot developed at the [Leiden University Center for Innovation](https://www.centre4innovation.org/).

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

## Updating settings

If you update the `settings.yml` file in this directory, you will need to copy it to the `chitchat` docker volume for it to take effect. We do this by creating a small helper container so that we can access the volume.

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

You can now run `docker-compose up` with your changed settings.

### Downloading specific versions of ChitChat

This docker setup generally follows the latest stable release of the ChitChat chatbot.

* the master branch uses the latest stable release of the chatbot
* the development branch may incorporate development code.
* previous versions are tagged by their ChitChat version number on the [releases](https://github.com/JasperHG90/chitchat-docker/releases) page. If you want a previous  version of the chatbot, you are advised to download the zip file from the releases page.

<img src="img/center-for-innovation.png" width="200">
