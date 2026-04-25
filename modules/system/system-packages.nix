{ config, lib, pkgs, ... }:

let
  cfg = config.systemConfiguration.sysPackages;
in 
{
  options.systemConfiguration.sysPackages = {
    displayType = lib.mkOption {
      type = lib.types.enum [ "x11" "wl" ];
      default = "wl";
      description = "Whether to install system packages for x11 or wayland protocols";
    };
  };

  config = lib.mkMerge [
    # Wayland defaults:
    (lib.mkIf (cfg.displayType == "wl"){
      environment.systemPackages = with pkgs; [
        wlrandr
        wl-clipboard
      ];
    })
    
    # X11 Defaults:
    (lib.mkIf (cfg.displayType == "x11"){
      environment.systemPackages = with pkgs; [
        xrandr
        xeyes
      ];
    })

    # Common: 
    {
      environment.systemPackages = with pkgs; [
        fuse3
        exfat
        fd
        su
        shadow
        nix-index
        exiftool
      ];
    }
  ];
}
