#!/usr/bin/env bash

function usage() {
	echo "sudo $0 [options]"
	echo
	echo "Options:"
	echo "    --confirm, -y"
	echo "        Do not prompt for input or confirmations."
	echo
	echo "    --help, -h"
	echo "        Prints this usage message."
}

user_name="$(logname)"
no_interact=""

while [[ $# > 0 ]]; do
	item="$1"
	shift

	case "$item" in
		--confirm|-y)
			no_interact="no_interact"

			;;

		--help|-h)
			usage
			exit

			;;

		*)
			usage
			exit 1
	esac
done

if [[ `id -u` != 0 ]]; then
	echo "This script should be invoked by using \`sudo\`, as the user you wish to"
	echo "perform the installation for."
	echo

	usage
	exit 1
fi

if [[ -z "$user_group" ]]; then
	user_group="$user_name"
fi

if [[ -z "$no_interact" ]]; then
	echo "Installing software and configurations for the following user:"
	echo "  Name: ${user_name}"
	echo "  Primary Group: ${user_group}"
	echo
	read -p "Is this correct? (y/N) " -r

	if ! [[ "$REPLY" =~ ^[yY] ]]; then
		echo "Installation cancelled."
		echo

		exit
	fi
fi

# Set up any additional apt repositories we'll need
source ./do_repos.sh

apt update
apt upgrade -y
apt autoremove

apt install -y neovim fish discord alacritty exa gh slack-desktop nodejs tmux \
	spotify-client docker-ce docker-ce-cli containerd.io docker-buildx-plugin \
	docker-compose-plugin

# Configure NPM to install global packages to the user
mkdir "$HOME"/.npm-packages
npm config set prefix "$HOME"/.npm-packages

# Install global NPM packages
npm install --global yarn vscode-langservers-extracted

# Install pip and python packages
curl -s https://bootstrap.pypa.io/get-pip.py | python3
pip install gdown

# Install and build Git libsecret auth
apt install -y libsecret-1-0 libsecret-1-dev
make -C /usr/share/doc/git/contrib/credential/libsecret

# Install rust-lang + tools
runuser -u "$user_name" curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -yq --no-modify-path

runuser -u "$user_name" ~/.cargo/bin/rustup component add rust-analyzer
runuser -u "$user_name" ~/.cargo/bin/cargo install proximity-sort

runuser -u "$user_name" './do_configs.sh'
runuser -u "$user_name" './do_assets.sh'

# Enable pop-shell tiling mode
gsettings set org.gnome.mutter edge-tiling false

gsettings set org.gnome.shell.extensions.pop-shell tile-by-default true
gsettings set org.gnome.shell.extensions.pop-shell gap-inner 0
gsettings set org.gnome.shell.extensions.pop-shell gap-outer 0

# Finish editing Gnome settings
killall -SIGQUIT gnome-shell
