#!/usr/bin/env bash
EOSIO_PRIVATE_KEY="5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3"
EOSIO_PUBLIC_KEY="EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV"

EOSIO_SYS_PUBKEY="EOS8VJybqtm41PMmXL1QUUDSfCrs9umYN4U1ZNa34JhPZ9mU5r2Cm"
EOSIO_SYS_PVTKEY="5JGxnezvp3N4V1NxBo8LPBvCrdR85bZqZUFvBZ8ACrbRC3ZWNYv"

EOSLOCAL_ACCOUNT_PRIVATE_OWNER_KEY="5J5t5MuUmMgNcrFWiXyeBZEsCfHvgYE7Lec4W2wCaV5SiSoEqQr"
EOSLOCAL_ACCOUNT_PUBLIC_OWNER_KEY="EOS6P62N6D14ShhUnM7taEQHLTMmS7ohCyfikwAi46U7AT6jmUHyM"

EOSLOCAL_ACCOUNT_PRIVATE_ACTIVE_KEY="5JhTPDSe9ugHomFnhMgAdzzE2HniuR8rG3SyzzqvQrgJNPC4685"
EOSLOCAL_ACCOUNT_PUBLIC_ACTIVE_KEY="EOS5X6m7mxcKRsKvHDyCVp1DE5YAy5dEsb5TwFqG4F2xRvRYAAdZx"

EOSLOCAL_USERA_ACCOUNT="eoslocalusra"
EOSLOCAL_USERA_PVTKEY="5K4MHQN7sPdEURaxzjCnbynUwkEKRJzs8zVUf24ofaFiZNK815J"
EOSLOCAL_USERA_PUBKEY="EOS5k6Jht1epqZ2mnRLFVDXDTosaTneR6xFhvenVLiFfz5Ue125dL"

EOSLOCAL_USERB_ACCOUNT="eoslocalusrb"
EOSLOCAL_USERB_PVTKEY="5JHCQDi7jsbnQnWdyxteRjT2DdNZHePiEG1DTaPQQDDP2X6aor6"
EOSLOCAL_USERB_PUBKEY="EOS6TVQ6EmphCWavUuYiZMmDNYMRgbb96wgqWDncjrkvFPcpokgdD"

EOSLOCAL_USERC_ACCOUNT="eoslocalusrc"
EOSLOCAL_USERC_PVTKEY="5JXCt633pzYaUysn7exDHeVXwhwMjX2L231b37CdsSb7y1uvDH7"
EOSLOCAL_USERC_PUBKEY="EOS7CB47VMLWp49QhajE3uTuHuf9qoSeR6scUHMKGCD6LXYufRUDc"

EOSLOCAL_USERD_ACCOUNT="eoslocalusrd"
EOSLOCAL_USERD_PVTKEY="5JdRgeRBriBDdxb3r76sLJaQmwGgXkMU8GReTAmy8xYppMSAAoZ"
EOSLOCAL_USERD_PUBKEY="EOS6Jv4RykLZQQopCBdBHSwaGoMyFxyaxFNXimqFPdEXNWqgWbG1a"

EOSLOCAL_USERE_ACCOUNT="eoslocalusre"
EOSLOCAL_USERE_PVTKEY="5Jdwjwto9wxy5ZNPnWSn965eb8ZtSrK1uRKUxhviLpr9gK79hmM"
EOSLOCAL_USERE_PUBKEY="EOS5VdFvRRTtVQAPUJZQCYvpBekYV4nc1cFe7og9aYPTBMXZ38Koy"

ROOT_DIR="/opt/eosio/bin"
CLEOS_PATH="$ROOT_DIR/cleos"
SCRIPTS_DIR="/opt/application/scripts"
CONFIG_DIR="/opt/application/config"
CONTRACTS_DIR="/opt/application/contracts"

# move into the executable directory
cd $ROOT_DIR

# ./nodeos --config-dir /opt/eosio/bin/config-dir --data-dir /root/.local/share -e & echo $! > ./nodeos.pid

