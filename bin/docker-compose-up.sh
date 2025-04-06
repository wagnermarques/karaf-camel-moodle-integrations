#!/bin/bash

sudo groupadd --gid 33 www-data
sudo useradd --uid 33 --gid www-data --no-create-home --shell /sbin/nologin www-data

cd ./../containers
docker-compose -f docker-compose.yml up -d --build
