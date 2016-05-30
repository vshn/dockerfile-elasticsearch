FROM elasticsearch:1

ENV TZ Europe/Paris
ENV ES_JAVA_OPTS -Des.script.disable_dynamic=false

EXPOSE 9200 9300
