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

    enableAvahi = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Avahi service.";
      example = true;
    };

    dns = lib.mkOption {
      type = lib.types.enum [
        "google"
        "malwareAdultBlocking"
        "hardened"
      ];
      default = [ ];
      description = "List of DNS services to add to resolv.conf";
      example = [ "google"];
    };
  }; 

  config = lib.mkMerge [
    {
      networking = {
        hostName = cfg.hostName;
        networkmanager.enable = cfg.enable;
        
        firewall = {
          enable = cfg.enable;
          allowedTCPPorts = [ 42069 ] ++ cfg.additionalPorts ++ lib.optional cfg.enableOpenssh 22;
          allowedUDPPorts = [ 42069 ] ++ cfg.additionalPorts ++ lib.optional cfg.enableAvahi 5353;
          allowPing = true;
          pingLimit = null;
          rejectPackets = false;
        };
      };
    }

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
    
    (lib.mkIf cfg.enableAvahi {
      services.avahi = {
      enable = true;
      nssmdns4 = true;
        publish = {
          enable = true;
          addresses = true;
          domain = true;
          hinfo = true;
          userServices = true;
          workstation = true;
        };
      };
    })

    (lib.mkIf (cfg.dns != [ ]) {
    # https://developers.google.com/speed/public-dns/docs/using
    # https://www.cloudflare.com/learning/dns/what-is-1.1.1.1/
    # https://quad9.net/service/service-addresses-and-features/
      networking = {
        networkmanager.dns = "none";
        nameservers = 
          lib.optionals (cfg.dns == "google") [ "8.8.8.8" "8.8.4.4" "2001:4860:4860::8888" ]
          ++ lib.optionals (cfg.dns == "malwareAdultBlocking") [ "1.1.1.3" "1.0.0.3" "2606:4700:4700::1113" ]
          ++ lib.optionals (cfg.dns == "hardened") [ "9.9.9.11" "149.112.112.11" "1.1.1.2" ];
      }; 
    })
  ];
}
