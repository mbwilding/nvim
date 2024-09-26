#!/usr/bin/env bash

if uname -a | grep -qi 'microsoft'; then
    echo "Running under Windows Subsystem for Linux (WSL)"
    mkdir -p $HOME/.config
    WIN_USER=$(cmd.exe /C "echo %USERNAME%" | tr -d '\r')
    if [ -d "/mnt/c/Users/$WIN_USER/AppData/Local/nvim" ]; then
        ln -s "/mnt/c/Users/$WIN_USER/AppData/Local/nvim/" $HOME/.config/nvim
        echo "Neovim configuration linked to Windows user $WIN_USER."
    else
        echo "Windows Neovim configuration directory not found for user $WIN_USER."
    fi
fi

