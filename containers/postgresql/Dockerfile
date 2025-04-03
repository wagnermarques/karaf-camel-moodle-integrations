# ./postgres/Dockerfile
ARG POSTGRES_VERSION=15-alpine
FROM postgres:${POSTGRES_VERSION}

# Optional: Install OS-level packages if needed
# RUN apt-get update && apt-get install -y --no-install-recommends some-package && rm -rf /var/lib/apt/lists/*
# For Alpine:
# RUN apk add --no-cache some-package

# The base image handles data directory creation and initdb scripts.
# You could COPY init scripts here instead of mounting, but mounting is more common.
# COPY ./initdb/ /docker-entrypoint-initdb.d/

# Standard PostgreSQL port (already exposed by base image, but good practice)
EXPOSE 5432
