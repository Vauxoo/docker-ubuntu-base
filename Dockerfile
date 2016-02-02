FROM ubuntu:14.04
MAINTAINER Tulio Ruiz <tulio@vauxoo.com>
RUN echo 'APT::Get::Assume-Yes "true";' >> /etc/apt/apt.conf \
    && echo 'APT::Get::force-yes "true";' >> /etc/apt/apt.conf
RUN locale-gen fr_FR \
    && locale-gen en_US.UTF-8 \
    && dpkg-reconfigure locales \
    && update-locale LANG=en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8
RUN ln -s /usr/share/i18n/SUPPORTED /var/lib/locales/supported.d/all \
    && locale-gen
ENV PYTHONIOENCODING utf-8
ENV TERM xterm
RUN apt-get update -q && apt-get upgrade -q \
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
    libssl-dev
RUN cd /tmp && wget -q https://bootstrap.pypa.io/get-pip.py && python get-pip.py
RUN pip install --upgrade pyopenssl ndg-httpsclient pyasn1
RUN pip install PyGithub
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*
