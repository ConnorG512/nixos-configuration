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
    
    enableOpenssh = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable openssh.";
      example = true;
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
        allowedTCPPorts = cfg.additionalPorts ++ (if cfg.enableOpenssh then [ 22 ] else [ ]);
        allowedUDPPorts = cfg.additionalPorts;
        allowPing = true;
        pingLimit = null;
        rejectPackets = false;
      };
    })

    (lib.mkIf cfg.enableOpenssh{
      services.openssh = {
        enable = true;
        ports = [ 22 ];
        allowSFTP = true;
        settings = {
          PasswordAuthentication = true;
          AllowUsers = null;
          UseDns = false;
          X11Forwarding = false;
          PermitRootLogin = "prohibit-password";
        };
      }; 
    })
  ];
}
