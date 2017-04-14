#!/bin/bash

# Prepara os containers utilizados p/ ambiente de desenvolvimento - Monitoring
ELASTICSEARCH_CONTAINER=local-elasticsearch
ELASTICSEARCH_IMAGE_NAME=docker.elastic.co/elasticsearch/elasticsearch:5.3.0

echo 'Killing containers...'
docker rm -f $ELASTICSEARCH_CONTAINER

if [ "$1" != "rm" ] ; then
  if docker run -d --name $ELASTICSEARCH_CONTAINER -p 9200:9200 -e "http.host=0.0.0.0" -e "transport.host=127.0.0.1" $ELASTICSEARCH_IMAGE_NAME; then
    echo 'ELASTICSEARCH container running - port 9200'
  else
    echo 'Failed to create ELASTICSEARCH container\n\n'
  fi
fi
