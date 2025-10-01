{ config, pkgs, ...}:
  
{
  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = { };
  };
}
