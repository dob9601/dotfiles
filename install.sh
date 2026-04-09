#!/usr/bin/env bash

set -eux -o pipefail

mkdir -p "$HOME/.config"

# Zsh
## Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 
sudo chsh -s "$(which zsh)" "$(whoami)"

rm -f ~/.zshrc
ln -s ./.zshrc "$HOME/.zshrc"

## Starship
curl -sS https://starship.rs/install.sh | sh -s -- --yes
starship preset gruvbox-rainbow -o ~/.config/starship.toml

# Git
git config --global user.name "Dan O'Brien"
git config --global user.email "dob9601@github.com"
git config --global core.editor vim
