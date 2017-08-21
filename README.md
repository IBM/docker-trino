# docker-presto

This is a docker image for [PrestoDB](https://prestodb.io/).

## Prerequisites

* docker v1.13.0+

## Configuration

The default configuration files are for hive connector only. See https://prestodb.io/docs/current/installation/deployment.html

In runtime, it can override default configuration by binding new directory under `/opt/presto/etc`
