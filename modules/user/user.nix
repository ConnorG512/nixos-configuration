{config, pkgs, lib, ... }:

let
  cfg = config.systemConfiguration.newUser;
in 
{
  options.systemConfiguration.newUser = {
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

    useHMDotfiles = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Use Home Manager to manager dotfiles.";
      example = true;
    };

    userPackageList = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Packages to install on a user level.";
      example = with pkgs; [ firefox mpv ];
    };
  };

  config = lib.mkMerge [
    {
      users.users.${cfg.name} = {
        isNormalUser = true;
        extraGroups = cfg.groupList;
        initialPassword = "changeme";
        shell = pkgs.zsh;
      };
    }

    (lib.mkIf cfg.useHMDotfiles {
      home-manager.users.${cfg.name} = {
        home.stateVersion = "24.11";
        programs.zsh.enable = cfg.useZsh;
        home.packages = cfg.userPackageList;
      };
    })
  ];
}

