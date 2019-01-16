FROM eosio/eos-dev:v1.5.2

RUN apt-get update && apt-get install curl git -y

COPY ./ /opt/application

VOLUME /opt/application
WORKDIR /opt/application

## Add the wait script to the image
ADD ./utils/wait /wait
RUN chmod +x /wait

# used by start.sh
ENV DATA_DIR /root/data-dir
ENV CONFIG_DIR /opt/application/config
ENV NODEOS_BIN_DIR /opt/eosio/bin

## Launch the wait tool and then start nodeos ( see docker compose, we are waiting for mongo)
CMD /wait && /opt/application/scripts/start.sh
