#!/usr/bin/env bash

set -e

shared="$(dirname "$(readlink -f "$0")")/../shared"

paru -Sy --noconfirm --skipreview --needed \
    powershell-bin bun-bin neovim-nightly-bin openssh gnupg wget jq fuse make grep ripgrep cmake unzip go python3 ruby rustup nodejs clang luarocks tree-sitter-cli \
    ruff zls vue-language-server taplo-cli sqls pyright vscode-css-languageserver vscode-html-languageserver vscode-json-languageserver gopls dockerfile-language-server lua-language-server bash-language-server powershell-editor-services lemminx tailwindcss-language-server yaml-language-server marksman roslyn-ls \
    netcoredbg delve python-debugpy codelldb-bin vscode-js-debug-bin \
    eslint_d prettierd yamllint python-cfn-lint \
    markdownlint-cli2

rustup default stable
rustup component add rust-analyzer

go install golang.org/x/tools/cmd/goimports@latest &

bun install --global @typescript/native-preview &

wait
