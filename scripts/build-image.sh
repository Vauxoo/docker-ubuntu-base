#!/usr/bin/env sh

# Where's my apt?
APTGET="$( which apt-get )"

# I'm not here, i won't interact with you
APTGETCMD="env DEBIAN_FRONTEND=noninteractive ${APTGET}"

# Let's tell apt to not install recommendations,
# assume always a positive answer, and allow unauthenticated repos
# Dpkg: you need to install configurations always. Ah, and be quiet.
APTGETOPTS="-qq \
            -o Apt::Install-Recommends=false \
            -o Apt::Get::Assume-Yes=true \
            -o Apt::Get::AllowUnauthenticated=true \
            -o DPkg::Options::=--force-confmiss \
            -o DPkg::Options::=--force-confnew \
            -o DPkg::Options::=--force-overwrite \
            -o DPkg::Options::=--force-unsafe-io"

# List of software we need
DPKGDEPENDS="bzr \
             curl \
             git \
             htop \
             locate \
             lsof \
             multitail \
             openssl \
             openssh-client \
             postgresql-client \
             postgresql-common \
             python \
             python-psycopg2 \
             python-setuptools \
             python-pip \
             python-openssl \
             python-ndg-httpsclient \
             python-asn1 \
             python-github \
             python-click \
             supervisor \
             tmux \
             unzip \
             vim \
             vim-nox \
             w3m \
             wget"

# Blazing fast dpkg
{
	echo 'force-unsafe-io'
} | sudo tee etc/dpkg/dpkg.cfg.d/speedup > /dev/null

# Don't give me translations man, i can tok inglis
{
	echo 'Acquire::Languages "none";'
} | sudo tee etc/apt/apt.conf.d/no-languages > /dev/null

# This will setup our default locale.
# Setting these three variables will ensure we have a proper locale environment
# avoiding the use of PYTHONIOENCODING (See http://stackoverflow.com/a/34378962)
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Setting this according to vauxoo/docker-ubuntu-base#4
export TERM="xterm"

# Release the apt monster!
${APTGETCMD} ${APTGETOPTS} update
${APTGETCMD} ${APTGETOPTS} upgrade
${APTGETCMD} ${APTGETOPTS} install ${DPKGDEPENDS}

# Remove unnecessary files, we don't need you
find usr -name "*.pyc" -print0 | xargs -0r sudo rm -rfv
find var/cache/apt -type f -print0 | xargs -0r sudo rm -rfv
find var/lib/apt/lists -type f -print0 | xargs -0r sudo rm -rfv
find usr/share/man -type f -print0 | xargs -0r sudo rm -rfv
find usr/share/doc -type f -print0 | xargs -0r sudo rm -rfv
find usr/share/locale -type f -print0 | xargs -0r sudo rm -rfv
find var/log -type f -print0 | xargs -0r sudo rm -rfv
find var/tmp -type f -print0 | xargs -0r sudo rm -rfv
find tmp -type f -print0 | xargs -0r sudo rm -rfv
