FROM eosio/eos:v1.4.2

RUN apt-get update && apt-get install curl -y

COPY ./ /opt/application

VOLUME /opt/application

WORKDIR /opt/eosio/bin

## Add the wait script to the image
ADD ./utils/wait /wait
RUN chmod +x /wait

# Used by start.sh
ENV DATA_DIR /opt/eosio/bin/data-dir

## Launch the wait tool and then start nodeos
CMD /wait && /opt/application/start.sh
