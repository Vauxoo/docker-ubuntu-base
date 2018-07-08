FROM ubuntu:16.04
MAINTAINER Tulio Ruiz <tulio@vauxoo.com>

RUN apt-get update \
    && apt-get install locales language-pack-es -y \
    && locale-gen "en_US.UTF-8" "fr_FR.UTF-8" "es_MX.UTF-8" \
    "es_PA.UTF-8" "es_VE.UTF-8" "es_GT.UTF-8" "es_PE.UTF-8" \
    "es_ES.UTF-8"
ENV LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" LC_ALL="en_US.UTF-8" LC_COLLATE="C" \
    PYTHONIOENCODING="UTF-8" TERM="xterm" DEBIAN_FRONTEND="noninteractive"

COPY scripts/*.sh /usr/share/vx-docker-internal/ubuntu-base/
RUN bash /usr/share/vx-docker-internal/ubuntu-base/build-image.sh
