export LC_ALL=$LOCAL
export LANG=$LOCAL

export HISTSIZE=10000
export SAVEHIST=10000

export HISTFILE=~/.zsh_history
export EDITOR=vim

# NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Starship
eval "$(starship init zsh)"
