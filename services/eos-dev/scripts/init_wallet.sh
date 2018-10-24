#!/usr/bin/env bash

CONFIG_DIR="/opt/application/config"

EOSIO_PRIVATE_KEY="5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3"
EOSIO_PUBLIC_KEY="EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV"

EOSIO_SYS_PUBKEY="EOS8VJybqtm41PMmXL1QUUDSfCrs9umYN4U1ZNa34JhPZ9mU5r2Cm"
EOSIO_SYS_PVTKEY="5JGxnezvp3N4V1NxBo8LPBvCrdR85bZqZUFvBZ8ACrbRC3ZWNYv"

EOSLOCAL_ACCOUNT_PRIVATE_OWNER_KEY="5J5t5MuUmMgNcrFWiXyeBZEsCfHvgYE7Lec4W2wCaV5SiSoEqQr"
EOSLOCAL_ACCOUNT_PUBLIC_OWNER_KEY="EOS6P62N6D14ShhUnM7taEQHLTMmS7ohCyfikwAi46U7AT6jmUHyM"

EOSLOCAL_ACCOUNT_PRIVATE_ACTIVE_KEY="5JhTPDSe9ugHomFnhMgAdzzE2HniuR8rG3SyzzqvQrgJNPC4685"
EOSLOCAL_ACCOUNT_PUBLIC_ACTIVE_KEY="EOS5X6m7mxcKRsKvHDyCVp1DE5YAy5dEsb5TwFqG4F2xRvRYAAdZx"

EOSLOCAL_USERA_ACCOUNT="eoslocalusera"
EOSLOCAL_USERA_PVTKEY="5K4MHQN7sPdEURaxzjCnbynUwkEKRJzs8zVUf24ofaFiZNK815J"
EOSLOCAL_USERA_PUBKEY="EOS5k6Jht1epqZ2mnRLFVDXDTosaTneR6xFhvenVLiFfz5Ue125dL"

EOSLOCAL_USERB_ACCOUNT="eoslocaluserb"
EOSLOCAL_USERB_PVTKEY="5JHCQDi7jsbnQnWdyxteRjT2DdNZHePiEG1DTaPQQDDP2X6aor6"
EOSLOCAL_USERB_PUBKEY="EOS6TVQ6EmphCWavUuYiZMmDNYMRgbb96wgqWDncjrkvFPcpokgdD"

EOSLOCAL_USERC_ACCOUNT="eoslocaluserc"
EOSLOCAL_USERC_PVTKEY="5JXCt633pzYaUysn7exDHeVXwhwMjX2L231b37CdsSb7y1uvDH7"
EOSLOCAL_USERC_PUBKEY="EOS7CB47VMLWp49QhajE3uTuHuf9qoSeR6scUHMKGCD6LXYufRUDc"

EOSLOCAL_USERD_ACCOUNT="eoslocaluserd"
EOSLOCAL_USERD_PVTKEY="5JdRgeRBriBDdxb3r76sLJaQmwGgXkMU8GReTAmy8xYppMSAAoZ"
EOSLOCAL_USERD_PUBKEY="EOS6Jv4RykLZQQopCBdBHSwaGoMyFxyaxFNXimqFPdEXNWqgWbG1a"

EOSLOCAL_USERE_ACCOUNT="eoslocalusere"
EOSLOCAL_USERE_PVTKEY="5Jdwjwto9wxy5ZNPnWSn965eb8ZtSrK1uRKUxhviLpr9gK79hmM"
EOSLOCAL_USERE_PUBKEY="EOS5VdFvRRTtVQAPUJZQCYvpBekYV4nc1cFe7og9aYPTBMXZ38Koy"

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
