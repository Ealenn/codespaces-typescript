export LC_ALL=$LOCAL
export LANG=$LOCAL

export HISTSIZE=10000
export SAVEHIST=10000

export HISTFILE=~/.zsh_history
export EDITOR=vim

# Oh-My-ZSH
plugins=(git docker docker-compose node nvm npm)

# NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# LSD
alias ls='lsd -A'
alias ll='ls -lA'
alias lt='ls --tree'

# TheFuck
eval $(thefuck --alias)

# Starship
source ~/.profile
eval "$(starship init zsh)"
