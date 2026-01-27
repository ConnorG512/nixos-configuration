{ config, lib, ... }:

let
  cfg = config.systemConfiguration.userDirectories;
  userName = config.systemConfiguration.userDetails.name;

  lowerCaseDirs = [
    "d /home/${userName}/documents 0755 ${userName} ${userName} -"
    "d /home/${userName}/pictures 0755 ${userName} ${userName} -"
    "d /home/${userName}/videos 0755 ${userName} ${userName} -"
    "d /home/${userName}/music 0755 ${userName} ${userName} -"
  ];
  
  upperCaseDirs = [
    "d /home/${userName}/Documents 0755 ${userName} ${userName} -"
    "d /home/${userName}/Pictures 0755 ${userName} ${userName} -"
    "d /home/${userName}/Videos 0755 ${userName} ${userName} -"
    "d /home/${userName}/Music 0755 ${userName} ${userName} -"
  ];

in 
{
  options.systemConfiguration.userDirectories = {
    createUserDirs = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Create standard user dirs in home such as Pictures, Documents, etc..";
      example = false;
    };
    
    useUpperCaseNames = lib.mkOption {
      type = lib.types.bool;
      default = true; 
      description = "User upper case first letter for made directories.";
      example = true;
    };
  };
  config = {
      systemd.user.tmpfiles.rules = if cfg.useUpperCaseNames then 
        upperCaseDirs
      else 
        lowerCaseDirs;
  };
}
