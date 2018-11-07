#!/usr/bin/env bash

EOSIO_PRIVATE_KEY="5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3"
EOSIO_PUBLIC_KEY="EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV"

# https://infinitexlabs.com/eos-development-tutorial-part-1/
EOSLOCAL_ACCOUNT_PRIVATE_OWNER_KEY="5KacG2v3XYrjmxazgriHVo1updD7PKXJMWzcaQmBMMXE9Y69aW9"
EOSLOCAL_ACCOUNT_PUBLIC_OWNER_KEY="EOS88bvtAMTwPBQyF8cxFUFXez9zCoebABS3dXngdNphqNtiszLQh"

EOSLOCAL_ACCOUNT_PRIVATE_ACTIVE_KEY="5Hy5kAujsv4fVWa9xv784Pgy4eLgrrDf3trP49J3FvDpKRfzaNn"
EOSLOCAL_ACCOUNT_PUBLIC_ACTIVE_KEY="EOS8G66UbcXKfQ7unJES7BrKHggQMZfHUkTMkMF8nEbsktpjsb9tr"

echo "Creating wallet"
wallet_password=$(cleos -u http://eosiodev:8888 wallet create --to-console | awk 'FNR > 3 { print $1 }' | tr -d '"')
echo $wallet_password > "$CONFIG_DIR"/keys/default_wallet_password.txt

cleos -u http://eosiodev:8888 wallet open

cleos -u http://eosiodev:8888 wallet list

cleos -u http://eosiodev:8888 wallet unlock -n default --password $wallet_password

cleos -u http://eosiodev:8888 wallet list

echo "Importing keys"

cleos -u http://eosiodev:8888 wallet import --private-key $EOSLOCAL_ACCOUNT_PRIVATE_OWNER_KEY

cleos -u http://eosiodev:8888 wallet import --private-key $EOSLOCAL_ACCOUNT_PRIVATE_ACTIVE_KEY

cleos -u http://eosiodev:8888 wallet import --private-key $EOSIO_PRIVATE_KEY

echo "Creating demo accounts"

cleos -u http://eosiodev:8888 create account eosio bob $EOSLOCAL_ACCOUNT_PUBLIC_OWNER_KEY

cleos -u http://eosiodev:8888 create account eosio alice $EOSLOCAL_ACCOUNT_PUBLIC_OWNER_KEY

echo "Compiling demo contract"

eosio-cpp -o /opt/application/contracts/hello/hello.wast /opt/application/contracts/hello/hello.cpp --abigen

cleos -u http://eosiodev:8888 wallet keys

cleos -u http://eosiodev:8888 create account eosio hello $EOSLOCAL_ACCOUNT_PUBLIC_OWNER_KEY -p eosio@active

echo "Deploying demo contract"

cleos -u http://eosiodev:8888 set contract hello /opt/application/contracts/hello -p hello@active

echo "Testing contract"

cleos -u http://eosiodev:8888 push action hello hi '["bob"]' -p bob@active