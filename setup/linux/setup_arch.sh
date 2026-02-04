#!/usr/bin/env bash

set -e

shared="$(dirname "$(readlink -f "$0")")/../shared"

paru -Sy --noconfirm --skipreview --needed \
    imagemagick powershell-preview-bin bun neovim-git openssh gnupg wget jq fuse make grep ripgrep cmake unzip go python3 ruby rustup nodejs clang luarocks tree-sitter-cli \
    zls vue-language-server taplo-cli sqls pyright vscode-css-languageserver vscode-html-languageserver vscode-json-languageserver gopls dockerfile-language-server lua-language-server bash-language-server powershell-editor-services lemminx tailwindcss-language-server yaml-language-server marksman roslyn-ls ada_language_server-bin phpactor-bin \
    netcoredbg delve python-debugpy codelldb-bin vscode-js-debug-bin vscode-bash-debug bashdb \
    ruff eslint_d prettierd yamllint python-cfn-lint markdownlint-cli2 php-cs-fixer

rustup default stable
rustup component add rust-analyzer
rustup update

go install golang.org/x/tools/cmd/goimports@latest &
bun install --global @typescript/native-preview &

wait
