#!/usr/bin/env bash

set -e

# Variables
CI_SERVER_URL=${1}
RUNNER_TOKEN=${2}

function print_usage
{
    echo
    echo "Usage: unregister.sh <CI_SERVER_URL> <RUNNER_TOKEN>"
    echo
    echo "Example:"
    echo "  unregister.sh https://gitlab.ridi.io/ RunNErTokeN"
}

if [[ ${#} != 2 ]]
then
    print_usage
    exit 1
fi

docker-compose exec -T runner \
    gitlab-runner \
    unregister \
    -u "${CI_SERVER_URL}" \
    -t "${RUNNER_TOKEN}"
