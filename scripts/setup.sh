#!/bin/bash
echo "Building images"
docker-compose build

echo "Initializing docker containers"
docker-compose up -d mongo postgres
sleep 5s
docker-compose up -d eos-producer
sleep 3s
docker-compose up -d eos-api-node

echo "Initializing Postgres"
docker-compose up flyway

read -p "Initializing Chain data (y/n)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  docker-compose run eos-producer /opt/application/scripts/0000_init-chain.sh
fi

echo "Initializing demux!"
docker-compose up -d demux

echo "Initializing admin-mongo!"
docker-compose up -d admin-mongo

echo "Initializing pgweb!"
docker-compose up -d pgweb

echo "Installing frontend packages"
cd services/frontend
yarn install

yarn start
