FROM ubuntu:16.04
MAINTAINER Tulio Ruiz <tulio@vauxoo.com>

COPY scripts/build-image.sh /tmp/
RUN bash /tmp/build-image.sh
