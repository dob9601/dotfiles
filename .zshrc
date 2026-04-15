alias grep='grep --color=auto'
alias ls='ls --color=auto'

export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"

plugins=(
    git
    zsh-autosuggestions
    zsh-autocomplete
)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
