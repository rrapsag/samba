# Samba

A simplest and lightweight samba docker container for sharing files quickly and easily.

## Description

[Samba](https://www.samba.org/) is a service which allows the management and sharing of network resources in a Windows environment, using the SMB/CIFS protocol.

This docker image was created using Alpine Linux and a very simple samba configuration, for quickly creating a shared folder on the network. This allows you to share files between different systems.

The shared folder is password protected and can be changed using environment variables when we run the docker command to create the container.

## Usage

Start the container:

```zsh
docker run -d -p 139:139/tcp -p 445:445/tcp --name samba rrapsag/samba
```

Setting shared folder user and password:

>[!NOTE]
>When username and password are not specified, by default **samba** will be set.

```zsh
docker run -d -p 139:139/tcp -p 445:445/tcp \
    -e USER=user -e PASS=pass \
    --name samba rrapsag/samba
```

Mapping custom local volume:

```zsh
docker run -d -p 139:139/tcp -p 445:445/tcp \
    -e USER=user -e PASS=pass \
    -v /tmp/storage:/storage \
    --name samba rrapsag/samba
```

>[!TIP]
>Use user (UID) and group (GID) id to avoid files/folder permissions issues between the host OS and the container when using volumes.

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
docker build -t rrapsag/samba:latest .
```
