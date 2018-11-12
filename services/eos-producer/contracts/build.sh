#! /bin/bash

printf "\t=========== Building EOS Local Smart Contract ===========\n\n"

RED='\033[0;31m'
NC='\033[0m'

CORES=`getconf _NPROCESSORS_ONLN`
mkdir -p build
pushd build &> /dev/null
cmake ../
make -j${CORES}
popd &> /dev/null

cp build/eoslocal/eoslocal.wasm eoslocal/eoslocal.wasm
