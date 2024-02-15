#!/bin/sh

# Install NeoVim and dependencies
cd ~
sudo apt update -y
sudo apt install -y build-essential wget jq fuse make grep ripgrep cmake nodejs clangd 
API_URL="https://api.github.com/repos/neovim/neovim/releases/latest"
APPIMAGE_URL=$(wget -qO- "$API_URL" | jq -r '.assets[] | select(.name | endswith("nvim.appimage")) | .browser_download_url')
wget --quiet "$APPIMAGE_URL" --output-document nvim
chmod +x nvim
sudo chown root:root nvim
sudo mv nvim /usr/bin
mkdir -p .config/nvim

# Check if WSL and map config
if uname -a | grep -qi 'microsoft'; then
    echo "Running under Windows Subsystem for Linux (WSL)"
    # Map config to windows one 
    mkdir -p ~/.config
    WIN_USER=$(cmd.exe /C "echo %USERNAME%" | tr -d '\r')
    if [ -d "/mnt/c/Users/$WIN_USER/AppData/Local/nvim" ]; then
        ln -s "/mnt/c/Users/$WIN_USER/AppData/Local/nvim" ~/.config/nvim
        echo "Neovim configuration linked to Windows user $WIN_USER."
    else
        echo "Windows Neovim configuration directory not found for user $WIN_USER."
    fi
fi

