alias grep='grep --color=auto'
alias ls='ls --color=auto'

export ZSH="$HOME/.oh-my-zsh"

plugins=(git)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
