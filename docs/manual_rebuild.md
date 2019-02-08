# Manually rebuilding ChitChat

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
