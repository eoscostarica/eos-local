#!/bin/bash
echo "Flushing all blockchain and databases data"
docker-compose down -v && rm -rf ./services/mongo/.dbdata
