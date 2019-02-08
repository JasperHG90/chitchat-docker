# Manually update the `settings.yml` file

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
