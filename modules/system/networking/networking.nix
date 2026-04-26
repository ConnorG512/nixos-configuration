{ config, lib, ... }:

let
  cfg = config.systemConfiguration.network;
in 
{
  options.systemConfiguration.network = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable networking.";
      example = true;
    };
    
    hostName = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
      description = "Computer hostname.";
      example = "nixos";
    };

    additionalPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [ ];
      description = "Additional ports to open on UDP and TCP";
      example = [ 22 80 443 ];
    };
  }; 

  config = lib.mkMerge [
    {
      networking = {
        hostName = cfg.hostName;
        nameservers = let
          dnsProviders = import ./dns-provider-list.nix;
        in dnsProviders.cloudFlare.malware ++ dnsProviders.quadNine.malwareDNSSEC;
      };
    }

    (lib.mkIf cfg.enable {
      networking.networkmanager  = {
        enable = true;
        dns = "none";
      };

      networking.firewall = {
        enable = true;
        allowedTCPPorts = cfg.additionalPorts;
        allowedUDPPorts = cfg.additionalPorts;
        allowPing = true;
        pingLimit = null;
        rejectPackets = false;
      };
    })
  ];
}
