#!/usr/bin/env bash

set -e

shared="$(dirname "$(readlink -f "$0")")/../shared"

# HomeBrew
brew install neovim --HEAD
brew tap oven-sh/bun
brew install bun jq curl wget node python go ripgrep fzf rustup powershell llvm

## Language Servers
brew install lua-language-server taplo python-lsp-server yaml-language-server tailwindcss-language-server bash-language-server zls gopls
bash ${shared}/roslyn.sh
bash ${shared}/lemminx.sh
bash ${shared}/powershell_es.sh

## Linters
brew install actionlint clang-format eslint_d jsonlint markdownlint-cli prettierd shfmt yamllint goimports pylint

## DAP
brew install delve
pip install debugpy
bash ${shared}/netcoredbg.sh

# Go
go install github.com/sqls-server/sqls@latest

# NPM
bun install --global @microsoft/compose-language-service
bun install --global azure-pipelines-language-server
bun install --global dockerfile-language-server-nodejs
bun install --global vue-language-server
bun install --global xml-formatter
bun install --global vscode-langservers-extracted
# - vscode-css-language-server
# - vscode-eslint-language-server
# - vscode-html-language-server
# - vscode-json-language-server
# - vscode-markdown-language-server

# Rust
rustup default stable
rustup component add rust-analyzer
