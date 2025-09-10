#!/usr/bin/env bash

set -e

shared="$(dirname "$(readlink -f "$0")")/../shared"

# Update
sudo pacman -Syu --noconfirm

# Install Dependencies
paru -S --noconfirm bun-bin neovim-git openssh gnupg wget jq fuse make grep ripgrep cmake unzip go python3 ruby rustup nodejs clang luarocks tree-sitter-cli

rustup default stable
rustup component add rust-analyzer

# Language Servers
paru -S --noconfirm zls vue-language-server taplo-cli sqls python-lsp-server vscode-css-languageserver vscode-html-languageserver vscode-json-languageserver gopls dockerfile-language-server lua-language-server bash-language-server powershell-editor-services lemminx tailwindcss-language-server yaml-language-server
bun install --global azure-pipelines-language-server
bun install --global @typescript/native-preview
bash ${shared}/roslyn.sh

# Linters
paru -S --noconfirm eslint_d prettierd python-pylint yamllint python-cfn-lint
go install golang.org/x/tools/cmd/goimports@latest

# DAP
paru -S --noconfirm netcoredbg delve python-debugpy
bash ${shared}/netcoredbg.sh
bash ${shared}/codelldb.sh
bash ${shared}/js-debug.sh

# eslint-languageserver vscode-markdown-languageserver dockercompose-language-server azure-pipelines-language-server
