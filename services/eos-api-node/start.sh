#!/usr/bin/env bash
echo "Starting eos-api-node service ..."

if [ "$(ls -A $DATA_DIR)" ]; then
  /opt/eosio/bin/nodeosd.sh --data-dir $DATA_DIR --http-alias=eos-api-node:8888 --http-alias=127.0.0.1:8888 --http-alias=localhost:8888 --hard-replay
else1
  /opt/eosio/bin/nodeosd.sh --data-dir $DATA_DIR --http-alias=eos-api-node:8888 --http-alias=127.0.0.1:8888 --http-alias=localhost:8888 # --genesis-json /opt/eosio/bin/genesis.json --delete-all-blocks
fi
