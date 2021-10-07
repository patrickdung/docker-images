# SPDX-License-Identifier: Apache-2.0
#
# Copyright (c) 2021 Patrick Dung

FROM docker.io/debian:bullseye-slim

#ARG MEILISEARCH_VERSION="v0.23.0rc0"
ARG MEILISEARCH_VERSION=""
#ARG ARCH="amd64"
ARG ARCH=""

ARG SOURCE_BINARY_BASEURL="https://github.com/meilisearch/MeiliSearch/releases/download"

#https://github.com/meilisearch/MeiliSearch/releases/download/v0.23.0rc0/meilisearch-linux-amd64
#https://github.com/meilisearch/MeiliSearch/releases/download/v0.23.0rc0/meilisearch-linux-armv8

RUN set -eux && \
    apt-get -y update && \
    apt-get -y install --no-install-suggests \
    bash vim-tiny tini curl file procps binutils binutils-aarch64-linux-gnu binutils-multiarch && \
    rm -rf /var/lib/apt/lists/* && \
    addgroup \
      --gid 1000 \
      meilisearch && \
    adduser \
      --shell /bin/bash \
      --uid 1000 \
      --gid 1000 \
      --disabled-password \
      meilisearch && \
    mkdir -p /meilisearch /data.ms && \
    chown meilisearch:meilisearch /meilisearch /data.ms

USER 1000:1000

RUN set -eux && \
    mkdir /home/meilisearch/bin && \
    chmod 755 /home/meilisearch/bin

    # source url uses armv8 instead of arm64
    # curl -L -v -o /home/meilisearch/bin/meilisearch ${SOURCE_BINARY_BASEURL}/${MEILISEARCH_VERSION}/meilisearch-linux-${ARCH} && \

RUN if [ "${ARCH}" = "arm64" ] ; then curl -L -v -o /home/meilisearch/bin/meilisearch ${SOURCE_BINARY_BASEURL}/${MEILISEARCH_VERSION}/meilisearch-linux-armv8; ls -l /home/meilisearch/bin/meilisearch; /usr/bin/aarch64-linux-gnu-strip --strip-debug --target=elf64-littleaarch64 /home/meilisearch/bin/meilisearch; fi

RUN if [ "${ARCH}" = "amd64" ] ; then curl -L -v -o /home/meilisearch/bin/meilisearch ${SOURCE_BINARY_BASEURL}/${MEILISEARCH_VERSION}/meilisearch-linux-amd64; ls -l /home/meilisearch/bin/meilisearch; /usr/bin/strip --strip-debug /home/meilisearch/bin/meilisearch; fi

RUN set -eux && chmod 755 /home/meilisearch/bin/meilisearch

USER root
RUN apt-get -y purge binutils binutils-aarch64-linux-gnu binutils-multiarch

USER meilisearch
VOLUME /data.ms
WORKDIR /data.ms

ENV     MEILI_HTTP_ADDR 0.0.0.0:7700
EXPOSE  7700/tcp

ENTRYPOINT ["tini", "--"]
CMD     /home/meilisearch/bin/meilisearch
