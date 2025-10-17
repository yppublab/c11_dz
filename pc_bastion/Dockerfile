FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC

RUN apt-get update \
 && apt-get install -y \
    openssh-server \
    sudo \
    iproute2 \
    curl \
    nano \
    iputils-ping \
    python3 python3-venv python3-pip \
    tcpdump \
    dnsutils \
 && rm -rf /var/lib/apt/lists/*

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

 CMD ["/usr/local/bin/start.sh"]