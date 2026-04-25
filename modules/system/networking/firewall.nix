{ config, lib, ... }:

let
  cfg = config.systemConfiguration.networking.firewall;
in 
{
  options.systemConfiguration.networking.firewall = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable firewall";
      example = false;
    };

    openedPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [ 80 443 ];
      description = "Ports to open on UDP and TCP";
      example = [ 80 443 ];
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall = {
      enable = cfg.enable;
      allowedTCPPorts = cfg.openedPorts;
      allowedUDPPorts = cfg.openedPorts;
      allowPing = true;
      pingLimit = null;
      rejectPackets = false;
    };
  };
}

