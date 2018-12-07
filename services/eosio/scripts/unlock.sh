#!/usr/bin/env bash

# Throws error when using unset variable
set -ux

# Alias cleos with endpoint param to avoid repetition
# Host name is the service name configured in docker-compose.yml
cleos="cleos -u http://eosio:8888 --wallet-url http://wallet:8901"

# Unlocks the default wallet and waits .5 seconds
function unlock_wallet () {
  echo "unlocking default wallet..."
  $cleos wallet unlock --name eoslocal --password $(cat $CONFIG_DIR/keys/default_wallet_password.txt)
  sleep .5
}

unlock_wallet
