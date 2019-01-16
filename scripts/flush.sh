#!/bin/bash
echo "Flushing all blockchain and databases data"
docker-compose down -v

# remove o
rm "$(dirname "$0")/../services/eosio/config/keys/wallet_password.txt"


echo "=======================IMPORTANT================================"
echo "The wallet docker volume keosd-data-volume and the eosdemo wallet password file are not removed by this command."
echo "That is in order avoid losing keys. Run 'make ditch_wallet' to remove the wallet and the password file"
echo "================================================================"
