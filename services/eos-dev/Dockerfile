FROM eosio/eos-dev:v1.3.0

RUN apt-get update && apt-get install -y --no-install-recommends curl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY ./ /opt/application

VOLUME /opt/application

WORKDIR /opt/eosio/bin
