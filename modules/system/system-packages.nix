{ config, lib, pkgs, ... }:

let
  cfg = config.systemConfiguration.sysPackages;

  wlPackages = with pkgs; [
    wlr-randr
    wl-clipboard
  ];
  x11Packages = with pkgs; [
    xrandr
  ];
in
{
  options.systemConfiguration.sysPackages = {
    displayType = lib.mkOption {
      type = lib.types.enum [ "x11" "wl" "both" ];
      default = "wl";
      description = "Whether to install system packages for x11 or wayland protocols";
    };

    installManPages = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to include the man pages in system configuration.";
    };

    installMangohudPackages = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to install mangohud / goverlay.";
    };

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "Extra system packages to provide.";
      example = with pkgs; [ mpv feh ];
    };
  };

  config = lib.mkMerge [
    # Wayland defaults:
    (lib.mkIf (cfg.displayType == "wl") {
      environment.systemPackages = wlPackages;
    })

    # X11 Defaults:
    (lib.mkIf (cfg.displayType == "x11") {
      environment.systemPackages = x11Packages;
    })

    (lib.mkIf (cfg.displayType == "both") {
      environment.systemPackages = x11Packages ++ wlPackages;
    })

    (lib.mkIf cfg.installManPages {
      environment.systemPackages = with pkgs; [
        man
        man-pages
        man-pages-posix
      ];
    })

    (lib.mkIf cfg.installMangohudPackages {
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
        su
        shadow
        nix-index
        sshfs
        rsync
        file
        fileinfo
        fzf
        fd
        ripgrep
        tree
        lsof
        stow
        audacious
        b3sum
        xeyes
        par2cmdline
        dex

        yazi
        ghostty
      ] ++ cfg.extraPackages;
    }
  ];
}
