# README

This repository contains a [Docker](https://www.docker.com/) setup for the [ChitChat](https://bitbucket.org/arvid/chitchat/overview) chatbot developed at the [Leiden University Center for Innovation](https://www.centre4innovation.org/).

The full documentation for the chitchat-docker environment can be found [here](https://c4i.gitbook.io/chitchat/).

## Quick-start guide

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

in a terminal.

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

## Downloading specific versions of ChitChat

This docker setup generally follows the latest stable release of the ChitChat chatbot.

* the master branch uses the latest stable release of the chatbot
* the development branch may incorporate development code.
* previous versions are tagged by their ChitChat version number on the [releases](https://github.com/JasperHG90/chitchat-docker/releases) page. If you want a previous  version of the chatbot, you are advised to download the zip file from the releases page.

<img src="https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LZnMrEannFdihvQ7QN2%2F-LZnPpAjASVke6KXzZnj%2F-LZnRzTkno0LFR7mxw2W%2Fcenter-for-innovation.png?alt=media&token=b544f6ac-3a92-492d-91e0-536020f2e14e" width="200">
