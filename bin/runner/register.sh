#!/usr/bin/env bash

set -e

# Variables
RUNNER_NAME=${1}
CI_SERVER_URL=${2}
REGISTER_TOKEN=${3}
CONFIG_PATH=config/config.toml

function print_usage
{
    echo
    echo "Usage: register.sh <RUNNER_NAME> <CI_SERVER_URL> <REGISTER_TOKEN>"
    echo
    echo "Example:"
    echo "  register.sh runner_name https://gitlab.ridi.io/ RegiSTeRTokeN"
}

if [[ ${#} != 3 ]]
then
    print_usage
    exit 1
fi

if [[ -f "${CONFIG_PATH}" ]]
then
    RE="\\[\\[runners\\]\\]"
    RE="${RE}[^\\[]*"
    RE="${RE}name = \\\"${RUNNER_NAME}\\\""
    RE="${RE}[^\\[]*"
    RE="${RE}url = \\\"${CI_SERVER_URL}\\\""
    RE="${RE}[^\\[]*"
    RE="${RE}token = \\\"([^\\\"]*)\\\""
    RE="${RE}[^\\[]*"

    if [[ $(cat "${CONFIG_PATH}") =~ ${RE} ]]
    then
        echo "The runner \"${RUNNER_NAME}\" already exists."
        exit 1
    fi
fi

docker-compose exec -T runner \
    gitlab-runner \
    register \
    --non-interactive \
    --url "${CI_SERVER_URL}" \
    --name "${RUNNER_NAME}" \
    --registration-token "${REGISTER_TOKEN}" \
    --cache-dir /cache \
    --builds-dir /builds \
    --executor docker \
    --docker-host tcp://host.docker.gitlab:2375 \
    --docker-image alpine:3.8 \
    --docker-privileged \
    --docker-volumes /var/run/docker.sock:/var/run/docker.sock \
    --docker-volumes /cache:/cache \
    --docker-volumes /builds:/builds
