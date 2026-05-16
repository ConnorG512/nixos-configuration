{ pkgs, config, lib, ... }:

let
  cfg = config.systemConfiguration.desktop.niri;
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

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      programs.niri = {
        enable = true;
        useNautilus = true;
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
        fuzzel
      ];
      
      programs.nautilus-open-any-terminal = {
        enable = true; 
        terminal = "alacritty";
      };
      
      services = {
        gvfs.enable = true;
        gnome = {
          gnome-keyring.enable = true;
          sushi.enable = true;
        };
      };

      xdg.portal = {
        enable = true;
      };
    })

    (lib.mkIf cfg.enableSatellite {
      environment.systemPackages = with pkgs; [
        xwayland-satellite
      ];
    })
  ];
}
