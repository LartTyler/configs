#!/usr/bin/env bash

source ./functions.sh
check_sane

# Neovim PPA
add-apt-repository -yn ppa:neovim-ppa/stable

# Github CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# Node
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
