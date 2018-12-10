#!/bin/bash
echo "Flushing all blockchain and databases data"
docker-compose down -v

# remove o
rm "$(dirname "$0")/../services/eosio/config/keys/eoslocal_wallet_password.txt"
