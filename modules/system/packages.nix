{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
  vim
  mesa
  lsof
  vulkan-tools
  waybar
  alacritty
  feh
  xdg-desktop-portal-hyprland
  hyprpolkitagent
  tofi
  pwvucontrol
  hyprpaper
  hyprlock
  hyprcursor
  fuse3
  hdparm
  grim 
  slurp 
  openssl
  curl
  exfat
  exfatprogs
  file
  fileinfo
  man
  man-pages
  man-pages-posix
  nil
  patchelfUnstable
  goverlay
  radeontop
  cloc

  # Custom flake
  ];
}
