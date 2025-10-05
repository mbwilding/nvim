#!/usr/bin/env bash

set -e

shared="$(dirname "$(readlink -f "$0")")/../shared"

# HomeBrew
brew update
brew upgrade --force

brew install neovim --HEAD
brew tap oven-sh/bun
brew install lazygit fd gs imagemagick luarocks bun jq curl wget node python go ripgrep fzf rustup powershell llvm pipx

## Language Servers
brew install lua-language-server taplo python-lsp-server yaml-language-server tailwindcss-language-server bash-language-server zls gopls
go install github.com/sqls-server/sqls@latest
bun install --global @microsoft/compose-language-service
bun install --global dockerfile-language-server-nodejs
bun install --global vue-language-server
bun install --global @typescript/native-preview
# bun install --global @mistweaverco/kulala-ls
bun install --global vscode-langservers-extracted
    # - vscode-css-language-server
    # - vscode-eslint-language-server
    # - vscode-html-language-server
    # - vscode-json-language-server
    # - vscode-markdown-language-server
bash ${shared}/roslyn.sh
bash ${shared}/lemminx.sh
bash ${shared}/powershell_es.sh

## Linters
brew install actionlint eslint_d jsonlint markdownlint-cli yamllint pylint
go install golang.org/x/tools/cmd/goimports@latest

# Formatters
brew install prettierd isort
bun install --global xml-formatter black prettier shfmt clang-format

## DAP
pipx install debugpy
bash ${shared}/netcoredbg.sh
bash ${shared}/codelldb.sh
bash ${shared}/js-debug.sh

# Rust
rustup default stable
rustup component add rust-analyzer
