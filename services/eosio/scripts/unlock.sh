#!/usr/bin/env bash

# Throws error when using unset variable
set -ux

# Alias cleos with endpoint param to avoid repetition
# We use as host here because that service name configured in docker-compose.yml
cleos="cleos -u http://eosio:8888 --wallet-url http://eos-wallet:8901"

# Unlocks the default wallet and waits .5 seconds
function unlock_wallet () {
  echo "unlocking default wallet..."
  $cleos wallet unlock --password $(cat $CONFIG_DIR/keys/default_wallet_password.txt)
  sleep .5
}

unlock_wallet
