#!/usr/bin/env bash
echo "Starting eosio service ..."

LOGFILE=/opt/application/logs/nodeos.log
NODEOS=/opt/eosio/bin/nodeos

# always a new log file
rm $LOGFILE && touch $LOGFILE

if [ "$(ls -A $DATA_DIR)" ]; then
    $NODEOS --config-dir $CONFIG_DIR --data-dir $DATA_DIR -e --hard-replay >> $LOGFILE 2>&1 & tail -f $LOGFILE
else
    $NODEOS --config-dir $CONFIG_DIR --data-dir $DATA_DIR -e >> $LOGFILE 2>&1 & tail -f $LOGFILE
fi
