alias vim='nvim'
alias cat='bat'
alias ls='exa --long --header --git'
alias ssh='kitty +kitten ssh'
export GPG_TTY=(tty)
export VIRTUAL_ENV_DISABLE_PROMPT=1

__fish_complete_django django-admin.py
__fish_complete_django manage.py

# function fish_prompt
#     powerline-shell --shell bare $status
# end
#
function fish_greeting
    neofetch --separator '\t'
end

function fish_title
    set -q argv[1]; or set argv fish
    echo (fish_prompt_pwd_dir_length=1 prompt_pwd): $argv;
end
