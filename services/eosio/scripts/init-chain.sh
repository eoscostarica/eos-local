#!/usr/bin/env bash

# Throws error when using unset variable
set -ux

# Alias cleos with endpoint param to avoid repetition
# We use as host here because that service name configured in docker-compose.yml
cleos="cleos -u http://eosio:8888 --wallet-url http://eos-wallet:8901"

# Creates an eos account with 10.0000 EOS
function create_eos_account () {
  # $cleos system newaccount eosio --transfer $1 $2 $2 --stake-net '1 EOS' --stake-cpu '1 EOS' --buy-ram '1 EOS'
  $cleos create account eosio $1 $2 $2
  $cleos push action eosio.token issue '[ "'$1'", "10.0000 EOS", "initial stake - free tokens" ]' -p eosio
}

# Unlocks the default wallet and waits .5 seconds
function unlock_wallet () {
  echo "unlocking default wallet..."
  $cleos wallet unlock --password $(cat $CONFIG_DIR/keys/default_wallet_password.txt)
  sleep .5
}

# Create the default wallet and stores the password on a file
function create_wallet () {
  echo "Creating wallet"
  WALLET_PASSWORD=$($cleos wallet create --to-console | awk 'FNR > 3 { print $1 }' | tr -d '"')
  echo $WALLET_PASSWORD > "$CONFIG_DIR"/keys/default_wallet_password.txt
  sleep .5
}

# Helper funciton to import private key into the default wallet
function import_private_key () {
  $cleos wallet import --private-key $1
}

# Helper funciton to create system accounts
function create_system_account () {
  $cleos create account eosio $1 $2
}

# Creates eosio system accounts
# https://developers.eos.io/eosio-nodeos/docs/bios-boot-sequence#section-step-3-create-important-system-accounts
function create_eosio_accounts () {
  # eosio.bpay
  BPAY_PVTKEY="5KAVVPzPZnbAx8dHz6UWVPFDVFtU1P5ncUzwHGQFuTxnEbdHJL4"
  BPAY_PUBKEY="EOS84BLRbGbFahNJEpnnJHYCoW9QPbQEk2iHsHGGS6qcVUq9HhutG"
  import_private_key $BPAY_PVTKEY
   eosio.bpay $BPAY_PUBKEY
  # eosio.msig
  MSIG_PVTKEY="5JweNBD7uWcysVW9M5GMgvuHCcUhoxopACrK8egMX31WDGQF3qv"
  MSIG_PUBKEY="EOS7pvbQJxNQMEMBizL6WCCroqQkpYogUNoS3NmETy6XK73dXQsBT"
  import_private_key $MSIG_PVTKEY
  create_system_account eosio.msig $MSIG_PUBKEY
  # eosio.names
  NAMES_PVTKEY="5J173EL5Wvp9tWW38DpTtbesuE3CpbT8B3C62ub3eFYKLZnVokr"
  NAMES_PUBKEY="EOS7C9UXs3fZCCxDW8dhLZWtcpoDRW3A9j9qaRj9euLFQDWaGADHJ"
  import_private_key $NAMES_PVTKEY
  create_system_account eosio.names $NAMES_PUBKEY
  # eosio.ram
  RAM_PVTKEY="5JY6ES262GV87BHufZ6ktu57FGuDThHEEu3xE5kxNZfYJmHqCJo"
  RAM_PUBKEY="EOS8jj53UWtbdacA8WGpzKN88Y6F6W4AQNHHwR4Upy1F8ewVG2crD"
  import_private_key $RAM_PVTKEY
  create_system_account eosio.ram $RAM_PUBKEY
  # eosio.ramfee
  RAMFEE_PVTKEY="5JrzFNaKmcnxu5qQupVEqVSaF7SRknRFrjXFo5wLShUL8WJUkL8"
  RAMFEE_PUBKEY="EOS6u1SNetnKtpi5xzxgcUz9Hn9MC3kUhBeiXMiQzKYuzVcr9j8ft"
  import_private_key $RAMFEE_PVTKEY
  create_system_account eosio.ramfee $RAMFEE_PUBKEY
  # eosio.saving
  SAVING_PVTKEY="5KeBzreGmgw4FX9zYswvBDMiVQvSTK1UGRuQgj14ZrqbtsdPk7z"
  SAVING_PUBKEY="EOS7Zt4QsM5bb8PR9TERKDphJ6AxefX8oLngEcc3h5kQtrMQY7b5g"
  import_private_key $SAVING_PVTKEY
  create_system_account eosio.saving $SAVING_PUBKEY
  # eosio.stake
  STAKE_PVTKEY="5KejNGA7WUFhNVztXa7WBvbWBa7kvcXMWAhtDw9NS6FNG5XU6HT"
  STAKE_PUBKEY="EOS8TSTK5Tuw3LGyw1KZsWeJGGidUsd5UfKKyUro27xyopu2gE5T1"
  import_private_key $STAKE_PVTKEY
  create_system_account eosio.stake $STAKE_PUBKEY
  # eosio.token
  TOKEN_PVTKEY="5JnpLZYZoaeWhfda8fT5RjSFQ533EGobUMDbc84uGTJEqYyTsNJ"
  TOKEN_PUBKEY="EOS6vzfJTSUM51MEWXDyuh2fDDfs5FdRX5hn3teMdroTwaNv6ptAE"
  import_private_key $TOKEN_PVTKEY
  create_system_account eosio.token $TOKEN_PUBKEY
  # eosio.vpay
  VPAY_PVTKEY="5JtpC9zNRZccTsMSJhNEGru5oqqrXjT2Qz5mBQKDASSLScmjP3i"
  VPAY_PUBKEY="EOS5A3ZChGL2tL1oJvhN7KScmGUAT4DsxZFEywRShGQHLeN2ndp8W"
  import_private_key $VPAY_PVTKEY
  create_system_account eosio.vpay $VPAY_PUBKEY
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
