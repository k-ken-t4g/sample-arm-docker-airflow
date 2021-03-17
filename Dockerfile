ARG PYTHON_VERSION=3.8

FROM python:${PYTHON_VERSION}

SHELL ["/bin/bash", "-o", "pipefail", "-e", "-u", "-x", "-c"]

ARG PYTHON_VERSION=3.8
ARG AIRFLOW_VERSION=2.0.1
ARG AIRFLOW_USER_HOME_DIR=/home/airflow
ENV AIRFLOW_USER_HOME_DIR=${AIRFLOW_USER_HOME_DIR}

ARG AIRFLOW_HOME=/opt/airflow
ARG AIRFLOW_UID="50000"
ARG AIRFLOW_GID="50000"

ENV AIRFLOW_UID=${AIRFLOW_UID}
ENV AIRFLOW_GID=${AIRFLOW_GID}

RUN apt update && \
    apt upgrade -y

RUN apt-get install -y --no-install-recommends \
           curl \
           gnupg2 \
    && apt-get autoremove -yqq --purge \
    && apt-get clean

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        freetds-bin \
        krb5-user \
        ldap-utils \
        libffi6 \
        libsasl2-2 \
        libsasl2-modules \
        libssl1.1 \
        locales  \
        lsb-release \
        sasl2-bin \
        sqlite3 \
        unixodbc \
	dumb-init \
	netcat; \
        apt autoremove -yqq --purge

RUN PYTHON_VERSION="$(python --version | cut -d " " -f 2 | cut -d "." -f 1-2)"; \
    CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"; \
    pip install "apache-airflow[postgres,slack,celery,docker,cncf.kubernetes,redis]==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}" \
    --extra-index-url https://www.piwheels.org/simple

RUN pip install Docker --extra-index-url https://www.piwheels.org/simple

ENV PATH="${AIRFLOW_USER_HOME_DIR}/.local/bin:${PATH}"
ENV GUNICORN_CMD_ARGS="--worker-tmp-dir /dev/shm"

RUN addgroup --gid "${AIRFLOW_GID}" "airflow"  && \
    adduser --quiet "airflow" --uid "${AIRFLOW_UID}" \
	--gid "${AIRFLOW_GID}" \
        --home "${AIRFLOW_USER_HOME_DIR}" \
	--gecos ""

ENV AIRFLOW_HOME=${AIRFLOW_HOME}

# Make Airflow files belong to the root group and are accessible. This is to accommodate the guidelines from
# OpenShift https://docs.openshift.com/enterprise/3.0/creating_images/guidelines.html
RUN mkdir -pv "${AIRFLOW_HOME}"; \
    mkdir -pv "${AIRFLOW_HOME}/dags"; \
    mkdir -pv "${AIRFLOW_HOME}/logs"; \
    chown -R "airflow:root" "${AIRFLOW_USER_HOME_DIR}" "${AIRFLOW_HOME}"; \
    find "${AIRFLOW_HOME}" -executable -print0 | xargs --null chmod g+x && \
        find "${AIRFLOW_HOME}" -print0 | xargs --null chmod g+rw

COPY --chown=airflow:root entrypoint/entrypoint_prod.sh /entrypoint
COPY --chown=airflow:root entrypoint/clean-logs.sh /clean-logs
RUN chmod a+x /entrypoint /clean-logs

WORKDIR ${AIRFLOW_HOME}
EXPOSE 8080

USER ${AIRFLOW_UID}

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/entrypoint"]
CMD ["--help"]
