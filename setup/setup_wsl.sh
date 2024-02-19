#!/bin/sh

# Install NeoVim and dependencies
cd ~
sudo apt update -y
sudo curl -fsSL https://deb.nodesource.com/setup_20.x | bash
sudo apt-get install -y build-essential nodejs wget jq fuse make grep ripgrep cmake nodejs clangd unzip golang-go python3 python3.10-venv ruby

sudo pip install cfn-lint
sudo gem install cfn-nag

API_URL="https://api.github.com/repos/neovim/neovim/releases/latest"
APPIMAGE_URL=$(wget -qO- "$API_URL" | jq -r '.assets[] | select(.name | endswith("nvim.appimage")) | .browser_download_url')
wget --quiet "$APPIMAGE_URL" --output-document nvim
chmod +x nvim
sudo chown root:root nvim
sudo mv nvim /usr/bin

# Check if WSL and map config
if uname -a | grep -qi 'microsoft'; then
    echo "Running under Windows Subsystem for Linux (WSL)"
    # Map config to windows one 
    mkdir -p ~/.config
    WIN_USER=$(cmd.exe /C "echo %USERNAME%" | tr -d '\r')
    if [ -d "/mnt/c/Users/$WIN_USER/AppData/Local/nvim" ]; then
        ln -s "/mnt/c/Users/$WIN_USER/AppData/Local/nvim/" ~/.config/nvim
        echo "Neovim configuration linked to Windows user $WIN_USER."
    else
        echo "Windows Neovim configuration directory not found for user $WIN_USER."
    fi
fi

# Install Rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

