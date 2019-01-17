#!/usr/bin/env bash

source $(dirname $0)/stop.sh

echo "Starting eosio service ..."
LOGFILE=/opt/application/logs/nodeos.log

# always a new log file
rm $LOGFILE && touch $LOGFILE

nodeos --config-dir $CONFIG_DIR --data-dir $DATA_DIR -e >> $LOGFILE 2>&1 & echo $! > $DATA_DIR/nodeos.pid & tail -f $LOGFILE

