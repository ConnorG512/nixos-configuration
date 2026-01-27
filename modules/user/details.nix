{ config, lib, pkgs, ... }:

let
  cfg = config.systemConfiguration.userDetails;
in 
{
  options.systemConfiguration.userDetails = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "user";
      description = "Name to give to the user account.";
      example = "jimmy";
    };

    groupList = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "List of groups to provide to the user.";
      example = true;
    };

    isTrustedUser = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Is the user a trusted user.";
      example = true;
    };

    shellType = lib.mkOption {
      type = lib.types.enum([ "bash" "zsh" ]);
      default = "bash";
      description = "Shell to use for the user.";
      example = "bash";
    };

  };
  
  config = {
    users = {
      users.${cfg.name} = {
        isNormalUser = true;
        home = "/home/${cfg.name}";
        description = "${cfg.name}";
        extraGroups = cfg.groupList;

        shell = if cfg.shellType == "bash" then 
            pkgs.bash
          else 
            pkgs.zsh;
      };
    };
    
    nix.settings.trusted-users = if cfg.isTrustedUser then 
      [ "${cfg.name}" ]
    else 
      [ ];

  };
}
