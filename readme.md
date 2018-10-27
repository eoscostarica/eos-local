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

# EOS Local 

A docker compose based development environment for EOS DApp Development.   

This is easiest way maintain a local environment for development that is guaranteed to work out-of-the-box across the different host operating systems: Mac OS, Windows and Linux.  

**Important Disclaimer: This is a Work in Progress** 

EOS Local is a community-driven project lead by EOS Costa Rica. We welcome contributions of all sorts. There are many ways to help, from reporting issues, proposing features, improving documentation, contributing code, design/ux proposals.

A common reusable docker based microservices architecture boilerplate and development environment that will allow to deploy EOS appliactions faster.

It's based on MonsterEOS EOSIO DreamStack architecture.

## Features

- Fully virtualized EOS blockchain development environment.
- Fnteligent automated blockchain replay. ( no more replay flag shenanigans )
- Microservices architecture with docker compose with:
  - Nginx reverse proxy for virtual host resolution from the host machine.
  - Network specific service aliases for "virtual host" resolution within the containers.
- Out-of-box services: 
  - Postgres database.
  - Mongodb database.
  - Demux service.
  - Eos-dev node for contract dev and compilation.
  - Eos fullnode with history.
  - Graphql endpoint.
  - reactjs client with:
    - Scatter integration.
    - Lynx integration.
    - Eosaccount profile page.
    - Material UI.
    - GraphQL Apollo client.
- Handy scripts for interacting with the local EOS services.
- Gulp as global task manager.
- Automated code linting and testing.
- Continuous Integration and Deployment. ( Travis and Netlify )

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

- `gulp setup` run chain initilization and database migrations.
- `gulp start` starts the docker containers with nodeos and keosd processes.
- `gulp stop` stops and removes all containers.
- `gulp restart` restarts all services.
- `gulp flush` remove all blockchain and database data.
- `gulp cleos` executes cleos on the virtualized environment against the eosiodev node. 

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

## Directory Structure

```
.
├── docs/ .............................................. documentation files and media
├── services/ .......................................... microservices
|	├── eosiodev/ ........................................ eos node for contact development
|	|	├── config/ ........................................ eos node config
|	|	├── contracts/ ..................................... smart contracts 
|	└── frontend/ ........................................ reactjs frontend
|		├── public/ ........................................ static and public files
|		├── src/ ........................................... reactjs views and components
|		├── config-overrides.js ............................ configuration overrides for `cra`
|		├── .env ........................................... environment variables
|		├── .eslintrc ...................................... code style rules
|		└── package.json ................................... dependencies manifest
├── docker-compose.yaml ................................ docker compose for local dev
├── contributing.md .................................... contributing guidelines
├── LICENSE ............................................ project license
├── README.md .......................................... project homepage
├── netlify.toml ....................................... netlify configuration file
└── .travis.yml ........................................ travis ci configuration file
```

## Services

### demux

https://eosio.github.io/demux-js/

### eosiodev

### fullnode

### postgres

### mongodb

https://developers.eos.io/eosio-nodeos/docs/local-single-node-testnet

## EOS Documentation & Resources

- https://developers.eos.io
- https://learn.eoscostarica.io
- https://github.com/slowmist/eos-smart-contract-security-best-practices
- https://nadejde.github.io/eos-token-sale

## Contributing


We use a Kanban-style board with built-in triggers to automatically move issues and pull requests across New Issues, To Do, In Progress and Done columns. That's were we prioritize the work. [Go to Project Board](https://github.com/eoscostarica/eos-local/projects/3).

The main communication channels for organizing and collaborating are [github issues](https://github.com/eoscostarica/eos-local/issues) and the [EOS Costa Rica Discord server](https://eoscostarica.io/discord). Feel to join and ask as many questions you may have.


We follow EOS Costa Rica's Open Source Contributing Guidelines. https://learn.eoscostarica.io/open-source/

Our weekly sync call is every Monday 7pm-8pm Costa Rica / Central Standard Time at [meet.eoscostarica.io](https:/meet.eoscostarica.io).

Please report bugs big and small by [opening an issue](https://github.com/eoscostarica/eos-local/issues)


## About EOS Costa Rica

EOS Blockchain is aiming to become a decentralized operating system which can support large-scale decentralized applications.

EOS Costa Rica supports the EOS.io community by maintaining and contributing to open source initiatives, meetups and workshops.

We challenge ourselves to provide the EOS platform with a strong geographical and political diversity by running the most robust EOS Block Producer possible from Costa Rica; We pledge to leverage our talent, experience, and sustainable internet resources to meet such an important challenge.

[eoscostarica.io](https://eoscostarica.io)

## License

MIT © [EOS Costa Rica](https://eoscostarica.io)  

## Contributors

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
| [<img src="https://avatars0.githubusercontent.com/u/391270?v=4" width="100px;"/><br /><sub><b>Gabo Esquivel</b></sub>](https://gaboesquivel.com)<br />[🤔](#ideas-gaboesquivel "Ideas, Planning, & Feedback") [📖](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=gaboesquivel "Documentation") [💻](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=gaboesquivel "Code") [👀](#review-gaboesquivel "Reviewed Pull Requests") | [<img src="https://avatars2.githubusercontent.com/u/349542?v=4" width="100px;"/><br /><sub><b>Daniel Prado</b></sub>](https://github.com/danazkari)<br />[💻](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=danazkari "Code") [📖](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=danazkari "Documentation") [🤔](#ideas-danazkari "Ideas, Planning, & Feedback") [👀](#review-danazkari "Reviewed Pull Requests") | [<img src="https://avatars1.githubusercontent.com/u/1179619?v=4" width="100px;"/><br /><sub><b>Jorge Murillo</b></sub>](https://github.com/murillojorge)<br />[🤔](#ideas-murillojorge "Ideas, Planning, & Feedback") [📖](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=murillojorge "Documentation") [🎨](#design-murillojorge "Design") [💻](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=murillojorge "Code") [👀](#review-murillojorge "Reviewed Pull Requests") | [<img src="https://avatars0.githubusercontent.com/u/5632966?v=4" width="100px;"/><br /><sub><b>Xavier Fernandez</b></sub>](https://github.com/xavier506)<br />[🤔](#ideas-xavier506 "Ideas, Planning, & Feedback") [📝](#blog-xavier506 "Blogposts") [📢](#talk-xavier506 "Talks") [🚇](#infra-xavier506 "Infrastructure (Hosting, Build-Tools, etc)") | [<img src="https://avatars2.githubusercontent.com/u/13205620?v=4" width="100px;"/><br /><sub><b>Rubén Abarca Navarro</b></sub>](https://github.com/rubenabix)<br />[🤔](#ideas-rubenabix "Ideas, Planning, & Feedback") [👀](#review-rubenabix "Reviewed Pull Requests") |
| :---: | :---: | :---: | :---: | :---: |
<!-- ALL-CONTRIBUTORS-LIST:END -->
Thanks goes to these wonderful people ([emoji key](https://github.com/kentcdodds/all-contributors#emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/kentcdodds/all-contributors) specification. Contributions of any kind welcome!
