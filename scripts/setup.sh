#!/bin/bash
echo "Building eos wallet external docker volume"
docker volume create --name=keosd-data-volume

echo "Building images"
docker-compose build

echo "Initializing docker containers"
docker-compose up -d eosio

read -p "Initializing Chain data (y/n)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  docker-compose exec eosio bash /opt/application/scripts/setup.sh
fi

docker-compose up -d
