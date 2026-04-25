{ config, lib, pkgs, ... }:

let
  cfg = config.systemConfiguration.desktop.kde;
in 
{
  options.systemConfiguration.desktop.kde = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable KDE";
      example = true;
    };

    useQt5 = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Qt5 intergration.";
      example = true;
    };
  };
  
  config = {
    services.desktopManager.plasma6 = {
      enable = cfg.enable;
      enableQt5Integration = cfg.useQt5;
    };
  };
}
