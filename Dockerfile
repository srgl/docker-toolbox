FROM debian:8

MAINTAINER Tobias Munk <tobias@diemeisterei.de>

# Install system packages
RUN apt-get update && \
    apt-get -y install \
            curl \
            ca-certificates \
            expect \
            make \
            nano \
            openssh-client \
            sshpass \
            unzip \
        --no-install-recommends && \
    rm -r /var/lib/apt/lists/* # 151110

RUN mkdir -p /opt/local/bin

# Docker client
RUN curl -L https://get.docker.com/builds/Linux/x86_64/docker-1.12.1.tgz > /tmp/docker-1.12.1.tgz && \
    cd /tmp && tar -xzf ./docker-1.12.1.tgz && \
    rm /tmp/docker-1.12.1.tgz && \
    mv /tmp/docker/docker /opt/local/bin/docker-1.12.1 && \
    chmod +x /opt/local/bin/docker-1.12.1

# Docker machine
RUN curl -L https://github.com/docker/machine/releases/download/v0.8.1/docker-machine-`uname -s`-`uname -m` >/opt/local/bin/docker-machine-0.8.1 && \
    chmod +x /opt/local/bin/docker-machine-0.8.1

# Docker compose
RUN curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /opt/local/bin/docker-compose-1.7.1 && \
    chmod +x /opt/local/bin/docker-compose-1.7.1

ENV PATH=/opt/local/bin:$PATH

RUN ln -s /opt/local/bin/docker-1.12.1 /opt/local/bin/docker
RUN ln -s /opt/local/bin/docker-machine-0.8.1 /opt/local/bin/docker-machine
RUN ln -s /opt/local/bin/docker-compose-1.7.1 /opt/local/bin/docker-compose

