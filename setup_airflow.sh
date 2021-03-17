#!/bin/bash

mkdir ./dags ./logs ./plugins
chown -R $(whoami):$(whoami) ./dags
chown -R $(whoami):$(whoami) ./logs
chown -R $(whoami):$(whoami) ./plugins
echo -e "AIRFLOW_UID=$(id -u)\nAIRFLOW_GID=$(id -g)\nDOCKER_GROUP_ID=$(getent group docker | cut -d: -f3) " > .env

#sudo apt update
#sudo apt upgrade

#sudo apt-get install -y --no-install-recommends \
#        freetds-bin \
#        krb5-user \
#        ldap-utils \
#        libffi6 \
#        libsasl2-2 \
#        libsasl2-modules \
#        libssl1.1 \
#        locales  \
#        lsb-release \
#        sasl2-bin \
#        sqlite3 \
#        unixodbc

#AIRFLOW_VERSION=2.0.1
#PYTHON_VERSION="$(python --version | cut -d " " -f 2 | cut -d "." -f 1-2)"
#CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
#pip install "apache-airflow[postgres,slack,celery,docker,cncf.kubernetes,redis]==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"
