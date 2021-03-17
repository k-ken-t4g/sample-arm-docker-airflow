#!/bin/bash

mkdir ./dags ./logs ./plugins
chown -R $(whoami):$(whoami) ./dags
chown -R $(whoami):$(whoami) ./logs
chown -R $(whoami):$(whoami) ./plugins
echo -e "AIRFLOW_UID=$(id -u)\nAIRFLOW_GID=$(id -g)\nDOCKER_GROUP_ID=$(getent group docker | cut -d: -f3) " > .env
