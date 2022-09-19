#!/usr/bin/env bash

source ./functions.sh

log_start_region "Installing configs..."

# Simple / single file configurations
cp configs/.pam_environment "$HOME/.pam_environment"
log_region_item "./configs/.pam_environment => $HOME/.pam_environment"

# Full config dirs, that should be placed in $HOME/.config as-is
config_names=(alacritty fish git gh nvim)
config_dir="${XDG_DATA_HOME:-$HOME/.config}"

for name in "${config_names[@]}"
do
	destination="${config_dir}/${name}"
	log_region_item "./configs/$name => $destination"

	if [[ -e "$destination" ]]; then
		rm -rf "$destination"
	fi

	cp -r "./configs/${name}" "$destination"

	if [[ -e "./scripts/$name/install.sh" ]]; then
		source "./scripts/$name/install.sh"
	fi
done

log_end_region "Done"'!'
