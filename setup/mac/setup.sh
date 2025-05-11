#!/bin/bash

# HomeBrew
brew install neovim --HEAD
brew tap oven-sh/bun
brew install bun jq curl wget node python go ripgrep fzf rustup lua-language-server taplo python-lsp-server yaml-language-server tailwindcss-language-server powershell bash-language-server zls llvm gopls

# Go
go install github.com/sqls-server/sqls@latest

# NPM
bun install --global @microsoft/compose-language-service
bun install --global azure-pipelines-language-server
bun install --global dockerfile-language-server-nodejs
bun install --global vue-language-server
bun install --global vscode-langservers-extracted
# - vscode-css-language-server
# - vscode-eslint-language-server
# - vscode-html-language-server
# - vscode-json-language-server
# - vscode-markdown-language-server

# Rust
rustup default stable
rustup component add rust-analyzer

# Roslyn
shared="$(dirname "$(readlink -f "$0")")/../shared"
bash ${shared}/roslyn.sh
bash ${shared}/lemminx.sh
bash ${shared}/powershell_es.sh
