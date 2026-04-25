{ config, lib, ... }:

let
  cfg = config.systemConfiguration.networking.hostname;
in 
{
  options.systemConfiguration.networking.hostname = {
    hostname = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
      description = "Computer Hostname";
      example = "nixos";
    };
  };

  config = {
    networking.hostname = cfg.hostname;
  };
}
