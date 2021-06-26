# TypeScript DevContainer Workspace

## Environment 

- [Starship](https://starship.rs/) The minimal, blazing-fast, and infinitely customizable prompt for any shell!
- [NVM](https://github.com/nvm-sh/nvm) with [Node LTS](https://nodejs.dev/) installed by default. NVM is a version manager for Node.js
- [Vim](https://www.vim.org/) Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient.

## Essential

- Git
- Curl, Wget

## How to use this Workspace

In your project, create `.devcontainer/devcontainer.json` : 

``` json
// For format details, see https://aka.ms/devcontainer.json.
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

  // See https://aka.ms/vscode-remote/samples/docker-from-docker.
  "mounts": [ "source=/var/run/docker.sock,target=/var/run/docker.sock,type=bind" ]  
}
```
