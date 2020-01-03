# docker-prestodb

[![Build Status](https://travis-ci.org/IBM/docker-prestodb.svg?branch=master)](https://travis-ci.org/IBM/docker-prestodb)
[![Docker Build Statu](https://img.shields.io/docker/build/shawnzhu/prestodb.svg)](https://hub.docker.com/r/shawnzhu/prestodb/)

This is a docker image for [PrestoDB](https://prestosql.io/) with [Db2 connector](https://github.com/IBM/presto-db2/).

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
