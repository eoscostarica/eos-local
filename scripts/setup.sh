#!/bin/bash
echo "Building images"
docker-compose build

echo "Initializing docker containers"
docker-compose up -d mongo postgres
sleep 5s
docker-compose up -d eosiodev
sleep 3s
docker-compose up -d fullnode

echo "Initializing Postgres"
docker-compose up flyway

read -p "Initializing Chain data (y/n)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  docker-compose run eosiodev /opt/application/scripts/0000_init-chain.sh
fi

echo "Initializing demux!"
docker-compose up -d demux

echo "Initializing admin-mongo!"
docker-compose up -d admin-mongo

echo "Installing frontend packages"
cd services/frontend
yarn install
