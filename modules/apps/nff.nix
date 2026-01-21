{ config, pkgs, fastfetch, ... }:

{
  programs.fastfetch = {
    enable = true;
    logoSource = "auto";
    logoWidth = 65;
    logoHeight = 35;
  };
}
