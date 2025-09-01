#!/usr/bin/env bash

set -eux -o pipefail

# Helix
# export HELIX_VERSION="25.01.1"
# export HELIX_CONFIG_DIR="$HOME/.config/helix"

# curl -sL -o /tmp/helix.tar.xz https://github.com/helix-editor/helix/releases/download/${HELIX_VERSION}/helix-${HELIX_VERSION}-x86_64-linux.tar.xz

# mkdir -p $HELIX_CONFIG_DIR

# mkdir - /tmp/helix
# tar -xvf /tmp/helix.tar.xz -C /tmp/helix --strip-components=1

# mv /tmp/helix/runtime $HELIX_CONFIG_DIR/runtime
# mv /tmp/helix /usr/local/bin/hx

# ln -s ./helix/config.toml $HELIX_CONFIG_DIR
# ln -s ./helix/languages.toml $HELIX_CONFIG_DIR

# Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
chsh -s $(which zsh)

ln -s ./.zshrc "$HOME/.zshrc"

# Git
ln -s ./.gitconfig "$HOME/.gitconfig"
