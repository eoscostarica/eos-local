#!/usr/bin/env bash

# Throws error when using unset variable
set -ux

# Alias cleos with endpoint param to avoid repetition
# We use as host here because that service name configured in docker-compose.yml
cleos="cleos -u http://eosio:8888 --wallet-url http://wallet:8901"

# Creates an eos account with 10.0000 EOS
function create_eos_account () {
  # $cleos system newaccount eosio --transfer $1 $2 $2 --stake-net '1 EOS' --stake-cpu '1 EOS' --buy-ram '1 EOS'
  $cleos create account eosio $1 $2 $2
  $cleos push action eosio.token issue '[ "'$1'", "10.0000 EOS", "initial stake - free tokens" ]' -p eosio
}

# Unlocks the eoslocal wallet and waits .5 seconds
function unlock_wallet () {
  echo "unlocking eoslocal wallet..."
  $cleos wallet unlock --name eoslocal --password $(cat $CONFIG_DIR/keys/eoslocal_wallet_password.txt)
  sleep .5
}

# Create the eoslocal wallet and stores the password on a file
function create_wallet () {
  echo "Creating wallet"
  WALLET_PASSWORD=$($cleos wallet create --name eoslocal --to-console | awk 'FNR > 3 { print $1 }' | tr -d '"')
  echo $WALLET_PASSWORD > "$CONFIG_DIR"/keys/eoslocal_wallet_password.txt
  sleep .5
}

# Helper function to import private key into the eoslocal wallet
function import_private_key () {
  $cleos wallet import --name eoslocal --private-key $1
}

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

  echo "Create and allocate the EOS currency"
  $cleos push action eosio.token create '[ "eosio", "1000000000.0000 EOS"]' -p eosio.token@active
  $cleos push action eosio.token issue '[ "eosio", "900000000.0000 EOS", "initial supply" ]' -p eosio@active

  # TODO:  Why is this required to build eosio.system if symbol is EOS in build args ?
  $cleos push action eosio.token create '[ "eosio", "1000000000.0000 SYS"]' -p eosio.token@active
  $cleos push action eosio.token issue '[ "eosio", "900000000.0000 SYS", "initial supply" ]' -p eosio@active

  echo "Deploy eosio.system"
  $cleos set contract eosio /contracts/eosio.system

  echo "Deploy eosio.bios"
  $cleos set contract eosio /contracts/eosio.bios

  echo "Make eosio.msig privileged"
  $cleos push action eosio setpriv '["eosio.msig", 1]' -p eosio@active
}


# Create testing user accounts, use these key configure scatter, lynx and other wallets
function create_testing_accounts () {
  echo "Creating testing accounts"

  USER_A_ACCOUNT="eoslocalusra"
  USER_A_PVTKEY="5K4MHQN7sPdEURaxzjCnbynUwkEKRJzs8zVUf24ofaFiZNK815J"
  USER_A_PUBKEY="EOS5k6Jht1epqZ2mnRLFVDXDTosaTneR6xFhvenVLiFfz5Ue125dL"

  USER_B_ACCOUNT="eoslocalusrb"
  USER_B_PVTKEY="5JHCQDi7jsbnQnWdyxteRjT2DdNZHePiEG1DTaPQQDDP2X6aor6"
  USER_B_PUBKEY="EOS6TVQ6EmphCWavUuYiZMmDNYMRgbb96wgqWDncjrkvFPcpokgdD"

  USER_C_ACCOUNT="eoslocalusrc"
  USER_C_PVTKEY="5JXCt633pzYaUysn7exDHeVXwhwMjX2L231b37CdsSb7y1uvDH7"
  USER_C_PUBKEY="EOS7CB47VMLWp49QhajE3uTuHuf9qoSeR6scUHMKGCD6LXYufRUDc"

  USER_D_ACCOUNT="eoslocalusrd"
  USER_D_PVTKEY="5JdRgeRBriBDdxb3r76sLJaQmwGgXkMU8GReTAmy8xYppMSAAoZ"
  USER_D_PUBKEY="EOS6Jv4RykLZQQopCBdBHSwaGoMyFxyaxFNXimqFPdEXNWqgWbG1a"

  USER_E_ACCOUNT="eoslocalusre"
  USER_E_PVTKEY="5Jdwjwto9wxy5ZNPnWSn965eb8ZtSrK1uRKUxhviLpr9gK79hmM"
  USER_E_PUBKEY="EOS5VdFvRRTtVQAPUJZQCYvpBekYV4nc1cFe7og9aYPTBMXZ38Koy"

  import_private_key $USER_A_PVTKEY
  import_private_key $USER_B_PVTKEY
  import_private_key $USER_C_PVTKEY
  import_private_key $USER_D_PVTKEY
  import_private_key $USER_E_PVTKEY

  create_eos_account $USER_A_ACCOUNT $USER_A_PUBKEY
  create_eos_account $USER_B_ACCOUNT $USER_B_PUBKEY
  create_eos_account $USER_C_ACCOUNT $USER_C_PUBKEY
  create_eos_account $USER_D_ACCOUNT $USER_D_PUBKEY
  create_eos_account $USER_E_ACCOUNT $USER_E_PUBKEY
}

sleep 5s
until curl eosio:8888/v1/chain/get_info
do
  sleep 1s
done

# setup chain, testing users and contracts
create_wallet
import_private_key 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3 # eosio producer key
create_eosio_accounts
deploy_system_contracts
create_testing_accounts
