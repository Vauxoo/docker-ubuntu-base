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
ENV PYTHONIOENCODING utf-8
ENV LANG C.UTF-8
ENV TERM xterm
RUN echo 'APT::Get::Assume-Yes "true";' >> /etc/apt/apt.conf \
    && echo 'APT::Get::force-yes "true";' >> /etc/apt/apt.conf \
    && apt-get update -q && apt-get upgrade -q \
    && apt-get install --allow-unauthenticated -q bzr \
    python \
    python-dev \
    python-psycopg2 \
    python-setuptools \
    git \
    vim \
    wget \
    curl \
    supervisor \
    openssh-client \
    tmux \
    lsof \
    w3m \
    multitail \
    postgresql-client \
    locate \
    unzip \
    htop \
    libsasl2-dev \
    openssl \
    libffi-dev \
    libssl-dev \
    vim-nox
RUN cd /tmp \
    && wget -q https://bootstrap.pypa.io/get-pip.py \
    && python get-pip.py \
    && pip install --upgrade pyopenssl ndg-httpsclient pyasn1 \
    && pip install PyGithub
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*
