FROM elasticsearch:1

ENV TZ Europe/Paris

RUN echo "script.disable_dynamic: false" >> /usr/share/elasticsearch/config/elasticsearch.yml

EXPOSE 9200 9300
