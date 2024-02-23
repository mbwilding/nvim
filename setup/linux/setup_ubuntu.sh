#!/bin/bash

# Install dependencies
sudo apt update -y
sudo curl -fsSL https://deb.nodesource.com/setup_20.x | bash
sudo apt-get install -y build-essential pkg-config libudev-dev nodejs wget jq fuse make grep ripgrep cmake nodejs clangd unzip golang-go python3 python3.10-venv python3-pip ruby libssl-dev dotnet-sdk-6.0 dotnet-sdk-7.0 dotnet-sdk-8.0

# NPM global
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
export PATH=~/.npm-global/bin:$PATH
source ~/.profile
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.profile
source ~/.profile

# Install extras
sudo pip install cfn-lint
sudo gem install cfn-nag
sudo npm install -g aws-azure-login

# Install Rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

