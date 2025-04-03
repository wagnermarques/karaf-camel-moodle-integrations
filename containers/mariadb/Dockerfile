# ./mariadb/Dockerfile
ARG MARIADB_VERSION=10.11
FROM mariadb:${MARIADB_VERSION}

# Optional: Install OS-level packages if needed
# RUN apt-get update && apt-get install -y --no-install-recommends some-package && rm -rf /var/lib/apt/lists/*

# The base image handles data directory creation and initdb scripts.
# COPY ./initdb/ /docker-entrypoint-initdb.d/

# Standard MariaDB/MySQL port (already exposed by base image)
EXPOSE 3306
