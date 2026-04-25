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
  };

  config = {
    users.users.${cfg.name} = {
      isNormalUser = true;
      extraGroups = cfg.groupList;
      initialPassword = "changeme";
      shell = pkgs.zsh;
    };
  };
}

