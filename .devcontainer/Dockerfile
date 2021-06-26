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

# APT
RUN apt update && apt upgrade -y

# Essential
RUN apt install sudo screen tzdata locales lsb-release -y
# RUN apt install iputils-ping iproute2 dnsutils net-tools -y
RUN apt install build-essential git curl wget vim -y

# Locale
RUN locale-gen $LOCAL && update-locale LANG=$LOCAL

# Bash | Starship
RUN apt install zsh -y
RUN curl -fsSL https://starship.rs/install.sh | bash -s -- -y
RUN rm /bin/sh && ln -s /bin/zsh /bin/sh

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

# User Configuration
COPY home/ ${HOME}/
RUN chown -R ${PUID}:${PGID} $HOME

# ------------------------------
# Ready
# ------------------------------
WORKDIR ${HOME}
USER ${USER}
