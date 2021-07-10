FROM ubuntu:20.04

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
RUN apt install sudo screen tzdata locales lsb-release -y

# APT
RUN apt install ca-certificates gnupg -y

# Essential
RUN apt install build-essential git curl wget vim -y

# Locale
RUN locale-gen $LOCAL && update-locale LANG=$LOCAL

# Bash | Starship
RUN apt install zsh -y
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN curl -fsSL https://starship.rs/install.sh | bash -s -- -y
RUN rm /bin/sh && ln -s /bin/zsh /bin/sh

# ------------------------------
# Docker
# ------------------------------
WORKDIR /usr/local/docker
# Install Docker CE CLI
RUN curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/gpg | apt-key add - 2>/dev/null \
    && echo "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list \
    && apt update \
    && apt install -y docker-ce-cli

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
# LSD
# ------------------------------
WORKDIR /usr/local/lsd
ENV LSD_VERSION 0.20.1
ADD https://github.com/Peltoche/lsd/releases/download/${LSD_VERSION}/lsd_${LSD_VERSION}_amd64.deb /usr/local/lsd/lsd.deb
RUN dpkg -i ./lsd.deb
RUN rm ./lsd.deb

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
RUN groupadd docker
RUN usermod -a -G docker $USER

# ------------------------------
# User Configuration
# ------------------------------
COPY home/ ${HOME}/
RUN chown -R ${PUID}:${PGID} $HOME
RUN chown -R ${PUID}:${PGID} /usr/local/nvm

# ------------------------------
# Ready
# ------------------------------
WORKDIR ${HOME}
USER ${USER}
