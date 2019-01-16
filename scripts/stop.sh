#!/bin/bash

echo "Stopping all eoslocal services"

docker exec -i eosdemo_eosio ./scripts/stop.sh

docker-compose down
