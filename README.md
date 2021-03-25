# sample-arm-docker-airflow

[![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg)](https://hub.docker.com/r/kkent4g/airflow-sample-arm)
[![Docker Pulls](https://img.shields.io/docker/pulls/kkent4g/airflow-sample-arm.svg)]()
[![Docker Stars](https://img.shields.io/docker/stars/kkent4g/airflow-sample-arm.svg)]()
[![Github](https://img.shields.io/badge/github-repos-green.svg)](https://github.com/k-ken-t4g/sample-arm-docker-airflow)

Docker Apache Airflow(2.0.1) for RaspberryPi (ARM Architecture)

## Informations
- Based on Python 3.8 official image ([python:3.8](https://hub.docker.com/_/python))
- Uses official [Postgres](https://hub.docker.com/_/postgres/) as backend
- Uses official [redis](https://hub.docker.com/_/redis/) as queue
- Requires Docker and [Docker Compose](https://docs.docker.com/compose/install/)

## Pull from Public Docker repo
Just excecute below command.Only `arm64` is available.

```bash
docker pull kkent4g/airflow-sample-arm
```

## How to build localy

By excecuting `make` command by non-root user, it will automaticaly create airflow docker environment.

```
$ make airflow
```

Checked it will works on below environments
- Ubuntu 20.0.4(64bit)
- Raspbian OS(32bit)

It will take quite a time to buid for RaspbianOS buster(32 bit).
