{ config, lib, pkgs, ... }:

let
  cfg = config.systemConfiguration.sysPackages;
in
{
  options.systemConfiguration.sysPackages = {
    displayType = lib.mkOption {
      type = lib.types.enum [ "x11" "wl" "both" ];
      default = "wl";
      description = "Whether to install system packages for x11 or wayland protocols";
    };

    installModernUnixTools = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable modern Unix alternatvies.";
      example = with pkgs; [ mpv feh ];
    };

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "Extra system packages to provide.";
      example = with pkgs; [ mpv feh ];
    };
  };

  config = {
    environment.systemPackages =
      let
        wlPackages = with pkgs; [
          wlr-randr
          wl-clipboard
        ];
      in
      with pkgs; [
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
        tree
        lsof
        stow
        audacious
        b3sum
        xeyes
        par2cmdline
        dex
        _7zip-zstd
        flac
        just

        tldr

        yazi
        ghostty

        man
        man-pages
        man-pages-posix
      ] ++ cfg.extraPackages ++ lib.optionals cfg.installModernUnixTools [ bat ripgrep fd delta duf eza broot sd cheat gping dust ]
      ++ lib.optionals (cfg.displayType == "wl") wlPackages
      ++ lib.optional (cfg.displayType == "x11") pkgs.xrandr
      ++ lib.optionals (cfg.displayType == "both") (lib.flatten wlPackages ++ [ pkgs.xrandr ]);
  };
}
