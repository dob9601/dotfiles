alias vim='nvim'
# alias cat='bat'
alias ls='exa --long --header'
alias ssh='kitty +kitten ssh'
alias cat='bat'
export GPG_TTY=(tty)
export VIRTUAL_ENV_DISABLE_PROMPT=1

set theme_color_scheme nord

# function fish_prompt
#     powerline-shell --shell bare $status
# end
#
#function fish_greeting
    #neofetch --separator '\t'
#end

function fish_title
    set -q argv[1]; or set argv fish
    echo (fish_prompt_pwd_dir_length=1 prompt_pwd): $argv;
end

export PATH="$HOME/.cargo/bin:$PATH"
