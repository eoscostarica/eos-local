#!/usr/bin/env bash

unlock_wallet() {
  cleos wallet unlock --password $(cat eosio.pwd) || echo ""
  sleep 1
}

lock_wallet() {
  cleos wallet lock
  sleep 1
}

genesis() {
  echo "====================================== Start genesis ======================================"
  sed -i "s/TESTNET_EOSIO_PUBLIC_KEY/$TESTNET_EOSIO_PUBLIC_KEY/" genesis.json
  nodeos \
  --config-dir config \
  --data-dir data \
  --blocks-dir blocks \
  --delete-all-blocks \
  --signature-provider $TESTNET_EOSIO_PUBLIC_KEY=KEY:$TESTNET_EOSIO_PRIVATE_KEY \
  --genesis-json genesis.json \
  >> "nodeos.log" 2>&1 &

  while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:8888/v1/chain/get_info)" != "200" ]]; 
  do
    sleep 1
  done
  echo "====================================== Done genesis ======================================"
}

setup_wallet () {
  cleos wallet create -f eosio.pwd
  cleos wallet import --private-key $TESTNET_EOSIO_PRIVATE_KEY
  lock_wallet
}

setup_accounts() {
  echo "====================================== Start setup_accounts ======================================"
  unlock_wallet
  accounts=( \
    "eosio.bpay" \
    "eosio.msig" \
    "eosio.names" \
    "eosio.ram" \
    "eosio.ramfee" \
    "eosio.saving" \
    "eosio.stake" \
    "eosio.token" \
    "eosio.vpay" \
    "eosio.rex" \
  )

  for account in "${accounts[@]}"; do
    cleos create account eosio $account $TESTNET_EOSIO_PUBLIC_KEY
  done
  lock_wallet
  echo "====================================== Done setup_accounts ======================================"
}

setup_contracts() {
  echo "====================================== Start setup_contracts ======================================"
  unlock_wallet
  # Activate PREACTIVATE_FEATURE
  curl --request POST \
    --url http://127.0.0.1:8888/v1/producer/schedule_protocol_feature_activations \
    -d '{"protocol_features_to_activate": ["0ec7e080177b2c02b278d5088611686b49d739925a92d9bfcacd7fc6b74053bd"]}' \
    && echo -e "\n"
  sleep 1

  # Deploy eosio.boot contract
  cleos set contract eosio /eosio.boot/

  # GET_SENDER
  cleos push action eosio activate '["f0af56d2c5a48d60a4a5b5c903edfb7db3a736a94ed589d0b797df33ff9d3e1d"]' -p eosio
  # FORWARD_SETCODE
  cleos push action eosio activate '["2652f5f96006294109b3dd0bbde63693f55324af452b799ee137a81a905eed25"]' -p eosio
  # ONLY_BILL_FIRST_AUTHORIZER
  cleos push action eosio activate '["8ba52fe7a3956c5cd3a656a3174b931d3bb2abb45578befc59f283ecd816a405"]' -p eosio
  # RESTRICT_ACTION_TO_SELF
  cleos push action eosio activate '["ad9e3d8f650687709fd68f4b90b41f7d825a365b02c23a636cef88ac2ac00c43"]' -p eosio
  # DISALLOW_EMPTY_PRODUCER_SCHEDULE
  cleos push action eosio activate '["68dcaa34c0517d19666e6b33add67351d8c5f69e999ca1e37931bc410a297428"]' -p eosio
  # FIX_LINKAUTH_RESTRICTION
  cleos push action eosio activate '["e0fb64b1085cc5538970158d05a009c24e276fb94e1a0bf6a528b48fbc4ff526"]' -p eosio
  # REPLACE_DEFERRED
  cleos push action eosio activate '["ef43112c6543b88db2283a2e077278c315ae2c84719a8b25f25cc88565fbea99"]' -p eosio
  # NO_DUPLICATE_DEFERRED_ID
  cleos push action eosio activate '["4a90c00d55454dc5b059055ca213579c6ea856967712a56017487886a4d4cc0f"]' -p eosio
  # ONLY_LINK_TO_EXISTING_PERMISSION
  cleos push action eosio activate '["1a99a59d87e06e09ec5b028a9cbb7749b4a5ad8819004365d02dc4379a8b7241"]' -p eosio
  # RAM_RESTRICTIONS
  cleos push action eosio activate '["4e7bf348da00a945489b2a681749eb56f5de00b900014e137ddae39f48f69d67"]' -p eosio
  # WEBAUTHN_KEY
  cleos push action eosio activate '["4fca8bd82bbd181e714e283f83e1b45d95ca5af40fb89ad3977b653c448f78c2"]' -p eosio
  # WTMSIG_BLOCK_SIGNATURES
  cleos push action eosio activate '["299dcb6af692324b899b39f16d5a530a33062804e41f09dc97e9f156b4476707"]' -p eosio
  sleep 1

  # Deploy system contract
  cleos set code eosio /eosio.contracts/eosio.system/eosio.system.wasm
  sleep 1
  cleos set abi eosio /eosio.contracts/eosio.system/eosio.system.abi
  sleep 1

  # Deploy eosio.token and eosio.msig contracts
  cleos set contract eosio.token /eosio.contracts/eosio.token/
  cleos set contract eosio.msig /eosio.contracts/eosio.msig/
  cleos push action eosio setpriv '["eosio.msig", 1]' -p eosio@active

  cleos push action eosio.token create '[ "eosio", "10000000000.0000 EOS" ]' -p eosio.token@active
  cleos push action eosio.token issue '[ "eosio", "1000000000.0000 EOS", "memo" ]' -p eosio@active
  cleos push action eosio init '["0", "4,EOS"]' -p eosio@active

  lock_wallet
  echo "====================================== Done setup_contracts ======================================"
}

start() {
  echo "====================================== Start ======================================"
  nodeos \
  --config-dir config \
  --data-dir data \
  --blocks-dir blocks \
  >> "nodeos.log" 2>&1 &
  sleep 10;

  if [ -z "$(pidof nodeos)" ]; then
    echo "====================================== Start hard replay ======================================"
    nodeos \
    --config-dir config \
    --data-dir data \
    --blocks-dir blocks \
    --hard-replay-blockchain \
    >> "nodeos.log" 2>&1 & \
  fi
}

logs() {
  tail -n 100 -f nodeos.log
}

if [ ! -f inited ]; then
  genesis
  setup_wallet
  setup_accounts
  setup_contracts
  touch inited
else
  start
fi

logs