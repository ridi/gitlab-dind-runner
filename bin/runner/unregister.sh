#!/usr/bin/env bash

set -e

# Variables
RUNNER_NAME=${1}
CONFIG_PATH=config/config.toml

function print_usage
{
    echo
    echo "Usage: unregister.sh <RUNNER_NAME>"
    echo
    echo "Example:"
    echo "  unregister.sh runner_name"
}

if [[ ${#} != 1 ]]
then
    print_usage
    exit 1
fi

if [[ ! -f "${CONFIG_PATH}" ]]
then
    echo "A file \"${CONFIG_PATH}\" is not found."
    exit 1
fi

RE="\\[\\[runners\\]\\]"
RE="${RE}[^\\[]*"
RE="${RE}name = \\\"${RUNNER_NAME}\\\""
RE="${RE}[^\\[]*"
RE="${RE}url = \\\"([^\\\"]*)\\\""
RE="${RE}[^\\[]*"
RE="${RE}token = \\\"([^\\\"]*)\\\""
RE="${RE}[^\\[]*"

if [[ $(cat "${CONFIG_PATH}") =~ ${RE} ]]
then
    CI_SERVER_URL=${BASH_REMATCH[1]}
    RUNNER_TOKEN=${BASH_REMATCH[2]}
    echo "CI server url = ${CI_SERVER_URL}"
    echo "Runner token = ${RUNNER_TOKEN}"
else
    echo "A runner \"${RUNNER_NAME}\" is not found."
    exit 1
fi


docker-compose exec -T runner \
    gitlab-runner \
    unregister \
    -u "${CI_SERVER_URL}" \
    -t "${RUNNER_TOKEN}"
