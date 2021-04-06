# docker-prestodb

[![Actions Status](https://github.com/IBM/docker-prestodb/workflows/test/badge.svg)](https://github.com/IBM/docker-prestodb/actions)
[![Docker Build Statu](https://img.shields.io/docker/build/shawnzhu/prestodb.svg)](https://hub.docker.com/r/shawnzhu/prestodb/)

This is a docker image for [PrestoDB](https://prestosql.io/) with [Db2 connector](https://github.com/IBM/presto-db2/).

**Notice**: it starts to switch the base image from openjdk to the official prestosql container image [`prestosql/presto`](https://hub.docker.com/r/prestosql/presto) since tag `325`.

## Build

Run this command to build an image with prestodb release 347 and Db2 connector:

```SHELL
docker build --build-arg PRESTO_VERSION=347 -t "shawnzhu/prestodb:347" .
```

## Start

```SHELL
docker run -d -p 8080:8080 shawnzhu/prestodb:latest
```

## Configuration

### DB2

Given configuration of db2:

```
# cat db2.properties
connector.name=db2
connection-url=jdbc:db2://ip:port/database
connection-user=myuser
connection-password=mypassword
```

Then:

```SHELL
docker run -d -p 8080:8080 -v /foo/bar/db2.properties:/usr/lib/presto/default/etc/catalog/db2.properties:ro shawnzhu/prestodb:latest
```

## Features

### Graceful Shutdown

Adds the [graceful shutdown](https://trino.io/docs/current/admin/graceful-shutdown.html) feature from Trino so that active queries have a grace period to finish before the worker node is shut down (like in a redeployment).
