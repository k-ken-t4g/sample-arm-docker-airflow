#!/bin/bash

mkdir ./dags ./logs ./plugins
chown -R $(whoami):$(whoami) ./dags
chown -R $(whoami):$(whoami) ./logs
chown -R $(whoami):$(whoami) ./plugins

echo -e "AIRFLOW_UID=$(id -u)\nAIRFLOW_GID=$(id -g)\nDOCKER_GROUP_ID=$(getent group docker | cut -d: -f3) " > .env

if [[ $(dpkg --print-architecture) = "arm64" ]] ; then
	echo -e "ALPINE_VERSION=edge" >> .env
else
	echo -e "ALPINE_VERSION=3.12" >> .env
fi
