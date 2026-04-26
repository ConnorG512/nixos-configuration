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

    openedPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      default = [ 80 443 ];
      description = "Ports to open on UDP and TCP";
      example = [ 80 443 ];
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
        allowedTCPPorts = cfg.openedPorts;
        allowedUDPPorts = cfg.openedPorts;
        allowPing = true;
        pingLimit = null;
        rejectPackets = false;
      };
    })
  ];
}
