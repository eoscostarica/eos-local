<p align="center">
	</a>
	<a href="https://git.io/col">
		<img src="https://img.shields.io/badge/%E2%9C%93-collaborative_etiquette-brightgreen.svg" alt="Collaborative Etiquette">
	</a>
	<a href="https://discord.gg/bBpQHym">
		<img src="https://img.shields.io/discord/447118387118735380.svg?logo=discord" alt="chat on Discord">
	</a>
	<a href="https://twitter.com/intent/follow?screen_name=eoscostarica">
		<img src="https://img.shields.io/twitter/follow/eoscostarica.svg?style=social&logo=twitter" alt="follow on Twitter">
	</a>
	<a href="#">
		<img src="https://img.shields.io/dub/l/vibe-d.svg" alt="MIT">
	</a>
</p>

<p align="center">
	<img src="docs/eoslocal-bitmapoverWhte.png" width="600">
</p>

# EOS Local Network

EOS Local provides a really quick way to setup an EOS local network. 

EOS local exposes all APIs provided by EOS Costa Rica and other BPs on the TestNet and MainNet.

It allows you to develop your application running the same APIs services you will use in production in your computer.

It has a companion project that serves as a starter boilerplate your dApp.
https://github.com/eoscostarica/eos-dapp-boilerplate 


