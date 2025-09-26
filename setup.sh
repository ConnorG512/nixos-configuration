#!/bin/sh

# Fail if error.
set -e

echo "Creating .config directory in home..."
mkdir -p "$HOME/.config"

echo "Copying dotfiles to .config..."
cp -rv "dotfiles/.config/alacritty" "$HOME/.config/"
cp -rv "dotfiles/.config/fastfetch" "$HOME/.config/"
cp -rv "dotfiles/.config/hypr" "$HOME/.config/"
cp -rv "dotfiles/.config/tofi" "$HOME/.config/"
cp -rv "dotfiles/.config/waybar" "$HOME/.config/"

echo "Moving hardware-configuration.nix to modules directory..."
cp -v "/etc/nixos/hardware-configuration.nix" ./modules/ 

echo "Creating system..."
sudo nixos-rebuild boot --flake .

echo "Done, reccomended to restart the computer."
