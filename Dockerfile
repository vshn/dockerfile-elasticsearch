FROM alpine:3.4
ENV ELASTICSEARCH_VERSION 1.7.5
ENV PATH $PATH:/usr/share/elasticsearch/bin

# temporary hack around dokku to support dynamic scripting
# dokku isn't using the elasticsearch.yml file
# https://github.com/upfrontIO/dockerfile-elasticsearch/pull/2
ENV ES_JAVA_OPTS -Des.script.disable_dynamic=false

RUN \
  apk add --no-cache ca-certificates curl openjdk7-jre-base && \

  # install gosu
  curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.9/gosu-amd64" && \
  chmod +x /usr/local/bin/gosu && \

  # install elasticsearch
  adduser -S elasticsearch && \

  echo Downloading elasticsearch... && \
  curl -skL https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz | tar -xz -C /tmp && \
  mv /tmp/elasticsearch* /usr/share/elasticsearch && \

  # verify
  echo JAVA VERSION: && \
  java -version 2>&1 && \

  echo ELASTICSEARCH VERSION: && \
  elasticsearch -v && \

  # cleanup
  rm -rf /var/cache/apk/*

COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
VOLUME ["/usr/share/elasticsearch/data", "/usr/share/elasticsearch/logs"]

COPY start.sh /start.sh
ENTRYPOINT ["/start.sh"]
CMD ["elasticsearch"]
EXPOSE 9200 9300
