FROM eosio/eos:v1.4.2

RUN apt-get update && apt-get install curl -y

COPY ./ /opt/application
# install EOS Contract Development Toolkit
RUN apt install /opt/application/utils/eosio.cdt-1.4.0.x86_64.deb

VOLUME /opt/application

WORKDIR /opt/application

# used by start.sh
ENV DATA_DIR /root/data-dir
ENV CONFIG_DIR /opt/application/config
ENV NODEOS_BIN_DIR /opt/eosio/bin

CMD /opt/application/start.sh
