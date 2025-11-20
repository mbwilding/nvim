set -eax

# Packages
pkg update
pkg upgrade -y
pkg install -y wget

# Font
mkdir ~/.termux
wget -O ~/.termux/font.ttf https://github.com/mbwilding/NeoSpleen/releases/latest/download/NeoSpleenNerdFont-Regular.ttf
