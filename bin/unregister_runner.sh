#!/usr/bin/env bash

set -e

# Variables
RUNNER_TOKEN=${1}

function print_usage
{
    echo
    echo "Usage: unregister_runner.sh <RUNNER_TOKEN>"
    echo
    echo "Example:"
    echo "  unregister_runner.sh RunNErTokeN"
}

if [[ ${#} != 1 ]]
then
    print_usage
    exit 1
fi

docker-compose exec -T runner gitlab-runner unregister -t ${RUNNER_TOKEN}
