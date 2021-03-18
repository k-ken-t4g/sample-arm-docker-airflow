# sample-arm-docker-airflow
Docker Apache Airflow(2.0.1) for RaspberryPi (ARM Architecture)

## Informations
- Based on Python 3.8 official image ([python:3.8](https://hub.docker.com/_/python))
- Uses official [Postgres](https://hub.docker.com/_/postgres/) as backend
- Uses official [redis](https://hub.docker.com/_/redis/) as queue
- Requires Docker and [Docker Compose](https://docs.docker.com/compose/install/)

## How to build localy

By excecuting `make` command by non-root user, it will automaticaly create airflow docker environment.

```
$ make airflow
```

Checked it will work on current environment
- Ubuntu 20.0.4(64bit)
- Raspbian OS(32bit)

It will take quite a time to buid for RaspbianOS buster(32 bit).
