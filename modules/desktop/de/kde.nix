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
      description = "Choice of login manager.";
      example = "plasma";
    };

    oxygenTheme = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install Oxygen theme, icons, and sounds.";
      example = true;
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
    
    {
      environment.systemPackages = with pkgs; [
        kdePackages.plasma-vault
        kdePackages.kcalc
        kdePackages.partitionmanager
        kdePackages.elisa
        kdePackages.filelight
        kdePackages.kgpg
        kdePackages.kleopatra
      ] ++ lib.optionals cfg.oxygenTheme [ pkgs.kdePackages.oxygen pkgs.kdePackages.oxygen-icons pkgs.kdePackages.oxygen-sounds ];
    }
  ];
}
