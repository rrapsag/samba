# Samba

A simplest and lightweight samba docker container for sharing files quickly and easily.

## Description

[Samba](https://www.samba.org/) is a service which allows the management and sharing of network resources in a Windows environment, using the SMB/CIFS protocol.

This docker image was created using Alpine Linux and a very simple samba configuration, for quickly creating a shared folder on the network. This allows you to share files between different systems.

>[!NOTE]
>The protocol used by samba in this docker image is SMB3. Older Windows versions will not be able to access the folder shared by the container.

The shared folder is password protected and can be changed using environment variables when we run the docker command to create the container.

## Usage

You can get started creating a container from this image either use docker cli or docker-compose.

### Docker

Start the container with docker run:

```zsh
docker run -d -p 445:445/tcp --name samba rrapsag/samba
```

Setting shared folder user and password:

>[!NOTE]
>When username and password are not specified, by default **samba** will be set.

```zsh
docker run -d -p 445:445/tcp \
    -e USER=user -e PASS=pass \
    --name samba rrapsag/samba
```

Mapping custom local volume:

```zsh
docker run -d -p 445:445/tcp \
    -e USER=user -e PASS=pass \
    -v /tmp/storage:/storage \
    --name samba rrapsag/samba
```

>[!TIP]
>Use user (UID) and group (GID) id to avoid files/folder permissions issues between the host OS and the container when using volumes.

### Docker Compose

Minimal docker-compose.yml:

```yaml
services:
  samba:
    image: rrapsag/samba:latest
    container_name: samba
    hostname: samba
    ports:
      - 445:445
    environment:
      USER: samba
      PASSW: samba
      #UID: 1000 # optional
      #GID: 1000 # optional
    volumes:
      - /tmp/storage:/storage
    restart: unless-stopped
```
Run:

```zsh
docker-compose up -d
```

## Environment variables

The container is configured using environment variables at runtime. We have the following variables available for container configuration:

| Variable | Function |
| :----: | --- |
| `USER` | Specify username for the share. |
| `PASS` | Specify password for the share. |
| `UID` | Specify the user identifier. |
| `GID` | Specify the group identifier. |

## Building

```zsh
git clone https://github.com/rrapsag/samba.git
cd samba
docker build -t rrapsag/samba:latest .
```
