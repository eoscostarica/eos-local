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

A common reusable docker based microservices architecture boilerplate and development environment that will allow to deploy EOS appliactions faster.

It's inspired on MonsterEOS' EOSIO DreamStack architecture.

EOS Local is a community-driven project led by EOS Costa Rica. We welcome contributions of all sorts. There are many ways to help, from reporting issues, proposing features, improving documentation, contributing code, design/ux proposals.

**Important Disclaimer: This is a Work in Progress** 

## Advantages.

- Get started with EOS DApp development in less than 5 minutes with a single command.
- Focus on your biz logic, not on configurations or integrating commonly used third party services.
- Scalable architecture. 
- Deploy your dApp dedicated services easily to any infrastructure provider with containers.  
- Ability to run multiple versions of EOS with different configuration with no conflicts.
- This project follows EOS DApp development best practices.
- Improved developer's experience. Yes! that super important isn't it? :) 

## Technical Specs

- Fully virtualized EOS blockchain development environment.
- Inteligent automated blockchain replay. ( no more replay flag shenanigans )
- Microservices architecture.
- Out-of-box services: 
  - Postgres database.
  - Mongodb database.
  - Demux service.
  - Eos-dev node for contract dev and compilation.
  - Eos fullnode with history.
  - Graphql endpoint.
  - Reactjs client with:
    - Scatter integration.
    - Lynx integration.
    - EOS Account profile page.
    - Material UI.
    - GraphQL Apollo client.
- Services accesible through virtual host names both from host machine and within the docker network.
- Handy scripts for interacting with the local EOS services.
- Gulp as global task manager.
- Automated code linting and testing.
- Automated "seeding" of testing accounts and contract compilation.
- Continuous Integration and Deployment. ( Travis and Netlify )
- Kubernetes support ( coming soon https://github.com/eoscostarica/eos-local/issues/8 )

*Note: at the moment we are not using a docker container for running the React client due to issues related to hot reloading the app efficiently*

## Getting started

Basic knowledge about Docker, Docker Compose, EOS and NodeJS is required.

### Installation

**Global Dependencies**

- Docker https://docs.docker.com/install/.   
At least 7GB RAM (Docker -> Preferences -> Advanced -> Memory -> 7GB or above)
- Install node.js v10 on your machine. We recommend using [nvm](https://github.com/creationix/nvm) and [avn](https://github.com/wbyoung/avn) to manage multiple node.js versions on your computer.
- Yarn https://yarnpkg.com/lang/en/docs/install/.
- Gulp CLI  `yarn global add gulp-cli`.

**NPM packages**

- run `yarn` on the root directoty to install node packages required by `gulp-cli`

## Commands

- `gulp setup` run chain initilization and database migrations.
- `gulp start` starts the docker containers.
- `gulp stop` stops and removes all containers.
- `gulp restart` restarts all services.
- `gulp flush` stop all services and remove all blockchain and database data.
- `gulp logs` displays and folows all services logs.

## Directory Structure

```
.
├── docs/ .............................................. documentation files and media
├── services/ .......................................... microservices
|   ├── demux/ ......................................... demux-js service
|   |   ├── database/ .................................. postgres config and migrations
|   |   ├── src/ ....................................... application biz logic 
|   |   ├── Dockerfile ................................. service image spec 
|   |   ├── pm2.config.js .............................. process specs for pm2
|   |   ├── tsconfig.json .............................. tslint config
|   |   ├── tslint.json ................................ code style rules
|   |   └── package.json ............................... service dependencies manifest
|   |
|   ├── eosiodev/ ...................................... eos-dev node for contact development
|   |   ├── config/ .................................... eos node config
|   |   ├── contracts/ ................................. smart contracts 
|   |   ├── scripts/ ................................... chain and wallet init scripts
|   |   ├── Dockerfile ................................. service image spec 
|   |   └── start.sh ................................... service startup script
|   |
|   ├── eos-node/ ...................................... eos fullnode
|   |   ├── config.ini ................................. eos node configuration file
|   |   ├── Dockerfile ................................. service image spec 
|   |   └── start.sh ................................... service startup script
|   |
|   └── frontend/ ...................................... reactjs frontend
|      ├── public/ .................................... static and public files
|      ├── src/ ....................................... reactjs views and components
|      ├── config-overrides.js ........................ configuration overrides for `cra`
|      ├── .env ....................................... environment variables
|      ├── .eslintrc .................................. code style rules
|      └── package.json ............................... service dependencies manifest
|   
├── docker-compose.yaml ................................ docker compose for local dev
├── contributing.md .................................... contributing guidelines
├── license ............................................ project license
├── readme.md .......................................... project documentation
├── netlify.toml ....................................... netlify config file
├── .travis.yml ........................................ travis ci config file
├── .editorconfig ...................................... common text editor configs
└── package.json ....................................... dependencies manifest for gulp-cli
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

We use a Kanban-style board. That's were we prioritize the work. [Go to Project Board](https://github.com/eoscostarica/eos-local/projects/3).

The main communication channels are [github issues](https://github.com/eoscostarica/eos-local/issues) and [EOS Costa Rica's Discord server](https://eoscostarica.io/discord). Feel to join and ask as many questions you may have.

Our weekly sync call is every Monday 1:00 AM UTC. [meet.eoscostarica.io](https:/meet.eoscostarica.io).

Contributing Guidelines https://learn.eoscostarica.io/open-source/.

Please report bugs big and small by [opening an issue](https://github.com/eoscostarica/eos-local/issues)

## Awesome Lists

https://github.com/EOS-Nation/Awesome-EOS
https://github.com/DanailMinchev/awesome-eosio
https://github.com/veggiemonk/awesome-docker
https://github.com/dhamaniasad/awesome-postgres
https://github.com/ramnes/awesome-mongodb
https://github.com/enaqx/awesome-react
https://github.com/jaredpalmer/awesome-react-render-props
https://github.com/chentsulin/awesome-graphql

## About EOS Costa Rica

EOS Blockchain is aiming to become a decentralized operating system which can support large-scale decentralized applications.

EOS Costa Rica supports the EOSIO community by maintaining and contributing to open source initiatives, meetups and workshops.

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
