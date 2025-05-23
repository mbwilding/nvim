#!/usr/bin/env bash

# Update
sudo pacman -Syu --noconfirm

# Install Yay
# sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin && cd /tmp/yay-bin && makepkg -si

# Install Dependencies
paru -S --noconfirm bun-bin neovim openssh gnupg wget jq fuse make grep ripgrep cmake unzip go python3 ruby rustup nodejs clang

rustup default stable
rustup component add rust-analyzer

# Language Servers
paru -S --noconfirm zls vue-language-server taplo-cli sqls python-lsp-server vscode-css-languageserver vscode-html-languageserver vscode-json-languageserver gopls dockerfile-language-server lua-language-server bash-language-server powershell-editor-services lemminx tailwindcss-language-server yaml-language-server lua-language-server
shared="$(dirname "$(readlink -f "$0")")/../shared"
bash ${shared}/roslyn.sh

# Linters
paru -S --noconfirm eslint_d prettierd python-pylint yamllint
go install golang.org/x/tools/cmd/goimports@latest

# eslint-languageserver vscode-markdown-languageserver dockercompose-language-server azure-pipelines-language-server
# TODO: Install dotnet packages from Yay

# sudo curl -fsSL https://deb.nodesource.com/setup_20.x | bash
# sudo apt-get install -y build-essential pkg-config libudev-dev nodejs wget jq fuse make grep ripgrep cmake nodejs clangd unzip golang-go python3 python3.10-venv python3-pip ruby libssl-dev dotnet-sdk-6.0 dotnet-sdk-7.0 dotnet-sdk-8.0

# mkdir $HOME/.npm-global
# npm config set prefix $HOME/.npm-global
# export PATH=$HOME/.npm-global/bin:$PATH
# source $HOME/.profile
# echo 'export PATH=~/.npm-global/bin:$PATH' >> $HOME/.profile
# source $HOME/.profile

# sudo pip install cfn-lint
# sudo gem install cfn-nag
# sudo npm install --global aws-azure-login