EOS Local is a community-driven project led by EOS Costa Rica. We welcome contributions of all sorts. There are many ways to help, from reporting issues, proposing features, improving documentation, contributing code, design/ux proposals, etc.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Architecture](#architecture)
- [Technical Specs](#technical-specs)
- [Getting started](#getting-started)
- [Aliases](#aliases)
- [Chain Initialization](#chain-initialization)
- [Commands](#commands)
- [Directory Structure](#directory-structure)
- [Services](#services)
  - [eosio](#eosio)
  - [rpc api](#rpc-api)
  - [mongo](#mongo)
  - [graphql](#graphql)
  - [history api](#history-api)
  - [ngnix](#ngnix)
- [Using Cleos on EOS Local](#using-cleos-on-eos-local)
  - [Invoking cleos through docker exec](#invoking-cleos-through-docker-exec)
  - [Open a shell window on the containers and use cleos directly](#open-a-shell-window-on-the-containers-and-use-cleos-directly)
- [Testing accounts](#testing-accounts)
- [Contract Development](#contract-development)
  - [Compiling and deploying contracts](#compiling-and-deploying-contracts)
      - [from host machine](#from-host-machine)
      - [from within the eosio container](#from-within-the-eosio-container)
- [Frequently Asked Questions](#frequently-asked-questions)
  - [Why Containers ?](#why-containers-)
- [Contributing](#contributing)
- [About EOS Costa Rica](#about-eos-costa-rica)
- [License](#license)
- [Contributors](#contributors)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Architecture

<p align="center">
   Every service/process runs on a separate container.
</p>

<p align="center">
	<img src="docs/EOS-Local-Architecture-2.0.png" width="600">
</p>


<p align="center">
   You can develop multiple dApps using the same EOS Local Network, sharing testing users and machine resources.
</p>

<p align="center">
	<img src="docs/EOS-Local-2.0.png" width="600">
</p>


## Technical Specs

- Virtualized local network with docker.
- Microservices architecture.
- Out-of-box services: 
  - EOSIO Nodeos deamon.
  - HTTP RPC API with history db.
  - Keosd wallet service.
  - GraphQL API for complex data queries.
  - Ngnix proxy.
- Services accessible through virtual host names both from host machine and within the docker network.
- Handy scripts for interacting with the local EOS services.

**Important Disclaimer: This is a Work in Progress** 

## Getting started

Basic knowledge about Docker, Docker Compose, EOS and NodeJS is required.

-  Video tutorial [Docker Containers | Learn Docker Basics in 30 Mins](https://www.youtube.com/watch?v=0kwXLcwUw0Q)

**Global Dependencies**

- Docker https://docs.docker.com/install/.   
At least 10GB RAM (Docker -> Preferences -> Advanced -> Memory -> 10GB or above)

## Aliases

It is useful to have aliases for the `docker`, `docker-compose` and `cleos` commands since they are used.

```
alias cleos='docker exec -i eoslocal_eosio cleos -u http://eosio:8888 --wallet-url http://wallet:8901'
alias eosio='docker exec -i eoslocal_eosio bash'
alias unlock_eoslocal='docker exec -i eoslocal_eosio ./scripts/unlock.sh'
alias dk='docker'
alias dc='docker-compose'
```

## Chain Initialization

Execute `make setup` for:

- Docker volumes creation.
- Chain initialization.
- Testing accounts creation.

Run the following command to verify afterwards

```terminal
➜  docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
f72523603a2d        bridge              bridge              local
113510307ce3        eoslocal            bridge              local
886afbf5db1a        host                host                local
53d0d3f8d910        none                null                local

➜  docker-compose ps
     Name                    Command               State                                        Ports
--------------------------------------------------------------------------------------------------------------
eoslocal_eosio    /bin/sh -c /wait && /opt/a ...   Up      0.0.0.0:8888->8888/tcp, 0.0.0.0:9830->9876/tcp
eoslocal_ipfs     /sbin/tini -- /usr/local/b ...   Up      0.0.0.0:4001->4001/tcp, 0.0.0.0:5001->5001/tcp,     0.0.0.0:8081->8080/tcp, 8081/tcp
eoslocal_mongo    docker-entrypoint.sh mongod      Up      0.0.0.0:27017->27017/tcp
eoslocal_nginx    /app/docker-entrypoint.sh  ...   Up      0.0.0.0:80->80/tcp
eoslocal_wallet   /opt/eosio/bin/keosd --wal ...   Up      0.0.0.0:8901->8901/tcp


➜  cleos wallet keys
[
  "EOS5VdFvRRTtVQAPUJZQCYvpBekYV4nc1cFe7og9aYPTBMXZ38Koy",
  "EOS5k6Jht1epqZ2mnRLFVDXDTosaTneR6xFhvenVLiFfz5Ue125dL",
  "EOS6Jv4RykLZQQopCBdBHSwaGoMyFxyaxFNXimqFPdEXNWqgWbG1a",
  "EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV",
  "EOS6TVQ6EmphCWavUuYiZMmDNYMRgbb96wgqWDncjrkvFPcpokgdD",
  "EOS7CB47VMLWp49QhajE3uTuHuf9qoSeR6scUHMKGCD6LXYufRUDc",
  "EOS84BLRbGbFahNJEpnnJHYCoW9QPbQEk2iHsHGGS6qcVUq9HhutG"
]

➜  cleos get info
{
  "server_version": "59626f1e",
  "chain_id": "cf057bbfb72640471fd910bcb67639c22df9f92470936cddc1ade0e2f2e7dc4f",
  "head_block_num": 675,
  "last_irreversible_block_num": 674,
  "last_irreversible_block_id": "000002a2a6228780c7facc225ff53609ed072d57e7b6abb9a0ba92ab63b5d160",
  "head_block_id": "000002a3b39afb5f16ac7a59f747e21ef6bcc060a856237016af48ad677c7f52",
  "head_block_time": "2018-12-07T18:03:08.500",
  "head_block_producer": "eosio",
  "virtual_block_cpu_limit": 392064,
  "virtual_block_net_limit": 2057598,
  "block_cpu_limit": 199900,
  "block_net_limit": 1048576,
  "server_version_string": "v1.4.4"
}

➜   curl http://eosio.eoslocal.io/v1/chain/get_info | jq
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   566  100   566    0     0  72554      0 --:--:-- --:--:-- --:--:-- 80857
{
  "server_version": "59626f1e",
  "chain_id": "cf057bbfb72640471fd910bcb67639c22df9f92470936cddc1ade0e2f2e7dc4f",
  "head_block_num": 970,
  "last_irreversible_block_num": 969,
  "last_irreversible_block_id": "000003c9846265cddc9133024d9bd2adb1531378da8172318fe2a142b843c02a",
  "head_block_id": "000003ca6e3448f540c36f70a176f5cc4769514f8018b07fbbf32b27f532fb6b",
  "head_block_time": "2018-12-07T18:05:36.000",
  "head_block_producer": "eosio",
  "virtual_block_cpu_limit": 526492,
  "virtual_block_net_limit": 2763849,
  "block_cpu_limit": 199900,
  "block_net_limit": 1048576,
  "server_version_string": "v1.4.4"
}

➜  curl http://localhost:8888/v1/chain/get_info | jq
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   568  100   568    0     0  78172      0 --:--:-- --:--:-- --:--:-- 81142
{
  "server_version": "59626f1e",
  "chain_id": "cf057bbfb72640471fd910bcb67639c22df9f92470936cddc1ade0e2f2e7dc4f",
  "head_block_num": 1167,
  "last_irreversible_block_num": 1166,
  "last_irreversible_block_id": "0000048e64aedcb65234739ac489fe81f7b7d68e5c7ccb4c28bd8083b0e33213",
  "head_block_id": "0000048ff0dcc3c4e65ec0de14f9d4ae9c8823bddad2bb19f73b0245514b138c",
  "head_block_time": "2018-12-07T18:07:14.500",
  "head_block_producer": "eosio",
  "virtual_block_cpu_limit": 641088,
  "virtual_block_net_limit": 3365893,
  "block_cpu_limit": 199900,
  "block_net_limit": 1048576,
  "server_version_string": "v1.4.4"
}
```


## Commands

- `make setup` run chain initialization.
- `make flush` stops all services and removes all data.
- `make fresh` stops all services and removes all data and run chain initialization again.
- `docker-compose start` starts all containers.
- `docker-compose exec [service_name] [bash | sh]` open bash or sh in a container.
- `docker-compose stop` stops all containers.
- `docker-compose down` stops and removes all containers.
- `docker-compose restart` restarts all services.

## Directory Structure

```
.
├── docs/ .............................................. documentation files and media
├── services/ .......................................... microservices
|   ├── graphql/ ....................................... graphql service
|   |
|   ├── history-api/ ................................... express/swagger history api
|   |
|   ├── ngnix/ ......................................... nginx service for routing
|   |
|   ├── mongo/ ......................................... mongodb data
|   |
|   └── eosio/ ......................................... nodeos service
|       ├── utils/ ..................................... service utilities
|       ├── config/ .................................... eosio node configuration
|       ├── scripts/ ................................... eosio scripts
|       ├── contracts/ ................................. smart contracts 
|       └── Dockerfile ................................. service image specification 
|    
├── docker-compose.yaml ................................ docker compose for local dev
├── contributing.md .................................... contributing guidelines
├── license ............................................ project license
├── makefile ........................................... make tasks manifest
├── readme.md .......................................... project documentation
└── .editorconfig ...................................... common text editor configs
```

## Services

### eosio

The eosio node acts as block producer and history api node, this configuration is just for development. It's not recommended to for production. In production it's recommended to devide nodes responsibilities, you may want to configure a dedicate api node that stores you contracts data only or use one of the network block producers node as a service. 

The docker image source code can be found at https://github.com/EOSIO/eos/blob/master/Docker/Dockerfile.

Learn more at https://developers.eos.io/eosio-nodeos/docs/

### rpc api

https://developers.eos.io/eosio-nodeos/reference

The eos rpc api is accesible through http://localhost:8888

### mongo

MongoDB instance for to story hisotry. 
The eosio::mongo_db_plugin provides archiving of blockchain data into a MongoDB. 

https://developers.eos.io/eosio-nodeos/docs/mongo_db_plugin

### graphql 

https://github.com/EOS-BP-Developers/eosio-graphql

### history api 

https://github.com/CryptoLions/EOS-mongo-history-API


### ngnix

Nginx reverse proxy that allows accesing the services directly on the host machine the wildcard `*.esolocal.io` that points to `127.0.0.1`, therefore as long as you can hit the dns server it will redirect all requests to your machine and nginx-proxy does the internal docker network routing to the right service. 

Run `ping {whatever}.eoslocal.io` to verify.

Optionally you can avoid the round trip and work offline maintaining virtual hosts by manually adding your dns to your `hosts` file. https://en.wikipedia.org/wiki/Hosts_(file)

See the `docker-compose.yml` for available virtual hosts for easier access without port shenanigans.

## Using Cleos on EOS Local

Cleos is a command line tool that interfaces with the API exposed by nodeos. In order to use cleos you will need to have the endpoint (IP address and port number) to a nodeos instance and also configure nodeos to load the 'eosio::chain_api_plugin'. `cleos` contains documentation for all of its commands. 

More at https://developers.eos.io/eosio-nodeos/docs/cleos-overview 

EOS Local comes with 2 EOS nodes running in separate docker containers, you can interact with these nodes using `cleos` in several ways:

### Invoking cleos through docker exec

You can execute commands on any container from you host machine using the `docker exec` command.
Eg:

`docker exec -i eoslocal_eosio cleos --url http://localhost:8888/ get info`

We recomend using declaring alias on your shell configuration  Eg (.bashrc or .zshrc) 

```
alias cleos='docker exec -i eoslocal_eosio cleos -u http://eosio:8888 --wallet-url http://wallet:8901'
```

Notice it uses docker directly thru the `container_name` insted of docker compose, this allows you to invoke it from any path in your computer, you don't have to be a the root dir of eoslocal.

After you have added those lines to your config you can open a new terminal window and run `cleos --help` to test.

### Open a shell window on the containers and use cleos directly

You can also login into the containers using the following docker-compose command 

`docker exec -it eoslocal_eosio bash`

That will log you in and you will be able to execute cleos directly within the ubuntu server.
Eg.

```
➜  docker exec -it eoslocal_eosio bash
root@b39ffe3c43c0:/opt/eosio/bin# cleos get info
{
  "server_version": "f9a3d023",
  "chain_id": "cf057bbfb72640471fd910bcb67639c22df9f92470936cddc1ade0e2f2e7dc4f",
  "head_block_num": 4900,
  "last_irreversible_block_num": 4899,
  "last_irreversible_block_id": "000013232f7193f86a4edc59b6aa2b2a8ccd6c2060d24eb0e5c497beb97b76e5",
  "head_block_id": "000013249772e5af12592d7d3eeb401276c09f781e3ed76faa75a49f53b481bd",
  "head_block_time": "2018-11-05T20:27:45.000",
  "head_block_producer": "eosio",
  "virtual_block_cpu_limit": 26829884,
  "virtual_block_net_limit": 140951435,
  "block_cpu_limit": 199900,
  "block_net_limit": 1048576,
  "server_version_string": "v1.4.1"
}
```

## Testing accounts

The following accounts created automatically

```
account: eoslocalusra
private key: 5K4MHQN7sPdEURaxzjCnbynUwkEKRJzs8zVUf24ofaFiZNK815J
public key: EOS5k6Jht1epqZ2mnRLFVDXDTosaTneR6xFhvenVLiFfz5Ue125dL

account: eoslocalusrb
private key: 5JHCQDi7jsbnQnWdyxteRjT2DdNZHePiEG1DTaPQQDDP2X6aor6
public key: EOS6TVQ6EmphCWavUuYiZMmDNYMRgbb96wgqWDncjrkvFPcpokgdD

account: eoslocalusrc
private key: 5JXCt633pzYaUysn7exDHeVXwhwMjX2L231b37CdsSb7y1uvDH7
public key: EOS7CB47VMLWp49QhajE3uTuHuf9qoSeR6scUHMKGCD6LXYufRUDc

account: eoslocalusrd
private key: 5JdRgeRBriBDdxb3r76sLJaQmwGgXkMU8GReTAmy8xYppMSAAoZ
USER_D_PUBKEY="EOS6Jv4RykLZQQopCBdBHSwaGoMyFxyaxFNXimqFPdEXNWqgWbG1a

account: eoslocalusre
private key: 5Jdwjwto9wxy5ZNPnWSn965eb8ZtSrK1uRKUxhviLpr9gK79hmM
public key: EOS5VdFvRRTtVQAPUJZQCYvpBekYV4nc1cFe7og9aYPTBMXZ38Koy
```

All system accounts use the following keys

```
accounts: eosio.bpay, eosio.msig, eosio.names, eosio.ram, eosio.ramfee,
          eosio.saving, eosio.stake, eosio.token, eosio.vpay
private key: 5KAVVPzPZnbAx8dHz6UWVPFDVFtU1P5ncUzwHGQFuTxnEbdHJL4
public key: OS84BLRbGbFahNJEpnnJHYCoW9QPbQEk2iHsHGGS6qcVUq9HhutG
```

## Contract Development

The default folder for smart contracts is the `services/eosio/contract` folder.
This folder is mounted to the ubuntu / eosio 1.4 container which also has the eosio.cdt for contract compilation on it. This means you can either compile from host machine or the within the container using `eosio-cpp` command.

If you are starting off with eos contracts development make sure you read the official documentation at https://developers.eos.io.  You can follow all instructions using EOS Local as alternative to the development environment proposed there.

This projects aims to be easily replicated across different operating systems with all the advantanges of containerized software and good practices for version control, so this is good fit for teams.

There other options:

- Installing eosio directly on your machine or a virtual machine https://developers.eos.io/eosio-home/docs/introduction.
- Using the simple boilerplate provide by Block One https://github.com/EOSIO/eosio-project-boilerplate-simple.

### Compiling and deploying contracts

There 2 ways you can do this.

We'll use the hello world contract as example 
https://developers.eos.io/eosio-home/docs/your-first-contract

##### from host machine

Make sure you install https://github.com/EOSIO/eosio.cdt.

```
➜  eosio-cpp --version
eosio-cpp version 1.4.1

➜  cd services/eosio/contracts/hello

➜  eosio-cpp -o hello.wasm hello.cpp --abigen
Warning, empty ricardian clause file
Warning, empty ricardian clause file
Warning, action <hi> does not have a ricardian contract
➜  docker exec -i eoslocal_eosio ./scripts/unlock.sh
+ cleos='cleos -u http://eosio:8888 --wallet-url http://wallet:8901'
+ unlock_wallet
+ echo 'unlocking default wallet...'
unlocking default wallet...
++ cat /opt/application/config/keys/eoslocal_wallet_password.txt
+ cleos -u http://eosio:8888 --wallet-url http://wallet:8901 wallet unlock --name eoslocal --password PW5JWU79n8sXuNSrd92mNG7TR69K7q1Ax3a37x1FfFSAQE9MgXosh
Unlocked: eoslocal
+ sleep .5

➜  cleos wallet keys
[
  "EOS5VdFvRRTtVQAPUJZQCYvpBekYV4nc1cFe7og9aYPTBMXZ38Koy",
  "EOS5k6Jht1epqZ2mnRLFVDXDTosaTneR6xFhvenVLiFfz5Ue125dL",
  "EOS6Jv4RykLZQQopCBdBHSwaGoMyFxyaxFNXimqFPdEXNWqgWbG1a",
  "EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV",
  "EOS6TVQ6EmphCWavUuYiZMmDNYMRgbb96wgqWDncjrkvFPcpokgdD",
  "EOS7CB47VMLWp49QhajE3uTuHuf9qoSeR6scUHMKGCD6LXYufRUDc",
  "EOS84BLRbGbFahNJEpnnJHYCoW9QPbQEk2iHsHGGS6qcVUq9HhutG"
]

➜  cleos create account eosio hello EOS5VdFvRRTtVQAPUJZQCYvpBekYV4nc1cFe7og9aYPTBMXZ38Koy -p eosio@active
executed transaction: 1b9a9b7d323542d4151ab9c8b6242c85272bc7ce7144772bb65b8633f7349389  200 bytes  517 us
warning: transaction executed locally, but may not be confirmed by the network yet         ]
#         eosio <= eosio::newaccount            {"creator":"eosio","name":"hello","owner":{"threshold":1,"keys":[{"key":"EOS5VdFvRRTtVQAPUJZQCYvpBek...

➜ cleos set contract hello contracts/hello -p hello@active
Reading WASM from contracts/hello/hello.wasm...
Publishing contract...
executed transaction: 0af66be6acf1a40d5925ac95ac6673e87cde20b7d9dc07b355900d9a9f77ce11  1432 bytes  1133 us
warning: transaction executed locally, but may not be confirmed by the network yet         ]
#         eosio <= eosio::setcode               {"account":"hello","vmtype":0,"vmversion":0,"code":"0061736d0100000001390b60027f7e006000017f60027f7f...
#         eosio <= eosio::setabi                {"account":"hello","abi":"0e656f73696f3a3a6162692f312e31000102686900010475736572046e616d650100000000...

➜ cleos push action hello hi '["eoslocalusra"]' -p eoslocalusra@active
executed transaction: a4c094be2ee7d614c3932dfd626e43c18eb0be5c8a70512bfbc9658e9ebbd030  104 bytes  3072 us
#         hello <= hello::hi                    {"user":"eoslocalusra"}
>> Hello, eoslocalusra
warning: transaction executed locally, but may not be confirmed by the network yet         ]
```

**Important note:** notice the contract folder path is actually the within the container, we're just invoking the command from the host machine `contracts/hello` is relative to the container working directory which is `/opt/application`.  so the absolute path in the container would also work `/opt/applicationcontracts/hello`.

##### from within the eosio container

```
# first get into the container, eosio is an alias of docker exec -i eoslocal_eosio bash
➜  eosio
root@cb008277a194:/opt/application#

# make sure the eoslocal wallet is unlocked
root@cb008277a194:/opt/application# ./scripts/unlock.sh
+ cleos='cleos -u http://eosio:8888 --wallet-url http://wallet:8901'
+ unlock_wallet
+ echo 'unlocking default wallet...'
unlocking default wallet...
++ cat /opt/application/config/keys/eoslocal_wallet_password.txt
+ cleos -u http://eosio:8888 --wallet-url http://wallet:8901 wallet unlock --name eoslocal --password PW5KjU3AFWFip8TqiJQHS3LnNupLnCCCDSi2ZHfaY3JHTVn7p3cah
Error 3120007: Already unlocked
Error Details:
Wallet is already unlocked: eoslocal
+ sleep .5

# get the keys listed and copy one of the those for the contract account
root@cb008277a194:/opt/application# ./scripts/cleos.sh  wallet keys
[
  "EOS5VdFvRRTtVQAPUJZQCYvpBekYV4nc1cFe7og9aYPTBMXZ38Koy",
  "EOS5k6Jht1epqZ2mnRLFVDXDTosaTneR6xFhvenVLiFfz5Ue125dL",
  "EOS6Jv4RykLZQQopCBdBHSwaGoMyFxyaxFNXimqFPdEXNWqgWbG1a",
  "EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV",
  "EOS6TVQ6EmphCWavUuYiZMmDNYMRgbb96wgqWDncjrkvFPcpokgdD",
  "EOS7CB47VMLWp49QhajE3uTuHuf9qoSeR6scUHMKGCD6LXYufRUDc",
  "EOS84BLRbGbFahNJEpnnJHYCoW9QPbQEk2iHsHGGS6qcVUq9HhutG"
]

# create the account for the contract
root@cb008277a194:/opt/application# ./scripts/cleos.sh create account eosio hello EOS5VdFvRRTtVQAPUJZQCYvpBekYV4nc1cFe7og9aYPTBMXZ38Koy -p eosio@active
executed transaction: 17fec7f4557ab2bf9d1625dfe226de24c12cbb82c64e100fca6f7d5d11a32b1c  200 bytes  305 us
#         eosio <= eosio::newaccount            {"creator":"eosio","name":"hello","owner":{"threshold":1,"keys":[{"key":"EOS5VdFvRRTtVQAPUJZQCYvpBek...
warning: transaction executed locally, but may not be confirmed by the network yet         ]

# deploy the contract
root@cb008277a194:/opt/application# ./scripts/cleos.sh set contract hello contracts/hello -p hello@active
Reading WASM from contracts/hello/hello.wasm...
Publishing contract...
executed transaction: 937f6fd6a4cfc8bc264ede7e43eb1a1ced9ffd20cd59c7c33adde665578c4de1  1432 bytes  495 us
#         eosio <= eosio::setcode               {"account":"hello","vmtype":0,"vmversion":0,"code":"0061736d0100000001390b60027f7e006000017f60027f7f...
#         eosio <= eosio::setabi                {"account":"hello","abi":"0e656f73696f3a3a6162692f312e31000102686900010475736572046e616d650100000000...
warning: transaction executed locally, but may not be confirmed by the network yet         ]

# test the action
root@cb008277a194:/opt/application# ./scripts/cleos.sh push action hello hi '["eoslocalusra"]' -p eoslocalusra@active
executed transaction: a4c094be2ee7d614c3932dfd626e43c18eb0be5c8a70512bfbc9658e9ebbd030  104 bytes  3072 us
#         hello <= hello::hi                    {"user":"eoslocalusra"}
>> Hello, eoslocalusra
warning: transaction executed locally, but may not be confirmed by the network yet         ]
```


## Frequently Asked Questions

### Why Containers ?

The primary benefits of containers are efficiency and agility. Containers are orders of magnitude faster to provision, and much lighter-weight to build and define versus methods like omnibus software builds and full Virtual Machine images. Containers in a single OS are also more efficient at resource utilization than running a Hypervisor and guest OSs.

Efficiency and agility are good for everyone, but they become game-changers at scale. 

It also gives the ability to run distint versions of the different services like EOSIO on your laptop without conflicts.

Containers offer a logical packaging mechanism in which applications can be abstracted from the environment in which they actually run. This decoupling allows container-based applications to be deployed easily and consistently, regardless of whether the target environment is a private data center, the public cloud, or even a developer’s personal laptop. Containerization provides a clean separation of concerns, as developers focus on their application logic and dependencies, while IT operations teams can focus on deployment and management without bothering with application details such as specific software versions and configurations specific to the app.

For those coming from virtualized environments, containers are often compared with virtual machines (VMs). You might already be familiar with VMs: a guest operating system such as Linux or Windows runs on top of a host operating system with virtualized access to the underlying hardware. Like virtual machines, containers allow you to package your application together with libraries and other dependencies, providing isolated environments for running your software services. As you’ll see below however, the similarities end here as containers offer a far more lightweight unit for developers and IT Ops teams to work with, carrying a myriad of benefits.

<p align="center">
		<img src="docs/containers.png" width="600">
</p>

Learn more at https://cloud.google.com/containers/

## Contributing

We use a Kanban-style board. That's were we prioritize the work. [Go to Project Board](https://github.com/eoscostarica/eos-local/projects/3).


The main communication channels are [github issues](https://github.com/eoscostarica/eos-local/issues) and [EOS Costa Rica's Discord server](https://eoscostarica.io/discord). Feel to join and ask as many questions you may have.

Our weekly sync call is every Monday 1:00 AM UTC. [meet.eoscostarica.io](https:/meet.eoscostarica.io).

Contributing Guidelines https://developers.eoscostarica.io/docs/open-source-guidelines.

Please report bugs big and small by [opening an issue](https://github.com/eoscostarica/eos-local/issues)

## About EOS Costa Rica
<p align="center">
	<a href="https://eoscostarica.io">
		<img src="https://cdn.rawgit.com/eoscostarica/assets/574d20a6/logos/eoscolors-transparent.png" width="300">
	</a>
</p>

We challenge ourselves to provide the EOS platform with a strong geographical and political diversity by running the most robust EOS Block Producer possible from Costa Rica; We pledge to leverage our talent, experience, and sustainable internet resources to meet such an important challenge.

EOS Costa Rica supports the EOS.io community by maintaining and contributing to open source initiatives, meetups and workshops.

[eoscostarica.io](https://eoscostarica.io)

## License

MIT © [EOS Costa Rica](https://eoscostarica.io)  

## Contributors

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
| [<img src="https://avatars0.githubusercontent.com/u/391270?v=4" width="100px;"/><br /><sub><b>Gabo Esquivel</b></sub>](https://gaboesquivel.com)<br />[🤔](#ideas-gaboesquivel "Ideas, Planning, & Feedback") [📖](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=gaboesquivel "Documentation") [💻](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=gaboesquivel "Code") [👀](#review-gaboesquivel "Reviewed Pull Requests") | [<img src="https://avatars2.githubusercontent.com/u/349542?v=4" width="100px;"/><br /><sub><b>Daniel Prado</b></sub>](https://github.com/danazkari)<br />[💻](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=danazkari "Code") [📖](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=danazkari "Documentation") [🤔](#ideas-danazkari "Ideas, Planning, & Feedback") [👀](#review-danazkari "Reviewed Pull Requests") | [<img src="https://avatars1.githubusercontent.com/u/1179619?v=4" width="100px;"/><br /><sub><b>Jorge Murillo</b></sub>](https://github.com/murillojorge)<br />[🤔](#ideas-murillojorge "Ideas, Planning, & Feedback") [📖](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=murillojorge "Documentation") [🎨](#design-murillojorge "Design") [💻](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=murillojorge "Code") [👀](#review-murillojorge "Reviewed Pull Requests") | [<img src="https://avatars0.githubusercontent.com/u/5632966?v=4" width="100px;"/><br /><sub><b>Xavier Fernandez</b></sub>](https://github.com/xavier506)<br />[🤔](#ideas-xavier506 "Ideas, Planning, & Feedback") [📝](#blog-xavier506 "Blogposts") [📢](#talk-xavier506 "Talks") [🚇](#infra-xavier506 "Infrastructure (Hosting, Build-Tools, etc)") | [<img src="https://avatars2.githubusercontent.com/u/13205620?v=4" width="100px;"/><br /><sub><b>Rubén Abarca Navarro</b></sub>](https://github.com/rubenabix)<br />[🤔](#ideas-rubenabix "Ideas, Planning, & Feedback") [👀](#review-rubenabix "Reviewed Pull Requests") [💻](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=rubenabix "Code") | [<img src="https://avatars2.githubusercontent.com/u/15035769?v=4" width="100px;"/><br /><sub><b>jsegura17</b></sub>](https://github.com/jsegura17)<br />[💻](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=jsegura17 "Code") [👀](#review-jsegura17 "Reviewed Pull Requests") [🤔](#ideas-jsegura17 "Ideas, Planning, & Feedback") | [<img src="https://avatars1.githubusercontent.com/u/6147142?v=4" width="100px;"/><br /><sub><b>Leo Ribeiro</b></sub>](http://leordev.github.io)<br />[🤔](#ideas-leordev "Ideas, Planning, & Feedback") [👀](#review-leordev "Reviewed Pull Requests") |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| [<img src="https://avatars2.githubusercontent.com/u/16544451?v=4" width="100px;"/><br /><sub><b>Mariano Alvarez</b></sub>](https://github.com/mahcr)<br />[🤔](#ideas-mahcr "Ideas, Planning, & Feedback") [👀](#review-mahcr "Reviewed Pull Requests") | [<img src="https://avatars1.githubusercontent.com/u/1082127?v=4" width="100px;"/><br /><sub><b>Julien Lucca</b></sub>](http://lucca65.github.io)<br />[💻](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=lucca65 "Code") [👀](#review-lucca65 "Reviewed Pull Requests") [🤔](#ideas-lucca65 "Ideas, Planning, & Feedback") | [<img src="https://avatars2.githubusercontent.com/u/40245170?v=4" width="100px;"/><br /><sub><b>Edgar Fernandez</b></sub>](http://www.eoscostarica.io)<br />[🤔](#ideas-edgar-eoscostarica "Ideas, Planning, & Feedback") [📝](#blog-edgar-eoscostarica "Blogposts") [📢](#talk-edgar-eoscostarica "Talks") | [<img src="https://avatars3.githubusercontent.com/u/1288106?v=4" width="100px;"/><br /><sub><b>César Rodríguez</b></sub>](http://www.kesarito.com)<br />[🤔](#ideas-kesar "Ideas, Planning, & Feedback") | [<img src="https://avatars2.githubusercontent.com/u/1371207?v=4" width="100px;"/><br /><sub><b>Pacien Boisson</b></sub>](https://ngfar.io)<br />[🤔](#ideas-pakokrew "Ideas, Planning, & Feedback") | [<img src="https://avatars0.githubusercontent.com/u/17969875?v=4" width="100px;"/><br /><sub><b>Alex Gomory</b></sub>](https://github.com/GMory)<br />[💻](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=GMory "Code") [🤔](#ideas-GMory "Ideas, Planning, & Feedback") [📢](#talk-GMory "Talks") |
<!-- ALL-CONTRIBUTORS-LIST:END -->
Thanks goes to these wonderful people ([emoji key](https://github.com/kentcdodds/all-contributors#emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/kentcdodds/all-contributors) specification. Contributions of any kind welcome!
