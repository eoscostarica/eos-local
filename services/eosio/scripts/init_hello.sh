#!/usr/bin/env bash

# Throws error when using unset variable
set -ux

# Import helper functions
source $(dirname $0)/helpers.sh

source $(dirname $0)/unlock.sh

HELLO_PRIVKEY="5Khs2zo5wiK7yxcff5DqZ6tuJR7KQ1EqazG8Sj4jyTYGWLfo7Wb"
HELLO_PUBKEY="EOS6wHmRL5riQ1geW64kM4RmDbPCnWQ9bBzuP7K8nA4eKJ7JQrDJ6"

import_private_key $HELLO_PRIVKEY

create_eos_account hello $HELLO_PUBKEY $INTERX_PUBKEY

$cleos system buyram hello hello '20 EOS'
$cleos system delegatebw hello hello '4 EOS' '4 EOS'

cd /opt/contracts/hello
eosio-cpp -abigen hello.cpp -o hello.wasm
cd ..
$cleos set contract hello ./hello -p hello@active
