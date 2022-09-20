#!/usr/bin/env bash

background_key="picture-uri"

if [[ `gsettings get org.gnome.desktop.interface color-scheme` = *"dark"* ]]; then
	background_key="picture-uri-dark"
fi

current_file_name=`gsettings get org.gnome.desktop.background "$background_key" | xargs basename`
backgrounds_dir="$HOME/Pictures/Backgrounds"

next_file_path=`fdfind -tf -ejpg -epng -E "$current_file_name" --search-path "$backgrounds_dir" | shuf -n1`

gsettings set org.gnome.desktop.background "$background_key" file://"$next_file_path"
