# docker-prestodb

[![Build Status](https://travis-ci.org/shawnzhu/docker-prestodb.svg?branch=master)](https://travis-ci.org/shawnzhu/docker-prestodb)
[![Docker Build Statu](https://img.shields.io/docker/build/shawnzhu/prestodb.svg)](https://hub.docker.com/r/shawnzhu/prestodb/)

This is a docker image for [PrestoDB](https://prestodb.io/) with [Hive connector](https://prestodb.io/docs/current/connector/hive.html).

## Configuration

It requires a working Hive cluster since the default configuration files are for hive connector only. See https://prestodb.io/docs/current/installation/deployment.html Where it assumes Hive metastore listens on `thrift://hive-metastore:9083`

## Start

```SHELL
docker run -d -p 8080:8080 shawnzhu/prestodb:0.181
``` 

## Customize

It's capable to change configuration like `hive.metastore.uri` by binding new directory under `/opt/presto/etc`. E.g., given configuration file `/foo/bar/hive.properties`:

```SHELL
docker run -d -p 8080:8080 -v /foo/bar/hive.properties:/opt/presto/etc/catalog/hive.properties:ro shawnzhu/prestodb:0.181
``` 

