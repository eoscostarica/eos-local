#!/usr/bin/env bash

# Throws error when using unset variable
set -ux

# Creates an eos account with 10.0000 EOS
function create_eos_account () {
  # $cleos system newaccount eosio --transfer $1 $2 $2 --stake-net '1 EOS' --stake-cpu '1 EOS' --buy-ram '1 EOS'
  $cleos create account eosio $1 $2 $2
  $cleos push action eosio.token issue '[ "'$1'", "10.0000 EOS", "initial stake - free tokens" ]' -p eosio
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
