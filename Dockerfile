FROM ubuntu:14.04
MAINTAINER Tulio Ruiz <tulio@vauxoo.com>
RUN locale-gen fr_FR \
    && locale-gen en_US.UTF-8 \
    && dpkg-reconfigure locales \
    && update-locale LANG=en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 \
    && ln -s /usr/share/i18n/SUPPORTED /var/lib/locales/supported.d/all \
    && locale-gen \
    && echo 'LANG="en_US.UTF-8"' > /etc/default/locale

ENV PYTHONIOENCODING="utf-8" \
    LANG="C.UTF-8" \
    TERM="xterm"
RUN apt-get update -q && apt-get install -qy wget \
    && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - \
    && echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
    && echo 'APT::Get::Assume-Yes "true";' >> /etc/apt/apt.conf \
    && echo 'APT::Get::force-yes "true";' >> /etc/apt/apt.conf \
    && apt-get update -q && apt-get upgrade -q \
    && apt-get install --allow-unauthenticated -q \
    bzr \
    curl \
    git \
    htop \
    libffi-dev \
    libsasl2-dev \
    libssl-dev \
    locate \
    lsof \
    multitail \
    openssl \
    openssh-client \
    postgresql-client \
    python \
    python-dev \
    python-psycopg2 \
    python-setuptools \
    supervisor \
    tmux \
    unzip \
    vim \
    vim-nox \
    w3m \
    wget
RUN cd /tmp \
    && wget -q https://bootstrap.pypa.io/get-pip.py \
    && python get-pip.py \
    && pip install --upgrade pyopenssl ndg-httpsclient pyasn1 \
    && pip install PyGithub
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*
