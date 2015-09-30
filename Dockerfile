FROM elasticsearch:1

ENV TZ Europe/Paris

# Install Marvel - only free for Development!
RUN /usr/share/elasticsearch/bin/plugin -i elasticsearch/marvel/latest

RUN echo "script.disable_dynamic: false" >> /usr/share/elasticsearch/config/elasticsearch.yml

EXPOSE 9200 9300