# Only create contract if wallet doesn't exist
mkdir "$CONFIG_DIR"/keys

sleep 1s

until curl eosiodev:8888/v1/chain/get_info
do
    sleep 1s
done

# Sleep for 2 secs to allow time to 4 blocks to be
# created so we have blocks to reference when
# sending transactions
sleep 2s
echo "Creating accounts and deploying wallets"

# start wallet
wallet_password=$(./cleos wallet create --to-console | awk 'FNR > 3 { print $1 }' | tr -d '"')
echo $wallet_password > "$CONFIG_DIR"/keys/default_wallet_password.txt

# import wallet keys
sleep 2s
./cleos wallet import -n default --private-key $EOSIO_PRIVATE_KEY
./cleos wallet import -n default --private-key $EOSIO_SYS_PVTKEY
./cleos wallet import -n default --private-key $EOSLOCAL_ACCOUNT_PRIVATE_OWNER_KEY
./cleos wallet import -n default --private-key $EOSLOCAL_ACCOUNT_PRIVATE_ACTIVE_KEY
./cleos wallet import -n default --private-key $EOSLOCAL_USERA_PVTKEY
./cleos wallet import -n default --private-key $EOSLOCAL_USERB_PVTKEY
./cleos wallet import -n default --private-key $EOSLOCAL_USERC_PVTKEY
./cleos wallet import -n default --private-key $EOSLOCAL_USERD_PVTKEY
./cleos wallet import -n default --private-key $EOSLOCAL_USERE_PVTKEY

# create system accounts
sleep .5
./cleos -u http://eosiodev:8888 create account eosio eosio.bpay $EOSIO_SYS_PUBKEY $EOSIO_SYS_PUBKEY
sleep .5
./cleos -u http://eosiodev:8888 create account eosio eosio.msig $EOSIO_SYS_PUBKEY $EOSIO_SYS_PUBKEY
sleep .5
./cleos  -u http://eosiodev:8888 create account eosio eosio.names $EOSIO_SYS_PUBKEY $EOSIO_SYS_PUBKEY
sleep .5
./cleos  -u http://eosiodev:8888 create account eosio eosio.ram $EOSIO_SYS_PUBKEY $EOSIO_SYS_PUBKEY
sleep .5
./cleos  -u http://eosiodev:8888 create account eosio eosio.ramfee $EOSIO_SYS_PUBKEY $EOSIO_SYS_PUBKEY
sleep .5
./cleos  -u http://eosiodev:8888 create account eosio eosio.saving $EOSIO_SYS_PUBKEY $EOSIO_SYS_PUBKEY
sleep .5
./cleos  -u http://eosiodev:8888 create account eosio eosio.stake $EOSIO_SYS_PUBKEY $EOSIO_SYS_PUBKEY
sleep .5
./cleos  -u http://eosiodev:8888 create account eosio eosio.token $EOSIO_SYS_PUBKEY $EOSIO_SYS_PUBKEY
sleep .5
./cleos  -u http://eosiodev:8888 create account eosio eosio.vpay $EOSIO_SYS_PUBKEY $EOSIO_SYS_PUBKEY

# deploy system account contracts
sleep .5
./cleos -u http://eosiodev:8888 set contract eosio.token /contracts/eosio.token
sleep .5
./cleos -u http://eosiodev:8888 set contract eosio.msig /contracts/eosio.msig

# issue tokens
sleep .5
./cleos -u http://eosiodev:8888 push action eosio.token create '["eosio", "10000000000.0000 SYS"]' -p eosio.token
sleep .5
./cleos -u http://eosiodev:8888 push action eosio.token issue '["eosio", "100000000.0000 SYS", "memo"]' -p eosio
sleep .5
./cleos -u http://eosiodev:8888 push action eosio.token create '["eosio", "10000000000.0000 EOS"]' -p eosio.token
sleep .5
./cleos -u http://eosiodev:8888 push action eosio.token issue '["eosio", "100000000.0000 EOS", "memo"]' -p eosio

