#!/usr/bin/env bash

font_path="$HOME/.local/share/fonts"
mkdir -p ${font_path}
pushd $HOME/.local/share/fonts
rm NeoSpleen*.ttf
wget "https://github.com/mbwilding/NeoSpleen/releases/latest/download/NeoSpleen-NerdFont.ttf"
popd
fc-cache -f
