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

    installManPages = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to include the man pages in system configuration.";
    };

    installWinePackages = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Install wine / dxvk / vkd3d packages and utils.";
    };

    installMangohudPackages = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to install mangohud / goverlay.";
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
    
    (lib.mkIf cfg.installManPages{
      environment.systemPackages = with pkgs; [
        man
        man-pages
        man-pages-posix
      ];
    })
    
    (lib.mkIf cfg.installWinePackages{
      environment.systemPackages = with pkgs; [
        dxvk
        vkd3d-proton
        wineWow64Packages.waylandFull
        winetricks
      ];
    })
    
    (lib.mkIf cfg.installMangohudPackages{
      environment.systemPackages = with pkgs; [
        mangohud
        goverlay
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
        sshfs
        tmux
        lsof
        file
        fileinfo
        openssl
        curl
        btop
        tree
        inetutils
        lf
        fzf
        ripgrep
        keepassxc
      ];
    }
  ];
}
