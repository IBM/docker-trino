# docker-prestodb

[![Actions Status](https://github.com/IBM/docker-prestodb/workflows/test/badge.svg)](https://github.com/IBM/docker-prestodb/actions)
[![Docker Build Statu](https://img.shields.io/docker/build/shawnzhu/prestodb.svg)](https://hub.docker.com/r/shawnzhu/prestodb/)

This is a docker image for [Trino](https://trino.io/) with [Db2 connector](https://github.com/IBM/trino-db2/) and [trino-event-stream](https://github.com/IBM/trino-event-stream).

**Notice**: it starts to switch the base image from openjdk to the official trino container image [`trinodb/trino`](https://hub.docker.com/r/trinodb/trino) since tag `354`.

## Build

Run this command to build an image with trino release 354 and Db2 connector:

```SHELL
docker build --build-arg TRINO_VERSION=354 -t "shawnzhu/trinodb:354" .
```

## Start

```SHELL
docker run -d -p 8080:8080 shawnzhu/trino:354
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
docker run -d -p 8080:8080 -v /foo/bar/db2.properties:/usr/lib/trino/default/etc/catalog/db2.properties:ro shawnzhu/trino:latest
```

### Trino Event Streams

Given configuration of Trino Event Streams:

```
# cat event-listener.properties
event-listener.name=event-stream
bootstrap.servers=broker:9092
key.serializer=org.apache.kafka.common.serialization.StringSerializer
value.serializer=org.apache.kafka.common.serialization.StringSerializer
```
All Trino queries info will be sent to topic `trino.event`. 

## Features

### Graceful Shutdown

It adds the [graceful shutdown](https://trino.io/docs/current/admin/graceful-shutdown.html) feature from Trino such that on a SIGTERM signal to the container, the worker will have a grace period before interrupting active queries.
