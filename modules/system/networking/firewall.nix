{ config, lib, ... }:

let
  cfg = config.systemConfiguration.firewall;
in 
{
  options.systemConfiguration.firewall = {
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
      allowedTCPPorts = cfg.openedPorts;
      allowedUDPPorts = cfg.openedPorts;
      enable = true;
      allowPing = true;
      pingLimit = null;
      rejectPackets = false;
    };
  };
}

