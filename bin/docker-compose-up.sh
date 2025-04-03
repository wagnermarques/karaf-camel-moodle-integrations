#!/bin/bash
cd ./../containers
docker-compose -f docker-compose.yml up -d --build
