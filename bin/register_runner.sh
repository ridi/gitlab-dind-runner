#!/usr/bin/env bash

set -e

# Variables
CI_SERVER_URL=${1}
REGISTER_TOKEN=${2}
RUNNER_NAME=${3}

function print_usage
{
    echo
    echo "Usage: register_runner.sh <CI_SERVER_URL> <REGISTER_TOKEN> <RUNNER_NAME>"
    echo
    echo "Example:"
    echo "  register_runner.sh https://gitlab.ridi.io/ RegiSTeRTokeN runner_name"
}

if [[ ${#} != 3 ]]
then
    print_usage
    exit 1
fi

docker-compose exec -T runner gitlab-runner register \
    --non-interactive \
    --url "${CI_SERVER_URL}" \
    --name "${RUNNER_NAME}" \
    --registration-token "${REGISTER_TOKEN}" \
    --cache-dir /cache \
    --builds-dir /builds \
    --executor docker \
    --docker-host tcp://docker-daemon:2375 \
    --docker-image alpine:3.8 \
    --docker-volumes /var/run/docker.sock:/var/run/docker.sock \
    --docker-volumes /srv/gitlab-runner/cache:/cache \
    --docker-volumes /srv/gitlab-runner/builds:/builds