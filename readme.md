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

The quickest and most efficient way to setup and maintain a local environment for development that is guaranteed to work out-of-the-box across the different host operating systems: Mac OS, Windows, and Linux.

It is a reusable docker based development environment inspired on MonsterEOS' EOSIO DreamStack architecture that will allow you to develop EOS applications faster.

EOS Local is a community-driven project led by EOS Costa Rica. We welcome contributions of all sorts. There are many ways to help, from reporting issues, proposing features, improving documentation, contributing code, design/ux proposals.


<p align="center">
	<img src="https://user-images.githubusercontent.com/5632966/48136073-56764a80-e264-11e8-9a9f-710b92b7f339.png" width="600">
</p>


**Important Disclaimer: This is a Work in Progress** 

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Architecture](#architecture)
- [Advantages](#advantages)
- [Technical Specs](#technical-specs)
- [Getting started](#getting-started)
  - [Installation](#installation)
- [Commands](#commands)
- [Chain Initialization and Database Migrations](#chain-initialization-and-database-migrations)
- [Directory Structure](#directory-structure)
- [Services](#services)
  - [demux](#demux)
  - [graphql](#graphql)
    - [PostGraphile](#postgraphile)
  - [eosiodev](#eosiodev)
    - [EOSIO.CDT (Contract Development Toolkit)  1.3.x](#eosiocdt-contract-development-toolkit--13x)
  - [fullnode](#fullnode)
  - [postgres](#postgres)
  - [flyway](#flyway)
  - [mongodb](#mongodb)
  - [ngnix-proxy](#ngnix-proxy)
  - [reactjs web client](#reactjs-web-client)
    - [components](#components)
- [Continuous Integration Process](#continuous-integration-process)
- [Using Cleos on EOS Local](#using-cleos-on-eos-local)
  - [Invoking cleos through docker-compose exec](#invoking-cleos-through-docker-compose-exec)
    - [Handy Yarn scritps](#handy-yarn-scritps)
  - [SHH into the containers and use cleos directly](#shh-into-the-containers-and-use-cleos-directly)
- [EOS Documentation & Resources](#eos-documentation--resources)
- [Frequently Asked Questions](#frequently-asked-questions)
  - [How does this project compare to EOSFactory ?](#how-does-this-project-compare-to-eosfactory-)
  - [Why Containers ?](#why-containers-)
  - [Why Database Migrations ?](#why-database-migrations-)
  - [Who is using EOS Local ?](#who-is-using-eos-local-)
- [Contributing](#contributing)
- [Awesome Lists](#awesome-lists)
- [About EOS Costa Rica](#about-eos-costa-rica)
- [License](#license)
- [Contributors](#contributors)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Architecture

<p align="center">
	<img src="assets/EOS-Local-Architecture.png" width="600">
</p>

## Advantages

- Get started with EOS DApp development in less than 5 minutes with a single command.
- Focus on your biz logic, not on configurations or integrating commonly used third party-services.
- Scalable microservices architecture. 
- Deploy your dApp dedicated services easily to any infrastructure provider with containers.  
- Ability to run multiple versions of EOS with different configuration with no conflicts.
- This project follows EOS DApp development best practices.

## Technical Specs

- Fully virtualized EOS blockchain development environment.
- Microservices architecture.
- Out-of-box services: 
  - Postgres database.
  - Mongodb database.
  - Demux service.
  - Flyway service for Postgres DB migrations.
  - Eos-dev node for contract dev and compilation.
  - Eos fullnode with history.
  - Graphql endpoint.
  - Reactjs client with:
    - Scatter integration.
    - Lynx integration.
    - EOS Account profile page.
    - Material UI.
    - GraphQL Apollo client.
- Services accessible through virtual host names both from host machine and within the docker network.
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
At least 10GB RAM (Docker -> Preferences -> Advanced -> Memory -> 10GB or above)
- Install node.js v10 on your machine. We recommend using [nvm](https://github.com/creationix/nvm) and [avn](https://github.com/wbyoung/avn) to manage multiple node.js versions on your computer.
- Yarn https://yarnpkg.com/lang/en/docs/install/.
- Gulp CLI  `yarn global add gulp-cli`.

**NPM packages**

- run `yarn` on the root directoty to install node packages required by `gulp-cli`

## Commands

- `gulp setup` run chain initialization and database migrations.
- `gulp start` starts the docker containers.
- `gulp stop` stops and removes all containers.
- `gulp restart` restarts all services.
- `gulp flush` stops all services and remove all blockchain and database data.
- `gulp logs` displays and follows all services logs.
- `gulp migrate` executes flywaydb migrations against the postgres database.
- `gulp psql` connects you to the postgres db instance thru command line.

## Chain Initialization and Database Migrations

When you run `gulp setup` several things will happen:

- Chain initialization.
- Testing Users Creation.
- Contracts Compilation and deployment.
- Postgres Schema Creation.
- Postgres Database Migrations.

See [services/eos-dev/scripts/0000_init_chain.sh](https://github.com/eoscostarica/eos-local/blob/master/services/eos-dev/scripts/0000_init-chain.sh)

## Directory Structure

```
.
├── docs/ .............................................. documentation files and media
├── services/ .......................................... microservices
|   ├── demux/ ......................................... demux-js service
|   |   ├── utils/ ..................................... general utilities
|   |   ├── src/ ....................................... application biz logic 
|   |   ├── Dockerfile ................................. service image spec 
|   |   ├── pm2.config.js .............................. process specs for pm2
|   |   ├── tsconfig.json .............................. tslint config
|   |   ├── tslint.json ................................ code style rules
|   |   └── package.json ............................... service dependencies manifest
|   |
|   ├── eosiodev/ ...................................... eos-dev node for contact development
|   |   ├── utils/ ..................................... general utilities
|   |   ├── config/ .................................... eos node config
|   |   ├── contracts/ ................................. smart contracts 
|   |   ├── scripts/ ................................... chain and wallet init scripts
|   |   ├── Dockerfile ................................. service image spec 
|   |   └── start.sh ................................... service startup script
|   |
|   ├── eos-fullnode/ .................................. eos fullnode
|   |   ├── utils/ ..................................... general utilities
|   |   ├── config.ini ................................. eos node configuration file
|   |   ├── Dockerfile ................................. service image spec 
|   |   └── start.sh ................................... service startup script
|   |
|   ├── postgres/ ...................................... postgres db related files
|   |   └── migrations/ ................................ flyway migrations
|   |
|   └── frontend/ ...................................... reactjs frontend
|       ├── public/ .................................... static and public files
|       ├── src/ ....................................... reactjs views and components
|       ├── config-overrides.js ........................ configuration overrides for `cra`
|       ├── .env ....................................... environment variables
|       ├── .eslintrc .................................. code style rules
|       └── package.json ............................... service dependencies manifest
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

## Designing and Developing EOS Smart Contracts

Recommended process for designing EOS Smart Contracts.  

<p align="center">
	<img src="assets/smart-contracts-process.png" width="300">
</p>

Simple use case of equipment rentals that list their equipment for rent and renters who pay rent for those items.
[digital-scarcity/equiprental](https://github.com/digital-scarcity/equiprental)


## Services

### demux

Demux is a backend infrastructure pattern for sourcing blockchain events to deterministically update queryable datastores and trigger side effects. 

Taking inspiration from the [Flux Architecture](https://facebook.github.io/flux/docs/in-depth-overview.html#content) pattern and [Redux](https://github.com/reduxjs/redux/), Demux was born out of the following qualifications:

1. A separation of concerns between how state exists on the blockchain and how it is queried by the client front-end
1. Client front-end not solely responsible for determining derived, reduced, and/or accumulated state
1. The ability for blockchain events to trigger new transactions, as well as other side effects outside of the blockchain
1. The blockchain as the single source of truth for all application state

<p align="center">
		<img src="assets/demux.png" width="600">
</p>

1. Client sends transaction to blockchain.
1. Action Watcher invokes Action Reader to check for new blocks.
1. Action Reader sees transaction in new block, parses actions.
1. Action Watcher sends actions to Action Handler.
1. Action Handler processes actions through Updaters and Effects.
1. Actions run their corresponding Updaters, updating the state of the Datastore.
1. Actions run their corresponding Effects, triggering external events.
1. Client queries API for updated data.

Learn more at https://github.com/EOSIO/demux-js.

### graphql 

GraphQL is a query language for APIs and a runtime for fulfilling those queries with your existing data. GraphQL provides a complete and understandable description of the data in your API, gives clients the power to ask for exactly what they need and nothing more, makes it easier to evolve APIs over time, and enables powerful developer tools.

There are many reason for choosing GraphQL over other solutions, read [Top 5 Reasons to Use GraphQL](https://www.prisma.io/blog/top-5-reasons-to-use-graphql-b60cfa683511/).

__Move faster with powerful developer tools__

Know exactly what data you can request from your API without leaving your editor, highlight potential issues before sending a query, and take advantage of improved code intelligence. GraphQL makes it easy to build powerful tools like [GraphiQL](https://github.com/graphql/graphiql) by leveraging your API’s type system.

The GraphiQL instance on EOS Local is available at http://localhost:3030/graphiql

<p align="center">
	<img src="assets/graphiql.png" width="600">
</p>

Learn more at https://graphql.org & https://www.howtographql.com

#### PostGraphile 

PostGraphile is an open-source tool to help you rapidly design and serve a high-performance, secure, client-facing GraphQL API backed primarily by your PostgreSQL database. Delight your customers with incredible performance whilst maintaining full control over your data and your database. Use our powerful plugin system to customise every facet of your GraphQL API to your liking.

This is what EOS Local uses to provide the GraphQL endpoint.

Learn more at https://www.graphile.org/postgraphile

### eosiodev

This ubuntu server contains everything that's required for contract compilation.

The eosio/eos image does not contain the required dependencies for contract development (this is by design, to keep the image size small), we use eosio.cdt for this and the `eosiodev` docker image already has it installed for automated and manual compilation.

__Note:__
*The eosio/eos-dev image contains both the required binaries and dependencies to build contracts using `eosiocpp`. https://hub.docker.com/r/eosio/eos-dev/ the base image can be found at https://github.com/EOSIO/eos/blob/master/Docker/dev/Dockerfile. However eosiocpp is now deprecated in favor `eosio-cpp` and the lastest `eosio/oes-dev` docker image does not contain `eosio-cpp`, at least not yet* 

Follow up on https://github.com/eoscostarica/eos-local/issues/27

#### EOSIO.CDT (Contract Development Toolkit)  1.3.x

EOSIO.CDT is a toolchain for WebAssembly (WASM) and set of tools to facilitate contract writing for the EOSIO platform. In addition to being a general purpose WebAssembly toolchain, EOSIO specific optimizations are available to support building EOSIO smart contracts. This new toolchain is built around Clang 7, which means that EOSIO.CDT has the most currently available optimizations and analyses from LLVM, but as the WASM target is still considered experimental, some optimizations are not available or incomplete.

Learn more at https://github.com/EOSIO/eosio.cdt

### fullnode

This is node the provides the RPC API.

See fullnode cofiguration at https://github.com/eoscostarica/eos-local/blob/master/services/eos-fullnode/config.ini

https://hub.docker.com/r/eosio/eos/ the base image source code can be found at https://github.com/EOSIO/eos/blob/master/Docker/Dockerfile.

### postgres

Postgres database instance for the demux and graphql service.

PostgreSQL is a powerful, open source object-relational database system with over 30 years of active development that has earned it a strong reputation for reliability, feature robustness, and performance.

- Postgres has a strongly typed schema that leaves very little room for errors. You first create the schema for a table and then add rows to the table. You can also define relationships between different tables with rules so that you can store related data across several tables and avoid data duplication.

- You can change tables in PostgreSQL without requiring to lock it for every operation. For example, you can add a column and set a default value quickly without locking the entire table. This ensures that every row in a table has the column and your codebase remains clean without needing to check if the column exists at every stage. It is also much quicker to update every row since Postgres doesn't need to retrieve each row, update, and put it back.

- Postgres also supports JSONB, which lets you create unstructured data, but with data constraint and validation functions to help ensure that JSON documents are more meaningful. The folks at Sisense have written a great blog with a detailed comparison of [Postgres vs MongoDB for JSON documents](https://www.sisense.com/blog/postgres-vs-mongodb-for-storing-json-data/).

- The newest round of performance comparisons of PostgreSQL and MongoDB produced a near repeat of the results from the first tests that proved PostgreSQL can outperform MongoDB.

<p align="center">
		<img src="assets/postgres.webp" width="600">
</p>

Learn more at https://www.postgresql.org

### flyway

Flyway is an open-source database migration tool. It strongly favors simplicity and convention over configuration.
It is based around just 7 basic commands: Migrate, Clean, Info, Validate, Undo, Baseline and Repair.
EOS Local leverages Flyway to manage the Postgres database migrations.

Learn more at https://flywaydb.org/documentation/migrations & https://flywaydb.org/documentation/videos

### mongodb

MongoDB instance for the fullnode. 

The eosio::mongo_db_plugin provides archiving of blockchain data into a MongoDB. It is recommended that the plugin be added to a non-producing node as it is designed to shut down on any failed insert into the MongoDB and is resource intensive.

https://developers.eos.io/eosio-nodeos/docs/mongo_db_plugin

### admin-mongo

AdminMongo is a Web based user interface (GUI) to handle all your MongoDB connections/databases needs. adminMongo is fully responsive and should work on a range of devices.

Out-of-the-box it is connected to the fullnode mongodb instance and allows you to explore transactions and other data in that database. Docker compose exposes it on https://localhost:8082 and thru http://admin-mongo.eoslocal.io with the nginx reverse-proxy.

<p align="center">
	<img src="assets/admin-mongo.png" width="600">
</p>

_adminMongo connection information (including username/password) is stored unencrypted in a config file, it is not recommended to run this application on a production or public facing server without proper security considerations._

Learn more https://mrvautin.com/adminmongo/

### ngnix-proxy

Nginx reverse proxy that allows accesing the services directly on the host machine the wildcard `*.esolocal.io` that points to `127.0.0.1`, therefore as long as you can hit the dns server it will redirect all requests to your machine and nginx-proxy does the internal docker network routing to the right service. 

Run `ping {whatever}.eoslocal.io` to verify.

Optionally you can avoid the round trip and work offline maintaining virtual hosts by manually adding your dns to your `hosts` file. https://en.wikipedia.org/wiki/Hosts_(file)

See the `docker-compose.yml` for available virtual hosts for easier access without port shenanigans.

### reactjs web client

In the services/frontend folder you will find a production ready frontend with Scatter and Lynx libraries ready for you to use. 

#### components

- [react-app-rewired](https://github.com/timarney/react-app-rewired) for tweaking `create-react-app` configuration without ejecting.
- [reach-router](https://github.com/reach/router) for a more accessible router.
- state management with [rematch](https://github.com/rematch/rematch) to use `redux` best practices without all the boilerplate.
- [react-apollo](https://github.com/apollographql/react-apollo) react apollo client.
- [material-ui](https://github.com/mui-org/material-ui).
- [scatter-js](https://github.com/GetScatter/scatter-js).
- [eoslynx integration](https://developers.eoslynx.com/).

## Continuous Integration Process

- [TravisCI](https://travis-ci.org/) to run test and code style checks.  We are planning on moving to Circle CI https://github.com/eoscostarica/eos-local/projects/3.
- [Netlify](https://netlify.com) for continuous delivery and creation of ephemeral test environments.

## Using Cleos on EOS Local

Cleos is a command line tool that interfaces with the REST API exposed by nodeos. In order to use cleos you will need to have the end point (IP address and port number) to a nodeos instance and also configure nodeos to load the 'eosio::chain_api_plugin'. `cleos` contains documentation for all of its commands. 

More at https://developers.eos.io/eosio-nodeos/docs/cleos-overview 

EOS Local comes with 2 EOS nodes running in separate docker containers, you can interact with these nodes using `cleos` in several ways:

### Invoking cleos through docker-compose exec

You can execute commands on any container from you host machine using the `docker-compose exec` command.
Eg:

`docker-compose exec eosiodev cleos --url http://localhost:8888/`

We recomend using declaring alias on your shell configuration  Eg (.bashrc or .zshrc) 

```
alias cleos_eosiodev='docker-compose exec eosiodev cleos --url http://localhost:8888/'
alias cleos_fullnode='docker-compose exec fullnode cleos --url http://localhost:8888/'
```

After you have added those lines to your config you can open a new terminal window and run `cleos_eosiodev --help` and `cleos_fullnode --help` to test.

#### Handy Yarn scritps

EOS Local provides to handy yarn scripts to accomplish the same functionality mentioned above.

-  `yarn cleos` ............. connects to eosiodev node
-  `yarn cleos:eosiodev` .... connects to eosiodev node
-  `yarn cleos:fullnode` .... connects to the eos fullnode

__Important note:__  
*We currently use yarn instead gulp for this because it allows to pass parameters more easily.
In the future gulp and yarn script at the root level will be replaced with an `eoslocal` cli.*

Follow up here https://github.com/eoscostarica/eos-local/issues/17 

### SHH into the containers and use cleos directly

You can also login into the containers using the following docker-compose command 

`docker-compose exec [service_name] bash`  where `service_name` is either `eosiodev` or `fullnode`

That will log you in and you will be able to execute cleos directly within the ubuntu server.
Eg.

```
➜  eos-local git:(master) ✗ docker-compose exec eosiodev bash
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

## EOS Documentation & Resources

- https://github.com/EOSIO/eos/tree/master/Docker
- https://developers.eos.io  
- https://github.com/EOSIO/eosio.contracts  
- https://learn.eoscostarica.io    
- https://github.com/slowmist/eos-smart-contract-security-best-practices    
- https://nadejde.github.io/eos-token-sale    
- https://docs.docker.com/kitematic/userguide/    

## Frequently Asked Questions

### How does this project compare to EOSFactory ?

EOSFactory is Python-based framework for building and testing EOS smart contracts. EOS Local has a larger scope. It is Docker-based and serves as boilerplate to start a scalable EOSIO project with microservices architecture following best practices at all levels. It includes many required services for large-scale EOSIO based applications and ReactJS client with Scatter and Lynx already integrated.

### Why Containers ?

The primary benefits of containers are efficiency and agility. Containers are orders of magnitude faster to provision, and much lighter-weight to build and define versus methods like omnibus software builds and full Virtual Machine images. Containers in a single OS are also more efficient at resource utilization than running a Hypervisor and guest OSs.

Efficiency and agility are good for everyone, but they become game-changers at scale. 

It also gives the ability to run distint versions of the different services like EOSIO on your laptop without conflicts.

Containers offer a logical packaging mechanism in which applications can be abstracted from the environment in which they actually run. This decoupling allows container-based applications to be deployed easily and consistently, regardless of whether the target environment is a private data center, the public cloud, or even a developer’s personal laptop. Containerization provides a clean separation of concerns, as developers focus on their application logic and dependencies, while IT operations teams can focus on deployment and management without bothering with application details such as specific software versions and configurations specific to the app.

For those coming from virtualized environments, containers are often compared with virtual machines (VMs). You might already be familiar with VMs: a guest operating system such as Linux or Windows runs on top of a host operating system with virtualized access to the underlying hardware. Like virtual machines, containers allow you to package your application together with libraries and other dependencies, providing isolated environments for running your software services. As you’ll see below however, the similarities end here as containers offer a far more lightweight unit for developers and IT Ops teams to work with, carrying a myriad of benefits.

<p align="center">
		<img src="assets/containers.png" width="600">
</p>

Learn more at https://cloud.google.com/containers/

### Why Database Migrations ?

- It enables a rock-solid deployment process because you are doing exactly the same when updating your local database, your development database, your QA database, your acceptance database and your production database. It’s always the same process and it can be automated.
- You can easily bring a (CI-)database to the point you want by loading a baseline backup and running all migration scripts until a certain point.
- If you do it right you have database versioning and change documentation included
- The approach encourages small changes at a time, leading to less risky deployments
- It enables and empowers continuous integration because you can easily transport your functional stat to different data sets (e.g. test data)
- You know exactly what’s happening. That’s in my opinion the greatest benefit of all, because it gives you confidence that what you’re delivering will work. It also gives you enormous flexibility and lets you solve any kind of challenge – even and especially ones which need specific business logic.

Learn more at https://dev.to/pesse/one-does-not-simply-update-a-database--migration-based-database-development-527d

### Who is using EOS Local ?

- [BeSpiral](http://bespiral.com).
- [EOS Rate](https://rate.eoscostarica.io).
- [DMeetup](https://github.com/eoscostarica/dmeetup).
- Add your project by creating a pull request.

## Contributing

We use a Kanban-style board. That's were we prioritize the work. [Go to Project Board](https://github.com/eoscostarica/eos-local/projects/3).

The main communication channels are [github issues](https://github.com/eoscostarica/eos-local/issues) and [EOS Costa Rica's Discord server](https://eoscostarica.io/discord). Feel to join and ask as many questions you may have.

Our weekly sync call is every Monday 1:00 AM UTC. [meet.eoscostarica.io](https:/meet.eoscostarica.io).

Contributing Guidelines https://learn.eoscostarica.io/open-source/.

Please report bugs big and small by [opening an issue](https://github.com/eoscostarica/eos-local/issues)

## Awesome Lists

- https://github.com/EOS-Nation/Awesome-EOS
- https://github.com/DanailMinchev/awesome-eosio
- https://github.com/kesar/eos-awesome-contracts/
- https://github.com/veggiemonk/awesome-docker
- https://github.com/dhamaniasad/awesome-postgres
- https://github.com/ramnes/awesome-mongodb
- https://github.com/enaqx/awesome-react
- https://github.com/jaredpalmer/awesome-react-render-props
- https://github.com/chentsulin/awesome-graphql

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
| [<img src="https://avatars0.githubusercontent.com/u/391270?v=4" width="100px;"/><br /><sub><b>Gabo Esquivel</b></sub>](https://gaboesquivel.com)<br />[🤔](#ideas-gaboesquivel "Ideas, Planning, & Feedback") [📖](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=gaboesquivel "Documentation") [💻](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=gaboesquivel "Code") [👀](#review-gaboesquivel "Reviewed Pull Requests") | [<img src="https://avatars2.githubusercontent.com/u/349542?v=4" width="100px;"/><br /><sub><b>Daniel Prado</b></sub>](https://github.com/danazkari)<br />[💻](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=danazkari "Code") [📖](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=danazkari "Documentation") [🤔](#ideas-danazkari "Ideas, Planning, & Feedback") [👀](#review-danazkari "Reviewed Pull Requests") | [<img src="https://avatars1.githubusercontent.com/u/1179619?v=4" width="100px;"/><br /><sub><b>Jorge Murillo</b></sub>](https://github.com/murillojorge)<br />[🤔](#ideas-murillojorge "Ideas, Planning, & Feedback") [📖](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=murillojorge "Documentation") [🎨](#design-murillojorge "Design") [💻](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=murillojorge "Code") [👀](#review-murillojorge "Reviewed Pull Requests") | [<img src="https://avatars0.githubusercontent.com/u/5632966?v=4" width="100px;"/><br /><sub><b>Xavier Fernandez</b></sub>](https://github.com/xavier506)<br />[🤔](#ideas-xavier506 "Ideas, Planning, & Feedback") [📝](#blog-xavier506 "Blogposts") [📢](#talk-xavier506 "Talks") [🚇](#infra-xavier506 "Infrastructure (Hosting, Build-Tools, etc)") | [<img src="https://avatars2.githubusercontent.com/u/13205620?v=4" width="100px;"/><br /><sub><b>Rubén Abarca Navarro</b></sub>](https://github.com/rubenabix)<br />[🤔](#ideas-rubenabix "Ideas, Planning, & Feedback") [👀](#review-rubenabix "Reviewed Pull Requests") [💻](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=rubenabix "Code") | [<img src="https://avatars2.githubusercontent.com/u/15035769?v=4" width="100px;"/><br /><sub><b>jsegura17</b></sub>](https://github.com/jsegura17)<br />[💻](https://github.com/eoscostarica/eos-dapp-dev-env/commits?author=jsegura17 "Code") [👀](#review-jsegura17 "Reviewed Pull Requests") [🤔](#ideas-jsegura17 "Ideas, Planning, & Feedback") | [<img src="https://avatars1.githubusercontent.com/u/6147142?v=4" width="100px;"/><br /><sub><b>Leo Ribeiro</b></sub>](http://leordev.github.io)<br />[🤔](#ideas-leordev "Ideas, Planning, & Feedback") [👀](#review-leordev "Reviewed Pull Requests") |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| [<img src="https://avatars2.githubusercontent.com/u/16544451?v=4" width="100px;"/><br /><sub><b>Mariano Alvarez</b></sub>](https://github.com/mahcr)<br />[🤔](#ideas-mahcr "Ideas, Planning, & Feedback") [👀](#review-mahcr "Reviewed Pull Requests") | [<img src="https://avatars1.githubusercontent.com/u/1082127?v=4" width="100px;"/><br /><sub><b>Julien Lucca</b></sub>](http://lucca65.github.io)<br />[👀](#review-lucca65 "Reviewed Pull Requests") [🤔](#ideas-lucca65 "Ideas, Planning, & Feedback") | [<img src="https://avatars2.githubusercontent.com/u/40245170?v=4" width="100px;"/><br /><sub><b>Edgar Fernandez</b></sub>](http://www.eoscostarica.io)<br />[🤔](#ideas-edgar-eoscostarica "Ideas, Planning, & Feedback") [📝](#blog-edgar-eoscostarica "Blogposts") [📢](#talk-edgar-eoscostarica "Talks") |
<!-- ALL-CONTRIBUTORS-LIST:END -->
Thanks goes to these wonderful people ([emoji key](https://github.com/kentcdodds/all-contributors#emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/kentcdodds/all-contributors) specification. Contributions of any kind welcome!
