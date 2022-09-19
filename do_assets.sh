#!/usr/bin/env bash

gdrive_share_url="https://drive.google.com/drive/folders/1Tmx7iXV36TXwQKphwpwZU765r4WpefE2?usp=sharing"
assets_dir=(mktemp -d)"/assets"

gdown "$gdrive_share_url" -O "$assets_dir" --folder

mkdir -p "$HOME/Pictures"
mv "$assets_dir/profile.jpg" "$HOME/Pictures/profile.jpg"
mv -r "$assets_dir/backgrounds" "$HOME/Pictures/Backgrounds"

mkdir -p "$HOME/.local/bin"
cp ./configs/systemd/rotate-background.sh "$HOME/.local/bin"

mkdir -p "$HOME/.config/systemd/user"
cp ./configs/systemd/rotate-background.{service, timer} "$HOME/.config/systemd/user"
systemctl --user daemon-reload
systemctl --user enable rotate-background.timer
systemctl --user start rotate-background.timer

rm -rf "$assets_dir"
