#!/usr/bin/env bash

# Throws error when using unset variable
set -ux

# Alias cleos with endpoint param to avoid repetition
cleos="cleos -u http://localhost:8888"

# Creates an eos account with 10.0000 EOS
function create_eos_account () {
    $cleos create account eoslocal $1 $2 $2
    $cleos push action eosio.token issue '[ "'$1'", "10.0000 EOS", "initial stake" ]' -p eosio
}

# Unlocks the default wallet and waits .5 seconds
function unlock_wallet () {
  echo "unlocking default wallet..."
  $cleos wallet unlock --password $(cat $CONFIG_DIR/keys/default_wallet_password.txt)
  sleep .5
}

function create_wallet () {
  echo "Creating wallet"
  WALLET_PASSWORD=$($cleos wallet create --to-console | awk 'FNR > 3 { print $1 }' | tr -d '"')
  echo $WALLET_PASSWORD > "$CONFIG_DIR"/keys/default_wallet_password.txt
  sleep .5
}

# initialize chain
function initialize () {

    # EOSIO keys
    EOSIO_PVTKEY="5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3"
    EOSIO_PUBKEY="EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV"

    # EOSLOCAL keys
    EOSLOCAL_OWNER_PVTKEY="5KacG2v3XYrjmxazgriHVo1updD7PKXJMWzcaQmBMMXE9Y69aW9"
    EOSLOCAL_OWNER_PUBKEY="EOS88bvtAMTwPBQyF8cxFUFXez9zCoebABS3dXngdNphqNtiszLQh"

    EOSLOCAL_ACTIVE_PVTKEY="5Hy5kAujsv4fVWa9xv784Pgy4eLgrrDf3trP49J3FvDpKRfzaNn"
    EOSLOCAL_ACTIVE_PUBKEY="EOS8G66UbcXKfQ7unJES7BrKHggQMZfHUkTMkMF8nEbsktpjsb9tr"

    echo "Importing eosio and eoslocal keys"
    $cleos wallet import --private-key $EOSIO_PVTKEY
    $cleos wallet import --private-key $EOSLOCAL_OWNER_PVTKEY
    $cleos wallet import --private-key $EOSLOCAL_ACTIVE_PVTKEY
    sleep .5

    echo "Deploy bios and token..."
    $cleos set contract eosio /contracts/eosio.bios -p eosio
    $cleos create account eosio eosio.token $EOSIO_PUBKEY $EOSIO_PUBKEY
    $cleos set contract eosio.token /contracts/eosio.token -p eosio.token
    $cleos push action eosio.token create '[ "eosio", "1000000000.0000 EOS", 0, 0, 0]' -p eosio.token
    sleep .5

    echo "Creates eoslocal account with stake..."
    $cleos create account eosio eoslocal $EOSLOCAL_OWNER_PUBKEY $EOSLOCAL_ACTIVE_PUBKEY
    $cleos push action eosio.token issue '[ "'eoslocal'", "1000.0000 EOS", "initial stake" ]' -p eosio
    sleep .5
}

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

  create_eos_account $USER_A_ACCOUNT $USER_A_PUBKEY
  create_eos_account $USER_B_ACCOUNT $USER_B_PUBKEY
  create_eos_account $USER_C_ACCOUNT $USER_C_PUBKEY
  create_eos_account $USER_D_ACCOUNT $USER_D_PUBKEY
  create_eos_account $USER_E_ACCOUNT $USER_E_PUBKEY
}

# build and deploy eoslocal demo contract
function build_and_deploy_contracts () {
  echo "Compiling contract"

  cd /opt/application/contracts/eoslocal

  eosio-cpp -abigen eoslocal.cpp -o eoslocal.wasm

  echo "Deploying contract"

  $cleos set contract eoslocal eoslocal -p eoslocal@active

  echo "Verifying contract actions and user wallets work"

  $cleos push action eoslocal greet '["eoslocalusra","Hello form USER A"]' -p eoslocalusra@active
  $cleos push action eoslocal greet '["eoslocalusrb","Hola hola hola from USER B"]' -p eoslocalusrb@active
}

# setup chain, testing users and contracts

create_wallet
initialize
create_testing_accounts
build_and_deploy_contracts

# debugging code
echo 'Wallet info:'
$cleos wallet list
find / -type f -name "*.wallet"
