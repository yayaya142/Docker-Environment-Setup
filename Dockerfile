FROM kalilinux/kali-rolling

# Base system tools
RUN apt update && apt install -y \
    apt-utils \
    gnupg \
    ca-certificates \
    && apt clean

# Networking utilities
RUN apt update && apt install -y \
    curl \
    wget \
    net-tools \
    iputils-ping \
    dnsutils \
    whois \
    traceroute \
    && apt clean

# Development tools
RUN apt update && apt install -y \
    build-essential \
    make \
    python3-pip \
    git \
    jq \
    unzip \
    nano \
    vim \
    && apt clean

# Pentest tools
RUN apt update && apt install -y \
    nmap \
    sqlmap \
    nikto \
    wpscan \
    hydra \
    zaproxy \
    metasploit-framework \
    sublist3r \
    amass \
    whatweb \
    && apt clean

WORKDIR /app
CMD ["/bin/bash"]
