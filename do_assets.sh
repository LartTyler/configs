#!/usr/bin/env bash

download_assets="download_assets"

while [[ $# > 0 ]]; do
	key="$1"
	shift

	case "$key" in
		--skip-download)
			download_assets=""

			;;

		-h|--help)
			echo "./$0 [options]"
			echo
			echo "--skip-download"
			echo "    Skip downloading assets from Google Drive; assumes files"
			echo "    exist in \$HOME/Pictures"
			echo
			echo "-h, --help"
			echo "    Prints this message"

			exit

			;;
	esac
done

if [ -n "$download_assets" ]; then
	gdrive_share_url="https://drive.google.com/drive/folders/1Tmx7iXV36TXwQKphwpwZU765r4WpefE2?usp=sharing"
	assets_dir="$(mktemp -d)/assets"

	if ! [ -x "$(command -v gdown)" ]; then
		echo "Missing gdown command; run do_install.sh"
		exit 1
	fi

	gdown "$gdrive_share_url" -O "$assets_dir" --folder

	mkdir -p "$HOME/Pictures"
	mv "$assets_dir/profile.jpg" "$HOME/Pictures/profile.jpg"
	mv "$assets_dir/backgrounds" "$HOME/Pictures/Backgrounds"

	rm -rf "$assets_dir"
fi

mkdir -p "$HOME/.local/bin"
cp ./configs/systemd/rotate-background.sh "$HOME/.local/bin"

mkdir -p "$HOME/.config/systemd/user"
cp ./configs/systemd/rotate-background.{service,timer} "$HOME/.config/systemd/user"
systemctl --user daemon-reload
systemctl --user enable rotate-background.timer
systemctl --user start rotate-background.timer
