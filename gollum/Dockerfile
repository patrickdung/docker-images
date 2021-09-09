# User has to run/provide their git repo
# when the container is run

ARG BASE_IMAGE="docker.io/ruby:3.0-slim-bullseye"

FROM ${BASE_IMAGE}

ARG GOLLUM_VERSION="5.2.3"

ARG GIT_BRANCH_NAME="main"

RUN set -eux && \
    apt-get -y update && \
    apt-get -y install --no-install-suggests \
    libicu-dev cmake make gcc g++ pkg-config git git-man bash vim docutils python3-pygments sed libjemalloc2 && \
    rm -rf /var/lib/apt/lists/*

# 1) https://github.com/gollum/docker/issues/2
# gem install --no-document therubyracer
# 2) Seems pygments is not effective
# 3) not installing because it seems need to update the santizer to use it
# gem install pygments.rb

RUN set -eux && \
    gem install --no-document asciidoctor && \
    gem install --no-document gollum -v ${GOLLUM_VERSION} && \
    apt-get -y purge libicu-dev cmake cmake-data make gcc g++ linux-libc-dev \
    libc6-dev libssl-dev zlib1g-dev libffi-dev libgmp-dev libyaml-dev && \
    apt-get -y autoremove && apt-get -y clean && \
# Don't use git repo as home directoy \
    addgroup \
      --gid 1000 \
      wiki && \
    adduser \
      --shell /bin/bash \
      --uid 1000 \
      --gid 1000 \
      --disabled-password \
      wiki && \
    mkdir -p /wiki && \
    chown wiki:wiki /wiki

USER 1000:1000

VOLUME /wiki

WORKDIR /wiki

ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2
ENV GIT_BRANCH_NAME ${GIT_BRANCH_NAME}

# Not using home directory as wiki repo
# gollum assume default branch is main

#ENTRYPOINT ["gollum"]
ENTRYPOINT gollum /wiki --ref ${GIT_BRANCH_NAME}

EXPOSE 4567
