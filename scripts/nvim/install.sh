#!/usr/bin/env bash

source ./functions.sh

log_region_subitem "Installing junegunn/vim-plug..."
sh -c 'curl -sfLo "$HOME"/.config/nvim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

log_region_subitem "Installing plugins..."
nvim --headless +PlugInstall +qa 1>/dev/null 2>&1
