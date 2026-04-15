#!/usr/bin/env bash

set -eux -o pipefail

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"

# Zsh
## Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 
sudo chsh -s "$(which zsh)" "$(whoami)"

rm -f "$HOME/.zshrc"
ln -s .dotfiles/.zshrc "$HOME/.zshrc"

source "$HOME/.zshrc"

git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autocomplete"

## Starship
curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir ~/.local/bin
starship preset gruvbox-rainbow -o ~/.config/starship.toml

# Git
git config --global user.name "Dan O'Brien"
git config --global user.email "dob9601@github.com"
git config --global core.editor vim
