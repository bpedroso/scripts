#!/bin/bash

if [ $# != 2 ]
then
    printf "\nUsage: $(basename "$0") <nexus url:port> <image name> <version>\n"
    exit 1
fi

export NEXUS_URL=$1
export IMAGE_NAME=$2
export IMAGE_VERSION=$3

echo "Starting process to push image on ${NEXUS_URL}"

IMAGE_ID=$(docker images | grep ${IMAGE_NAME} | awk '{print $3}')

if [[ -n ${IMAGE_ID} ]] ; then
    echo "Working with image ${IMAGE_NAME} - ${IMAGE_VERSION} - ${IMAGE_ID}"

    echo "  - Executing: docker tag ${IMAGE_ID} ${NEXUS_URL}/${IMAGE_NAME}:latest"
    docker tag ${IMAGE_ID} ${NEXUS_URL}/${IMAGE_NAME}:latest

    echo "  - Executing: docker push ${NEXUS_URL}/c4-catalog-api:latest"
    docker push ${NEXUS_URL}/c4-catalog-api:latest

    docker rmi -f ${IMAGE_ID}
else
    echo "Image '${IMAGE_NAME}' does not exist"
    exit -1
fi

exit 0
