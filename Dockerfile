FROM eosio/eosio:release_1.8.x as eosio.contracts.v1.8.x
WORKDIR /app

# install dependencies
RUN apt-get update
RUN apt-get install -y wget git build-essential cmake --no-install-recommends
RUN rm -rf /var/lib/apt/lists/*

# install eosio.cdt
RUN wget https://github.com/eosio/eosio.cdt/releases/download/v1.6.3/eosio.cdt_1.6.3-1-ubuntu-18.04_amd64.deb
RUN apt install ./eosio.cdt_1.6.3-1-ubuntu-18.04_amd64.deb

# build contracts
RUN git clone https://github.com/EOSIO/eosio.contracts.git
RUN cd /app/eosio.contracts \
  && git checkout release/1.8.x \
  && ./build.sh -c /usr/local/eosio.cdt

FROM eosio/eosio:release_1.8.x as nodeos
WORKDIR /app
ENV TESTNET_EOSIO_PRIVATE_KEY 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
ENV TESTNET_EOSIO_PUBLIC_KEY EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV

COPY ./start.sh ./
COPY ./config.ini ./config/
COPY ./genesis.json ./
COPY --from=eosio.contracts.v1.8.x /app/eosio.contracts/build/contracts ./eosio.contracts.v1.8.x

RUN chmod +x ./start.sh
CMD ["./start.sh"]