if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end
fundle plugin 'edc/bass'
fundle plugin 'franciscolourenco/done'
fundle plugin 'jethrokuan/z'
fundle plugin 'IlanCosman/tide@v5'
fundle init

alias vim='nvim'
# alias cat='bat'
alias ls='exa --long --header'
alias ssh='kitty +kitten ssh'
alias cat='bat'
export GPG_TTY=(tty)
export VIRTUAL_ENV_DISABLE_PROMPT=1

bass source ~/repos/git-subrepo/.rc


# function fish_prompt
#     powerline-shell --shell bare $status
# end
#
#function fish_greeting
    #neofetch --separator '\t'
#end

set -g theme_color_scheme nord
set -g theme_title_display_process no

# function fish_title
#     set -q argv[1]; or set argv fish
#     echo (fish_prompt_pwd_dir_length=1 prompt_pwd): $argv;
# end

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

function vmux
    ssh -At $argv '/bin/bash -ic "abduco -e \'^g\' -A nvim-session ~/Applications/nvim-linux64/bin/nvim"'
end

thefuck --alias | source
