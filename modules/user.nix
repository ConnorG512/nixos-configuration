{config, pkgs, lib, ... }:

let
  cfg = config.systemConfiguration.user;
in 
{
  options.systemConfiguration.user = {
    name = lib.mkOption {
      type = lib.types.string;
      default = "user";
      description = "Name to provide the user.";
      example = "john";
    };

    groupList = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of groups to provide to the user.";
      example = [ "wheel" "video" ];
    };

    useZsh = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Use ZShell";
      example = false;
    };

    userPackageList = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Packages to install on a user level.";
      example = with pkgs; [ firefox mpv ];
    };

    configFileList = lib.mkOption {
      type = lib.types lib.types.attrsOf lib.types.path;
      default = {};
      description = "Map of destination paths to source dotfile paths.";
      example = {
        ".zshrc" = ./dotfiles/zshrc;
      };
    };
  };

  config = {
      users.users.${cfg.name} = {
        isNormalUser = true;
        extraGroups = cfg.groupList;
        initialPassword = "changeme";
        shell = pkgs.zsh;
      };

    home-manager.users.${cfg.name} = {
      home.stateVersion = "24.11";
      programs.zsh.enable = cfg.useZsh;
      home = {
        packages = cfg.userPackageList;
        file = cfg.configFileList;
      };
    };
  };
}

