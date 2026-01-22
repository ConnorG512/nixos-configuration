{ config, pkgs, nff, ... }:

{
  programs.nff = {
    enable = true; 

    settings = {
      logo = {
        padding = {
          top = 4;
          left = 4;
          right = 4;
        };
      };
      modules = [
        "title"
        "separator"
        "title"
        "separator"
        "os"
        "separator"
      ];
    };
  };
}
