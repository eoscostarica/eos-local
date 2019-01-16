#!/bin/bash
docker volume rm keosd-data-volume
rm services/eosio/config/keys/wallet_password.txt
echo "Removed eoslocal-keosd-data and wallet_password.txt file"
