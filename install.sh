#!/usr/bin/env bash

set -eux -o pipefail

export HELIX_VERSION="25.01.1"
export HELIX_CONFIG_DIR="$HOME/.config/helix"

################# INSTALL HELIX #################
curl -sL -o /tmp/helix.tar.xz https://github.com/helix-editor/helix/releases/download/${HELIX_VERSION}/helix-${HELIX_VERSION}-x86_64-linux.tar.xz

mkdir -p $HELIX_CONFIG_DIR

mkdir /tmp/helix
tar -xvf /tmp/helix.tar.xz -C /tmp/helix --strip-components=1

mv /tmp/helix/runtime $HELIX_CONFIG_DIR/runtime
mv /tmp/helix /usr/local/bin/hx
#################################################

mv ./helix/config.toml $HELIX_CONFIG_DIR
mv ./helix/languages.toml $HELIX_CONFIG_DIR
