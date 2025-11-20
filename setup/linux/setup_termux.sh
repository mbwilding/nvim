#!/usr/bin/env bash

set -e

shared="$(dirname "$(readlink -f "$0")")/../shared"

# paru -Sy --noconfirm --skipreview --needed \
#     powershell-bin bun-bin neovim-nightly-bin openssh gnupg wget jq fuse make grep ripgrep cmake unzip go python3 ruby rustup nodejs clang luarocks tree-sitter-cli \
#     zls vue-language-server taplo-cli sqls python-lsp-server vscode-css-languageserver vscode-html-languageserver vscode-json-languageserver gopls dockerfile-language-server lua-language-server bash-language-server powershell-editor-services lemminx tailwindcss-language-server yaml-language-server \
#     netcoredbg delve python-debugpy \
#     eslint_d prettierd python-pylint yamllint python-cfn-lint

pkg install -y rust rust-analyzer pacman patchelf

pacman-key --init
pacman-key --populate
pacman -Syu
pacman -Sy glibc-runner --assume-installed bash,patchelf

# curl -fsSL https://bun.sh/install | bash

# rustup default stable
# rustup component add rust-analyzer
# go install golang.org/x/tools/cmd/goimports@latest &
# bun install --global @typescript/native-preview &
# bash ${shared}/netcoredbg.sh &
# bash ${shared}/codelldb.sh &
# bash ${shared}/js-debug.sh &
# bash ${shared}/roslyn.sh &
# wait
