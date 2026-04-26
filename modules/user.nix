{config, pkgs, lib, ... }:

let
  cfg = config.systemConfiguration.user;
in 
{
  options.systemConfiguration.user = {
    name = lib.mkOption {
      type = lib.types.str;
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

    userPackageList = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Packages to install on a user level.";
      example = with pkgs; [ firefox mpv ];
    };

    configFileList = lib.mkOption {
      type = lib.types.attrsOf lib.types.path;
      default = {};
      description = "Map of destination paths to source dotfile paths.";
      example = {
        ".zshrc" = ./dotfiles/zshrc;
      };
    };
  };

  config = {
    programs.zsh.enable = true;

      users.users.${cfg.name} = {
        isNormalUser = true;
        extraGroups = cfg.groupList;
        initialPassword = "changeme";
        shell = pkgs.zsh;
      };

    home-manager.users.${cfg.name} = {
      home.stateVersion = "24.11";
      programs.zsh.enable = true;
      home = {
        packages = cfg.userPackageList;
        file = lib.mapAttrs (name: path: { source = path; }) cfg.configFileList;
      };
    };
  };
}

