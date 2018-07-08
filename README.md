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
This is easiest way maintain a local environment for development that is guaranteed to work out of the box across the different host operating systems: Mac OS, Windows and Linux.  

**Disclaimer: This is a Work in Progress**

## Features

- containerized EOS blockchain development environment.
- nginx reverse proxy for virtual host resolution from the host machine.
- network specific service aliases for "virtual host" resolution within the containers.
- handy scripts for interacting with the local EOS services.
- yarn as task manager

## Getting started

Basic knowledge about Docker, Docker Compose, EOS and NodeJS is required to use this environment.

**Global Dependencies**

- Docker https://docs.docker.com/install/.   
At least 7GB RAM (Docker -> Preferences -> Advanced -> Memory -> 7GB or above)
- Install node.js v8 ( carbon ) on your machine.  
We recommend using [nvm](https://github.com/creationix/nvm) and [avn](https://github.com/wbyoung/avn) to [manage multiple your version on your computer](https://gaboesquivel.com/blog/2015/automatic-node.js-version-switching/).
- Yarn https://yarnpkg.com/lang/en/docs/install/.

*Note: at the moment we are not using a docker container for running dapp due to issues related to reloading the app*

**Client Side Dependencies**

- `yarn`

**Commands**

- `yarn eos-dev` starts the eos
- `yarn eos-dev:down` starts the eos

## TODO

- instructions for contract development
- improve docker compose commands documentation
- create more handy scripts
- create a sample dapp
- add recipe for configuring clion https://www.jetbrains.com/help/clion/docker.html 
- `yarn start` starts the sample dapp
- seeding ?

## EOS Documentation & Resources

- https://developers.eos.io
- https://github.com/eoscostarica/eos-dev-learning-resources

## Contributing

Read the [contributing guidelines](CONTRIBUTING.md) for details.

## About EOS Costa Rica

EOS Blockchain is aiming to become a decentralized operating system which can support large-scale decentralized applications.

EOS Costa Rica supports the global and local open source efforts and development communities by maintaining and contribute to open source initiatives, meetups and workshops.

We challenge ourselves to provide the EOS platform with a strong geographical and political diversity by running the most robust EOS Block Producer possible from Costa Rica; We pledge to leverage our talent, experience, and sustainable internet resources to meet such an important challenge.

[eoscostarica.io](https://eoscostarica.io)
