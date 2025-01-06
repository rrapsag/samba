# Samba

A simplest and lightweight samba docker container for sharing files quickly and easily.

## Description

[Samba](https://www.samba.org/) is a service which allows the management and sharing of network resources in a Windows environment, using the SMB/CIFS protocol.

This docker image was created using Alpine Linux and a very simple samba configuration, for quickly creating a shared folder on the network.

The username and password to access the share is **samba**.

## Usage

Start the container:

```zsh
docker run -d -p 139:139/tcp -p 445:445/tcp --name samba rrapsag/samba
```

## Building

```zsh
docker build -t rrapsag/samba:latest .
```
