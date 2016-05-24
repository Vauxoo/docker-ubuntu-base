#!/usr/bin/env bash

# Helper function to add a custom apt source
function conf_aptsources(){
    >/etc/apt/sources.list
    for REPO in "${@}"; do
        echo "${REPO}" >> /etc/apt/sources.list
    done
}

# Helper function to add a custom apt source
function add_custom_aptsource(){
    REPO="${1}"
    KEY="${2}"
    echo "${REPO}" >> /etc/apt/sources.list.d/100-vauxoo-repos.list
    wget -qO- "${KEY}" | apt-key add -
}

# Helper function to download a python script and execute
function py_download_execute(){
    URL="${1}"
    wget -qO- "${URL}" | python
}
