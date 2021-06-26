# TypeScript DevContainer Workspace

[![GitHub stars](https://img.shields.io/github/stars/Ealenn/codespaces-typescript?style=for-the-badge)](https://github.com/Ealenn/codespaces-typescript/stargazers)
![Docker Image Version (latest semver)](https://img.shields.io/docker/v/ealen/codespaces-typescript?sort=semver&style=for-the-badge)
![Docker Pulls](https://img.shields.io/docker/pulls/ealen/codespaces-typescript?style=for-the-badge)

The Visual [Studio Code Remote Containers extension](https://code.visualstudio.com/docs/remote/containers) lets you use a Docker container as a full-featured development environment. It allows you to open any folder inside (or mounted into) a container and take advantage of Visual Studio Code's full feature set. 

A `devcontainer.json` file in your project tells VS Code how to access a development container with a well-defined tool and runtime stack. This container can be used to run an application or to separate tools, libraries, or runtimes needed for working with a codebase.

[More information](https://code.visualstudio.com/docs/remote/containers)

## Table of contents

- [TypeScript DevContainer Workspace](#typescript-devcontainer-workspace)
  - [Table of contents](#table-of-contents)
- [Dev-Container](#dev-container)
  - [Environment](#environment)
  - [Essential](#essential)
  - [Others](#others)
- [How to use](#how-to-use)

# Dev-Container

## Environment 

- [ZSH](https://www.zsh.org/) & [Oh-My-ZSH](https://github.com/ohmyzsh/ohmyzsh) Zsh is a shell designed for interactive use, although it is also a powerful scripting language.
- [Starship](https://starship.rs/) The minimal, blazing-fast, and infinitely customizable prompt for any shell!
- [NVM](https://github.com/nvm-sh/nvm) with [Node LTS](https://nodejs.dev/) installed by default. NVM is a version manager for NodeJS.
- [Vim](https://www.vim.org/) Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient.
- [Docker](https://www.docker.com/) & [Docker-Compose](https://docs.docker.com/compose/) Lets you run Docker within Docker.

## Essential

- [Git](https://git-scm.com/) Git is a free and open source distributed version control system.
- [Curl](https://curl.se/) Command line tool for transferring data with URLs.
- [Wget](https://www.gnu.org/software/wget/) GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.

## Others

- [ca-certificates](https://packages.debian.org/en/sid/ca-certificates) Contains the certificate authorities shipped with Mozilla's browser to allow SSL-based applications to check for the authenticity of SSL connections.
- [gnupg](https://packages.debian.org/en/sid/gnupg) GnuPG is GNU's tool for secure communication and data storage.

# How to use

In your project, create `.devcontainer/devcontainer.json` [[?]](https://aka.ms/devcontainer.json) : 

``` js
{
  "name": "TypeScript",
  "image": "ealen/codespaces-typescript",

  "extensions": [
    // TypeScript
    "dbaeumer.vscode-eslint",
    // Files
    "bungcip.better-toml",
    "yzhang.markdown-all-in-one",
    // Global
    "editorconfig.editorconfig",
    // Front
    "naumovs.color-highlight",
    // Theme
    "vscode-icons-team.vscode-icons",
    // Docker
    "ms-azuretools.vscode-docker",
    "ms-kubernetes-tools.vscode-kubernetes-tools"
  ],

  // Use 'forwardPorts' to make a list of ports inside the container available locally.
  // "forwardPorts": [],

  // Uncomment the next line to run commands after the container is created - for example installing curl.
  // "postCreateCommand": "npm ci",

  "mounts": [
    "source=/home/ealen/.ssh,target=/home/user/.ssh,type=bind,readonly",
    "source=/var/run/docker.sock,target=/var/run/docker.sock,type=bind" 
  ]
}
```
