#!/usr/bin/env bash

# Throws error when using unset variable
set -ux

# Import helper functions
source $(dirname $0)/helpers.sh

# Helper function to create system accounts
function create_system_account () {
  $cleos create account eosio $1 $2
}

# Creates eosio system accounts
# https://developers.eos.io/eosio-nodeos/docs/bios-boot-sequence#section-step-3-create-important-system-accounts
function create_eosio_accounts () {
  EOSIO_PVTKEY="5KAVVPzPZnbAx8dHz6UWVPFDVFtU1P5ncUzwHGQFuTxnEbdHJL4"
  EOSIO_PUBKEY="EOS84BLRbGbFahNJEpnnJHYCoW9QPbQEk2iHsHGGS6qcVUq9HhutG"

  import_private_key $EOSIO_PVTKEY

  create_system_account eosio.bpay $EOSIO_PUBKEY
  create_system_account eosio.msig $EOSIO_PUBKEY
  create_system_account eosio.names $EOSIO_PUBKEY
  create_system_account eosio.ram $EOSIO_PUBKEY
  create_system_account eosio.ramfee $EOSIO_PUBKEY
  create_system_account eosio.saving $EOSIO_PUBKEY
  create_system_account eosio.stake $EOSIO_PUBKEY
  create_system_account eosio.token $EOSIO_PUBKEY
  create_system_account eosio.vpay $EOSIO_PUBKEY
}

function deploy_system_contracts () {
  echo "Deploy eosio.token"
  $cleos set contract eosio.token /contracts/eosio.token

  echo "Deploy eosio.msig"
  $cleos set contract eosio.msig /contracts/eosio.msig

  echo "Create and allocate the SYS currency"  # https://github.com/EOSIO/eos/issues/3996
  $cleos push action eosio.token create '[ "eosio", "10000000000.0000 SYS"]' -p eosio.token@active
  $cleos push action eosio.token issue '[ "eosio", "10000000000.0000 SYS", "initial supply" ]' -p eosio@active

  echo "Create and allocate the EOS currency"
  $cleos push action eosio.token create '[ "eosio", "10000000000.0000 EOS"]' -p eosio.token@active
  $cleos push action eosio.token issue '[ "eosio", "10000000000.0000 EOS", "initial supply" ]' -p eosio@active

  echo "Deploy eosio.system"
  $cleos set contract eosio /contracts/eosio.system

  echo "Deploy eosio.bios"
  $cleos set contract eosio /contracts/eosio.bios

  echo "Make eosio.msig privileged"
  $cleos push action eosio setpriv '["eosio.msig", 1]' -p eosio@active
}

# Make sure nodeos is running in the docker container
sleep 5s
until curl eosio:8888/v1/chain/get_info
do
  sleep 1s
done

# Setup wallet and import the producer key
create_wallet
import_private_key 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3

# Initialize chain
create_eosio_accounts
deploy_system_contracts
