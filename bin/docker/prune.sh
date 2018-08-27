#!/usr/bin/env bash

set -e

# Variables
PRUNE_TARGET=${1}

function print_usage
{
    echo
    echo "Usage: prune.sh <PRUNE_TARGET>"
    echo
    echo "Example:"
    echo "  prune.sh image"
}

if [[ ${#} != 1 ]]
then
    print_usage
    exit 1
fi

docker-compose exec -T docker \
    docker "${PRUNE_TARGET}" prune -f
