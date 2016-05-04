#!/usr/bin/env bash

# We need a custom download function since at this moment we haven't installed
# wget or curl yet, but fallback to them if present
function downecho() {

    URL="${1}"

    if [[ -x "$( which wget )" ]]; then
        wget -qO- ${URL}
    else
        HEADERS_READ="no"
        TEMPFILE="$( tempfile )"

        read PROTOCOL SERVER DOC <<< $( echo "${URL//// }" )

        DOC=/${DOC// //}
        HOST=${SERVER//:*}
        PORT=${SERVER//*:}

        [[ x"${HOST}" == x"${PORT}" ]] && PORT=80

        exec 3<>/dev/tcp/${HOST}/${PORT}

        printf "GET %s HTTP/1.1\r\nHost: %s\r\nUser-Agent: Bash/%s\r\n\r\n" "${DOC}" "${HOST}" "${BASH_VERSION}" >&3

        IFS=
        while read -r -t 1 LINE 0<&3; do
            LINE=${LINE//$'\r'}

            if [[ "${HEADERS_READ}" == "no" ]]; then
                [[ -z "${LINE}" ]] && HEADERS_READ="yes"
                continue
            fi

            echo "${LINE}" >> "${TEMPFILE}"
        done
        exec 3<&-

        tail -n +2 "${TEMPFILE}" | head -n -2
        rm "${TEMPFILE}"
    fi
}

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
    downecho "${KEY}" | apt-key add -
}

# Helper function to download a python script and execute
function py_download_execute(){
    URL="${1}"
    downecho ${URL} | python
}
