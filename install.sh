#!/usr/bin/env bash

function usage() {
	echo "sudo $0 [options]"
	echo
	echo "Options:"
	echo "    --user, -u"
	echo "        Sets the user that this installer should run for. Defaults to the"
	echo "        user identified by invoking \`logname\`."
	echo
	echo "    --group, -g"
	echo "        Sets the user's primary group. Mostly used for properly setting"
	echo "        file ownership. If not specified, will assume it should be the"
	echo "        same as the \`--user\` option."
	echo
	echo "    --confirm, -y"
	echo "        Do not prompt for input or confirmations."
	echo
	echo "    --home-dir"
	echo "        Sets the path to the user's home directory. Defaults to"
	echo "        '/home/USER' where 'USER' is the value of the \`--user\` option."
	echo
	echo "    --help, -h"
	echo "        Prints this usage message."
}

user_name="$(logname)"
user_group=""
home_dir=""
no_interact=""

while [[ $# > 0 ]]; do
	item="$1"
	shift

	case "$item" in
		--user|-u)
			user_name="$1"
			shift

			;;

		--group|-g)
			user_group="$1"
			shift

			;;

		--confirm|-y)
			no_interact="no_interact"

			;;

		--home-dir)
			home_dir="$1"
			shift

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

if [[ -z "$home_dir" ]]; then
	home_dir="/home/$user_name"
fi

if [[ -z "$no_interact" ]]; then
	echo "Installing software and configurations for the following user:"
	echo "  Name: ${user_name}"
	echo "  Primary Group: ${user_group}"
	echo "  Home Directory: ${home_dir}"
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

apt install -y neovim fish discord alacritty exa gh slack-desktop
flatpack install --non-interactive spotify

# Install pip and python packages
curl -s https://bootstrap.pypa.io/get-pip.py | python3
pip install gdown

# Install and build Git libsecret auth
apt install -y libsecret-1-0 libsecret-1-dev
make -C /usr/share/doc/git/contrib/credential/libsecret

# Install rust-lang + tools
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -yq --no-modify-path

mkdir -p ~/.local/bin
curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer

~/.cargo/bin/cargo install proximity-sort

runuser -u "$user_name" -c './do_configs.sh'
runuser -u "$user_name" -c './do_assets.sh'

# Enable pop-shell tiling mode
dconf write /org/gnome/mutter/edge-tiling false
dconf write /org/gnome/shell/extensions/pop-shell/tile-by-default true
killall -SIGQUIT gnome-shell
