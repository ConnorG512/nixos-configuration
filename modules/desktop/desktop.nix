{ config, lib, pkgs, ... }:

{
  imports = [
    ./de/kde.nix
    ./wm/niri.nix
  ];
}
