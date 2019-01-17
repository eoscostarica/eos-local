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
	<img src="docs/eoslocal.png" width="600">
</p>

# EOS Local Network

EOS Local provides a really quick way to setup an EOS local network with history api.

The primary benefits of containers are efficiency, agility and consistency accross different environments.

It has a companion project that serves as a starter boilerplate your dApp.
https://github.com/eoscostarica/eos-dapp-boilerplate 

*This is a work in progress...*

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Services](#services)
  - [eosio](#eosio)
  - [mongo](#mongo)
  - [graphql](#graphql)
  - [history api](#history-api)
  - [ngnix](#ngnix)
- [Getting started](#getting-started)
- [Aliases](#aliases)
- [Chain Initialization](#chain-initialization)
- [Commands](#commands)
- [Cleos through docker exec](#cleos-through-docker-exec)
- [Accesing the container](#accesing-the-container)
- [Directory Structure](#directory-structure)
- [Compiling and deploying contracts](#compiling-and-deploying-contracts)
- [Contributing](#contributing)
- [About EOS Costa Rica](#about-eos-costa-rica)
- [License](#license)
- [Contributors](#contributors)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Services

<p align="center">
   Every service/process runs on a separate container.
</p>

<p align="center">
	<img src="docs/eos_local_containers.png" width="600">
</p>

### eosio

The eosio node acts as producer and history api node, this configuration is just for development. 

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

## Getting started

Basic knowledge about Docker, Docker Compose, EOS and NodeJS is required.

-  Video tutorial [Docker Containers | Learn Docker Basics in 30 Mins](https://www.youtube.com/watch?v=0kwXLcwUw0Q)

**Global Dependencies**

- Docker https://docs.docker.com/install/.   
At least 10GB RAM (Docker -> Preferences -> Advanced -> Memory -> 10GB or above)

## Aliases

It is useful to have aliases for the `docker`, `docker-compose` and `cleos`.

```
alias cleos_local='docker exec -i eoslocal_eosio cleos -u http://eosio:8888 --wallet-url http://wallet:8901'
alias eosio_local='docker exec -it eoslocal_eosio bash'
alias unlock_eoslocal='docker exec -i eoslocal_eosio ./scripts/unlock.sh'
alias dk='docker'
alias dc='docker-compose'
```

## Chain Initialization

Make sure the following ports are available on your host machine.

`8888, 9830, 8901, 27017, 4001, 5001, 8081, 80`

See `docker-compose.yml` port mapping for details.

Execute `make setup` for:

- Docker volumes creation and containers startup.
- EOSIO local chain initialization.
- Testing accounts creation.

**Verify Setup**

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

➜  cleos_local wallet keys
[
  "EOS6kYgMTCh1iqpq9XGNQbEi8Q6k5GujefN9DSs55dcjVyFAq7B6b",
  "EOS78RuuHNgtmDv9jwAzhxZ9LmC6F295snyQ9eUDQ5YtVHJ1udE6p",
  "EOS5yd9aufDv7MqMquGcQdD6Bfmv6umqSuh9ru3kheDBqbi6vtJ58",
  "EOS7XPiPuL3jbgpfS3FFmjtXK62Th9n2WZdvJb6XLygAghfx1W7Nb",
  "EOS6TVQ6EmphCWavUuYiZMmDNYMRgbb96wgqWDncjrkvFPcpokgdD",
  "EOS5btzHW33f9zbhkwjJTYsoyRzXUNstx1Da9X2nTzk8BQztxoP3H",
  "EOS8Du668rSVDE3KkmhwKkmAyxdBd73B51FKE7SjkKe5YERBULMrw"
]

➜  cleos_local get info
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

➜  curl http://eosio.eoslocal.io/v1/chain/get_info | jq
or 
➜  curl http://localhost:8888/v1/chain/get_info | jq
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
```

## Commands

- `make setup` run chain initialization.
- `make start` starts all services.
- `make stop` stops all services.
- `make flush` stops all services and removes all data.
- `make fresh` stops all services and removes all data and run chain initialization again.
- `docker-compose exec [service_name] [bash | sh]` open bash or sh in a container.
- `docker-compose down` stops and removes all containers.
- `docker-compose restart` restarts all services.

## Cleos through docker exec

You can execute commands on any container from you host machine using the `docker exec` command.
Eg:

`docker exec -i eoslocal_eosio cleos --url http://localhost:8888/ get info`

Notice it uses docker directly through the `container_name` insted of docker compose, this allows you to invoke it from any path in your computer, you don't have to be a the root dir of eoslocal.

## Accesing the container

You can also login into the containers using the following docker-compose command 

`docker exec -it eoslocal_eosio bash`

That will log you in and you will be able to execute cleos directly within the ubuntu server.


**Testing Accounts**

```
-
  name: eostestusera
  privateKey: 5K7mtrinTFrVTduSxizUc5hjXJEtTjVTsqSHeBHes1Viep86FP5
  publicKey: EOS6kYgMTCh1iqpq9XGNQbEi8Q6k5GujefN9DSs55dcjVyFAq7B6b
-
  name: eostestuserb
  privateKey: 5KLqT1UFxVnKRWkjvhFur4sECrPhciuUqsYRihc1p9rxhXQMZBg
  publicKey: EOS78RuuHNgtmDv9jwAzhxZ9LmC6F295snyQ9eUDQ5YtVHJ1udE6p
-
  name: eostestuserc
  privateKey: 5K2jun7wohStgiCDSDYjk3eteRH1KaxUQsZTEmTGPH4GS9vVFb7
  publicKey: EOS5yd9aufDv7MqMquGcQdD6Bfmv6umqSuh9ru3kheDBqbi6vtJ58
-
  name: eostestuserd
  privateKey: 5KNm1BgaopP9n5NqJDo9rbr49zJFWJTMJheLoLM5b7gjdhqAwCx
  publicKey: EOS8LoJJUU3dhiFyJ5HmsMiAuNLGc6HMkxF4Etx6pxLRG7FU89x6X
-
  name: eostestusere
  privateKey: 5KE2UNPCZX5QepKcLpLXVCLdAw7dBfJFJnuCHhXUf61hPRMtUZg
  publicKey: EOS7XPiPuL3jbgpfS3FFmjtXK62Th9n2WZdvJb6XLygAghfx1W7Nb
-
  name: eostestuserf
  privateKey: 5KaqYiQzKsXXXxVvrG8Q3ECZdQAj2hNcvCgGEubRvvq7CU3LySK
  publicKey: EOS5btzHW33f9zbhkwjJTYsoyRzXUNstx1Da9X2nTzk8BQztxoP3H
-
  name: eostestuserg
  privateKey: 5KFyaxQW8L6uXFB6wSgC44EsAbzC7ideyhhQ68tiYfdKQp69xKo
  publicKey: EOS8Du668rSVDE3KkmhwKkmAyxdBd73B51FKE7SjkKe5YERBULMrw

```

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

## Contributing

We use a Kanban-style board. That's were we prioritize the work. [Go to Project Board](https://github.com/eoscostarica/eos-local/projects/3).

Contributing Guidelines https://developers.eoscostarica.io/docs/open-source-guidelines.

Please report bugs big and small by [opening an issue](https://github.com/eoscostarica/eos-local/issues)

## About EOS Costa Rica
<p align="center">
	<a href="https://eoscostarica.io">
		<img src="https://cdn.rawgit.com/eoscostarica/assets/574d20a6/logos/eoscolors-transparent.png" width="300">
	</a>
</p>

EOS Costa Rica is an independently-owned, self-funded, bare-metal genesis block producer that provides stable and secure infrastructure for EOSIO blockchains.  We support open source software for our community while offering enterprise solutions and custom smart contract development for our clients.

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
