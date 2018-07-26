#!/usr/bin/env bash

set -e

# Variables
COMMAND=${1}

export RUNNER_IMAGE_TAG=alpine-v11.0.2

function print_usage
{
    echo
    echo "Usage: service.sh <COMMAND>"
    echo
    echo "Command:"
    echo "  status      Show jobs status"
    echo "  start       Start service"
    echo "  stop        Stop service"
    echo "  restart     Restart service"
}

if [[ ${#} != 1 ]]
then
    print_usage
    exit 1
fi

if [[ -z ${COMMAND} ]]
then
    echo "No command specified."
    print_usage
    exit 1;
fi

if [[ ${COMMAND} == "status" ]]; then docker-compose ps
elif [[ ${COMMAND} == "start" ]]; then docker-compose up -d
elif [[ ${COMMAND} == "stop" ]]; then docker-compose down
elif [[ ${COMMAND} == "restart" ]]; then docker-compose restart
else
    echo "${COMMAND} is undefined."
    print_usage
    exit 1;
fi
