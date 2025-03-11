#!/bin/bash
set -e

# Get version from argument
VERSION=$1

# Clone repository
git clone https://github.com/alacritty/alacritty.git
cd alacritty
git checkout $VERSION

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
# Ref: https://github.com/alacritty/alacritty/blob/master/INSTALL.md#building
cargo build --release
