#!/usr/bin/env bash

sudo apt update -y
sudo curl -fsSL https://deb.nodesource.com/setup_20.x | bash
sudo apt-get install -y build-essential pkg-config libudev-dev nodejs wget jq fuse make grep ripgrep cmake nodejs clangd unzip golang-go python3 python3.10-venv python3-pip ruby libssl-dev dotnet-sdk-6.0 dotnet-sdk-7.0 dotnet-sdk-8.0

mkdir $HOME/.npm-global
npm config set prefix $HOME/.npm-global
export PATH=$HOME/.npm-global/bin:$PATH
source $HOME/.profile
echo 'export PATH=~/.npm-global/bin:$PATH' >> $HOME/.profile
source $HOME/.profile

sudo pip install cfn-lint
sudo gem install cfn-nag
sudo npm install -g aws-azure-login

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
