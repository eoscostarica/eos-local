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
	<a href="https://eoscostarica.io">
		<img src="https://cdn.rawgit.com/eoscostarica/assets/574d20a6/logos/eoscolors-transparent.png" width="300">
	</a>
</p>

# EOS Dapp Development Environment

A docker compose based development environment for EOS DApp Development.   
This is easiest way maintain a local environment for development that is guaranteed to work out-of-the-box across the different host operating systems: Mac OS, Windows and Linux.  

**Disclaimer: This is a Work in Progress**

## Features

- containerized EOS blockchain development environment.
- nginx reverse proxy for virtual host resolution from the host machine.
- network specific service aliases for "virtual host" resolution within the containers.
- handy scripts for interacting with the local EOS services.
- yarn as task manager.

## Getting started

Basic knowledge about Docker, Docker Compose, EOS and NodeJS is required to use this environment.

Please look at our [Getting Started With EOS]

**Global Dependencies**

- Docker https://docs.docker.com/install/.   
At least 7GB RAM (Docker -> Preferences -> Advanced -> Memory -> 7GB or above)
- Install node.js v8 ( carbon ) on your machine.  
We recommend using [nvm](https://github.com/creationix/nvm) and [avn](https://github.com/wbyoung/avn) to [manage multiple node.js versions on your computer](https://gaboesquivel.com/blog/2015/automatic-node.js-version-switching/).
- Yarn https://yarnpkg.com/lang/en/docs/install/.

*Note: at the moment we are not using a docker container for running dapp due to issues related to reloading the app*

**Client Side Dependencies**

- `yarn`   install node packages

**Commands**

- `yarn eos-dev` starts the docker containers with nodeos and keosd processes.
- `yarn eos-dev:down` stops and removes the containers.
- `yarn eos-update` pull the latest eos-dev image from dockerhub.
- `yarn eos-flush-nodeos` remove all blockchain data.
- `yarn eos-flush-keosd` remove all wallet data.
- `yarn eos-flush-all` remove all data.

- `yarn cleos` executes cleos on the virtualized environment. 

Eg:

```shell
➜  eos-dapp-dev-env git:(master) yarn cleos get info
yarn run v1.5.1
$ ./cleos.sh get info
{
  "server_version": "ad4ba283",
  "chain_id": "cf057bbfb72640471fd910bcb67639c22df9f92470936cddc1ade0e2f2e7dc4f",
  "head_block_num": 166769,
  "last_irreversible_block_num": 166768,
  "last_irreversible_block_id": "00028b701ab37605eb05fc3735a185c8cb1087d58a53f162cbae02f25918299f",
  "head_block_id": "00028b7148565b4056e20566a9e96187c9157dc30a3b758dc6ab795b39f0656e",
  "head_block_time": "2018-08-10T13:07:48.500",
  "head_block_producer": "eosio",
  "virtual_block_cpu_limit": 200000000,
  "virtual_block_net_limit": 1048576000,
  "block_cpu_limit": 199900,
  "block_net_limit": 1048576
}
```

**Known Issues**

- During first run, "eos-dapp-dev-env_nodeosd_1 exited with code 254" can be avoided by commenting the parameters --replay-blockchain --hard-replay-blockchain, on the nodeosd service in the docker-compose.yml file.

## TODO

- instructions for contract development
- improve docker compose commands documentation
- create a sample dapp
- add recipe for configuring clion https://www.jetbrains.com/help/clion/docker.html
- add recipe for vscode
- `yarn start` starts the sample dapp

## EOS Documentation & Resources

- https://developers.eos.io
- https://learn.eoscostarica.io

## Contributing

Read the [contributing guidelines](CONTRIBUTING.md) for details.

## About EOS Costa Rica

EOS Blockchain is aiming to become a decentralized operating system which can support large-scale decentralized applications.

EOS Costa Rica supports the EOS.io community by maintaining and contributing to open source initiatives, meetups and workshops.

We challenge ourselves to provide the EOS platform with a strong geographical and political diversity by running the most robust EOS Block Producer possible from Costa Rica; We pledge to leverage our talent, experience, and sustainable internet resources to meet such an important challenge.

[eoscostarica.io](https://eoscostarica.io)

## Contributors

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
| [<img src="https://avatars0.githubusercontent.com/u/391270?v=4" width="100px;"/><br /><sub><b>Gabo Esquivel</b></sub>](https://gaboesquivel.com)<br />[🤔](#ideas-gaboesquivel "Ideas, Planning, & Feedback") [📖](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=gaboesquivel "Documentation") [💻](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=gaboesquivel "Code") [👀](#review-gaboesquivel "Reviewed Pull Requests") | [<img src="https://avatars2.githubusercontent.com/u/349542?v=4" width="100px;"/><br /><sub><b>Daniel Prado</b></sub>](https://github.com/danazkari)<br />[💻](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=danazkari "Code") [📖](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=danazkari "Documentation") [🤔](#ideas-danazkari "Ideas, Planning, & Feedback") [👀](#review-danazkari "Reviewed Pull Requests") | [<img src="https://avatars0.githubusercontent.com/u/5632966?v=4" width="100px;"/><br /><sub><b>Xavier Fernandez</b></sub>](https://github.com/xavier506)<br />[🤔](#ideas-xavier506 "Ideas, Planning, & Feedback") [📝](#blog-xavier506 "Blogposts") [📢](#talk-xavier506 "Talks") [🚇](#infra-xavier506 "Infrastructure (Hosting, Build-Tools, etc)") |
| :---: | :---: | :---: |
<!-- ALL-CONTRIBUTORS-LIST:END -->
Thanks goes to these wonderful people ([emoji key](https://github.com/kentcdodds/all-contributors#emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/kentcdodds/all-contributors) specification. Contributions of any kind welcome!
