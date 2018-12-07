#!/usr/bin/env bash
echo "Starting eosio service ..."

rm /opt/application/nodeos.log

if [ "$(ls -A $DATA_DIR)" ]; then
    /opt/eosio/bin/nodeos --config-dir $CONFIG_DIR --data-dir $DATA_DIR -e --hard-replay >> /opt/application/nodeos.log 2>&1 & tail -f /opt/application/nodeos.log
else
    /opt/eosio/bin/nodeos --config-dir $CONFIG_DIR --data-dir $DATA_DIR -e >> /opt/application/nodeos.log 2>&1 & tail -f /opt/application/nodeos.log
fi
