# Chitchat docker setup

The docker setup for ChitChat is configured such that it runs as a stand-alone application that only requires an installation of `docker` and `docker-compose`. All other services are configured within docker containers.

For most users, the standard configuration will be sufficient. In this document, we further elaborate on the architecture of the docker setup and how you can tweak this setup to your own use case.

## The basic configuration

The basic configuration uses several docker environments.

1. A `build` environment that downloads the ChitChat repository (LINK) and compiles the `.jar` file.
2. An `app` environment that runs the ChitChat `.jar` file
3. A `database` environment that runs a postgresql database used to store data
4. An nginx container that serves as a proxy and simplifies hosting the ChitChat application.

### Use of docker volumes

The `bootstrap.sh` configuration creates several volumes that are shared between containers

1. The `build` and `app` environments share a docker volume called `chitchat`. After the initial configuration, this volume contains the following files

```
+-- chitchat-latest.jar
  - ChitChat java application
+-- VERSION.txt
  - A text file containing the version of `chitchat-latest.jar`
+-- /data
  - Folder containing data, models and other files used by `chitchat-latest.jar`
```

2. The `database` container uses a docker volume called `chitchat_postgres` that is used to store data persistently (since docker containers are ephemeral, more information [here](https://github.com/docker-library/docs/blob/master/postgres/README.md#how-to-extend-this-image)).

These volumes store data persistently across containers, which are (by design) ephemeral. You can view the docker volumes by executing

```
docker volume ls
```

in a terminal.

### Docker compose

The `docker-compose.yml` file specifies several services that run in their own docker container to create the ChitChat docker application. By executing `docker-compose up`, you basically start up all these containers and specify how they 'talk' to each other. In this setup

- The `database` container contains all the application data, which is stored on the `chitchat_postgres` volume. This container talks to the `chitchat` container.
- The `chitchat` container runs the java application. It talks to the `database` container and exposes port 5678 to the `nginx` container
- The `nginx` container serves as a gateway to access the ChitChat application. It runs on port 80. Therefore, if you were to run this docker setup on a remote server and you would open port 80 on that machine, you would be able to access the ChitChat application.

### Custom tweaks

There are several tweaks that you can perform to tailor the docker environment to your own need.

#### Using a remote postgres database

It is relatively simple to configure ChitChat such that it can communicate with a remote database. Basically, you need to ...
