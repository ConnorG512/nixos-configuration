{ pkgs, config, lib, ... }:

let
  cfg = config.systemConfiguration.desktop;
in 
{
  options.systemConfiguration.desktop.niri = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the use of Niri";
      example = true;
    };
    
    enableSatellite = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Xwayland-Satellite";
      example = true;
    };
  };

  config = {
    programs.niri = {
      enable = cfg.niri.enable;
      useNautilus = cfg.niri.enable;
    };
    
    environment.systemPackages = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      
      hyprlock
      hyprpaper
      mako
      nautilus
      gsettings-desktop-schemas
      waybar
      alacritty
      grim
      slurp
      fuzzel
    ];

    (lib.mkIf cfg.niri.enableSatellite {
      environment.systemPackages = with pkgs; [
        xwayland-satellite
      ];
    })

    programs.nautilus-open-any-terminal = {
      enable = cfg.niri.enable; 
      terminal = "alacritty";
    };
    
    services = {
      gvfs.enable = cfg.niri.enable;
      gnome = {
        gnome-keyring.enable = cfg.niri.enable;
        sushi.enable = cfg.niri.enable;
      };
    };

    xdg.portal = {
      enable = cfg.niri.enable;
    };
  };
}
