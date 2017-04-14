#!/bin/bash

# Prepara os containers utilizados p/ ambiente de desenvolvimento - Monitoring
RABBITMQ_CONTAINER=local-rabbitmq

RABBITMQ_AMQP_PORT=5672
RABBITMQ_WEB_PORT=15672

echo 'Killing containers...'
docker rm -f $RABBITMQ_CONTAINER

if [ "$1" != "rm" ] ; then
  if docker run -d --name $RABBITMQ_CONTAINER -p $RABBITMQ_WEB_PORT:15672 -p $RABBITMQ_AMQP_PORT:5672 rabbitmq:3-management; then
    echo 'RabbitMQ container running - port '$RABBITMQ_AMQP_PORT' and '$RABBITMQ_WEB_PORT
  else
    echo 'Failed to create RabbitMQ container\n\n'
  fi
fi
