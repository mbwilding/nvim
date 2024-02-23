#!/bin/bash

nightly = 1

# Install Neovim
if [ "$nightly" -eq 1 ]; then
    API_URL="https://api.github.com/repos/neovim/neovim/releases/tags/nightly"
else
    API_URL="https://api.github.com/repos/neovim/neovim/releases/latest"
fi

APPIMAGE_URL=$(wget -qO- "$API_URL" | jq -r '.assets[] | select(.name | endswith("nvim.appimage")) | .browser_download_url')
wget --quiet "$APPIMAGE_URL" --output-document nvim
chmod +x nvim
sudo chown root:root nvim
sudo mv nvim /usr/bin

