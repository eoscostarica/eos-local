FROM eosio/eos-dev:v1.4.1

RUN apt-get update && apt-get install curl -y

COPY ./ /opt/application

VOLUME /opt/application

WORKDIR /opt/eosio/bin

# install EOS Contract Development Toolkit
RUN wget https://github.com/eosio/eosio.cdt/releases/download/v1.3.2/eosio.cdt-1.3.2.x86_64.deb
RUN sudo apt install ./eosio.cdt-1.3.2.x86_64.deb
RUN sudo rm ./eosio.cdt-1.3.2.x86_64.deb

# used by start.sh
ENV DATA_DIR /root/.local/share
ENV CONFIG_DIR /opt/application/config

CMD /opt/application/start.sh