# deploy the system contract
sleep 2s
./cleos -u http://eosiodev:8888 set contract eosio /contracts/eosio.system

# Create the eoslocaldapp account
sleep 2s
echo "Creating eoslocaldapp account"
cleos -u http://eosiodev:8888 system newaccount eosio --transfer eoslocaldapp $EOSLOCAL_ACCOUNT_PUBLIC_OWNER_KEY $EOSLOCAL_ACCOUNT_PUBLIC_ACTIVE_KEY --stake-net "100000.0000 SYS" --stake-cpu "100000.0000 SYS" --buy-ram "100000.000 SYS"
sleep .5
cleos -u http://eosiodev:8888 transfer eosio eoslocaldapp "1000000.0000 SYS"
cleos -u http://eosiodev:8888 transfer eosio eoslocaldapp "1000000.0000 EOS"

cleos set account permission eoslocaldapp active \
'{"threshold": 1,
  "keys": [{
    "key": "'${EOSLOCAL_ACCOUNT_PUBLIC_ACTIVE_KEY}'",
    "weight": 1
  }],
  "accounts": [{
    "permission": {"actor": "eoslocaldapp",
                   "permission": "eosio.code"},
                   "weight": 1
  }]}' owner -p eoslocaldapp


# echo "Compiling EOSLOCAL Contract"
eosio-cpp -o "$CONTRACTS_DIR"/eoslocal/eoslocal.wast "$CONTRACTS_DIR"/eoslocal/eoslocal.cpp
eosio-cpp -g "$CONTRACTS_DIR"/eoslocal/eoslocal.abi "$CONTRACTS_DIR"/eoslocal/eoslocal.cpp

echo "Deploying EOSLOCAL Contracts"
cleos -u http://eosiodev:8888 set contract eoslocal "$CONTRACTS_DIR"/eoslocal

sleep .5
echo "Creating user accounts"
cleos -u http://eosiodev:8888 system newaccount eosio --transfer $EOSLOCAL_USERA_ACCOUNT $EOSLOCAL_USERA_PUBKEY $EOSLOCAL_USERA_PUBKEY --stake-net "10.0000 SYS" --stake-cpu "10.0000 SYS" --buy-ram "10.000 SYS"
sleep .5
cleos -u http://eosiodev:8888 system newaccount eosio --transfer $EOSLOCAL_USERB_ACCOUNT $EOSLOCAL_USERB_PUBKEY $EOSLOCAL_USERB_PUBKEY --stake-net "10.0000 SYS" --stake-cpu "10.0000 SYS" --buy-ram "10.000 SYS"
sleep .5
cleos -u http://eosiodev:8888 system newaccount eosio --transfer $EOSLOCAL_USERC_ACCOUNT $EOSLOCAL_USERC_PUBKEY $EOSLOCAL_USERC_PUBKEY --stake-net "10.0000 SYS" --stake-cpu "10.0000 SYS" --buy-ram "10.000 SYS"
sleep .5
cleos -u http://eosiodev:8888 system newaccount eosio --transfer $EOSLOCAL_USERD_ACCOUNT $EOSLOCAL_USERD_PUBKEY $EOSLOCAL_USERD_PUBKEY --stake-net "10.0000 SYS" --stake-cpu "10.0000 SYS" --buy-ram "10.000 SYS"
sleep .5
cleos -u http://eosiodev:8888 system newaccount eosio --transfer $EOSLOCAL_USERE_ACCOUNT $EOSLOCAL_USERE_PUBKEY $EOSLOCAL_USERE_PUBKEY --stake-net "10.0000 SYS" --stake-cpu "10.0000 SYS" --buy-ram "10.000 SYS"

echo "Waiting for node boostraping to complete"
sleep 2s

echo "Change tolerance to 0 for testing purposes"
cleos -u http://eosiodev:8888 push action eoslocal changecrtol '{ "new_interval": 0 }' -p eoslocal

echo "Initialization Complete"
