#!/bin/bash
set -e

# fetch latest version
LATEST_VERSION=$(curl -s https://api.github.com/repos/alacritty/alacritty/releases/latest | grep tag_name | cut -d '"' -f 4)

# Clone repository
git clone https://github.com/alacritty/alacritty.git
cd alacritty
git checkout $LATEST_VERSION

# Install dependencies
# Ref: https://github.com/alacritty/alacritty/blob/master/INSTALL.md#debianubuntu
apt-get update
apt-get install -y cmake g++ pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
rustup override set stable
rustup update stable

# Build
cargo build --release

# output
cd ..
echo "$LATEST_VERSION" > version.txt