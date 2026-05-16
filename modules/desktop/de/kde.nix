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

    useX11 = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Use KDE X11 session.";
      example = true;
    };
    
    loginManager = lib.mkOption {
      type = lib.types.enum [ "plasma" "sddm" ];
      default = "plasma";
      description = "Use KDE X11 session.";
      example = "plasma";
    };
  };
  
  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      services.desktopManager.plasma6 = {
        enable = true;
        enableQt5Integration = cfg.useQt5;
      };

      xdg.portal.enable = cfg.enable;
      services.xserver.enable = cfg.useX11;
    })

    (lib.mkIf (cfg.loginManager == "plasma"){
      services.displayManager.plasma-login-manager.enable = true;
    })
    (lib.mkIf (cfg.loginManager == "sddm"){
      services.displayManager.sddm.enable = true;
    })
  ];
}
