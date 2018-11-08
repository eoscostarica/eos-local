cmake_minimum_required(VERSION 3.5)
project(eoslocal_example VERSION 1.0.0)

find_package(eosio.cdt)

### Only generate the wasm
#add_executable( eoslocal.wasm eoslocal.cpp )

### Generate the wasm and abi
add_contract( eoslocal eoslocal eoslocal.cpp )
