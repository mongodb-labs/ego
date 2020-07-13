FROM ubuntu:20.04

RUN apt-get update -y && apt-get install -y \
    apt-utils \
    curl \
    netcat \
    ssh \
    && rm -rf /var/lib/apt/lists/*

COPY bin/ego /
ENTRYPOINT ["/ego"]
