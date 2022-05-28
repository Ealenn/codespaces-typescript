FROM ubuntu:22.04

# ------------------------------
# Labels
# ------------------------------
LABEL maintainer="Rudy Marchandise"
LABEL github="https://github.com/Ealenn/codespaces-typescript"

# ------------------------------
# Configuration
# ------------------------------
ARG USER
ENV USER ${USER:-user}

ARG PUID
ENV PUID ${PUID:-1000}

ARG PGID
ENV PGID ${PGID:-1000}

ENV HOME /home/${USER}

ARG TZ
ENV TZ ${TZ:-Europe/Paris}

ARG LOCAL
ENV LOCAL ${LOCAL:-en_GB.UTF-8}

ENV DEBIAN_FRONTEND=noninteractive

# ------------------------------
# System
# ------------------------------
WORKDIR /root

# TimeZone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/timezone

RUN apt update && apt upgrade -y
RUN apt install sudo screen tzdata locales lsb-release software-properties-common -y

# APT
RUN apt install ca-certificates gnupg -y

# Essential
RUN apt install build-essential git curl wget vim jq -y

# Locale
RUN locale-gen $LOCAL && update-locale LANG=$LOCAL

# Bash | Starship
RUN apt install zsh -y
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN curl -sS https://starship.rs/install.sh | sh -s - --yes
RUN rm /bin/sh && ln -s /bin/zsh /bin/sh

# ------------------------------
# Python
# ------------------------------
RUN apt install python3-dev python3-pip python3-setuptools -y

# ------------------------------
# Docker
# ------------------------------
WORKDIR /usr/local/docker

# Install Docker
RUN apt install docker.io -y

# Install Docker Compose
RUN LATEST_COMPOSE_VERSION=$(curl -sSL "https://api.github.com/repos/docker/compose/releases/latest" | grep -o -P '(?<="tag_name": ").+(?=")') \
    && curl -sSL "https://github.com/docker/compose/releases/download/${LATEST_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# ------------------------------
# NodeJS - NVM
# ------------------------------
WORKDIR /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 
RUN source $NVM_DIR/nvm.sh \
    && nvm install --lts \
    && nvm alias default lts/* \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# ------------------------------
# NPM Global Packages
# ------------------------------
RUN [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
  && npm install --global gi-gitignore-generator zx \
  && npm cache clean --force

# ------------------------------
# LSD
# ------------------------------
WORKDIR /usr/local/lsd
ENV LSD_VERSION 0.20.1
ADD https://github.com/Peltoche/lsd/releases/download/${LSD_VERSION}/lsd_${LSD_VERSION}_amd64.deb /usr/local/lsd/lsd.deb
RUN dpkg -i ./lsd.deb
RUN rm ./lsd.deb

# ------------------------------
# TheFuck
# ------------------------------
RUN pip3 install thefuck

# ------------------------------
# User
# ------------------------------
WORKDIR ${HOME}
RUN useradd -u ${PUID} -U -d ${HOME} -s /bin/zsh ${USER} \
  && groupmod -o -g ${PUID} ${USER} \
  && usermod -o -u ${PGID} ${USER} \
  && usermod -aG sudo ${USER} \
  && echo ${USER}:${USER} | chpasswd \
  && echo root:root | chpasswd \
  && mkdir -p ${HOME} $HOME/.vim/backup -p $HOME/.vim/swap -p $HOME/.vim/undo

# ------------------------------
# User Permissions
# ------------------------------
RUN adduser $USER sudo
RUN addgroup --system docker \
  && adduser $USER docker \
  && newgrp docker
RUN addgroup wsl \
  && adduser $USER wsl \
  && newgrp wsl \
  && groupmod --gid 1001 wsl

# ------------------------------
# User Configuration
# ------------------------------
COPY home/ ${HOME}/
COPY etc /etc
RUN chown -R ${PUID}:${PGID} $HOME
RUN chown -R ${PUID}:${PGID} /usr/local/nvm

# ------------------------------
# Clean
# ------------------------------
RUN apt autoremove \
  && apt autoclean \
  && apt clean

# ------------------------------
# Ready
# ------------------------------
WORKDIR ${HOME}
USER ${USER}
