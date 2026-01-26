{ config, lib, ... }:

let
  dnsProviders = import ./dns-provider-list.nix;
in 
{
  imports =[
    ./dns.nix
    ./firewall.nix
  ];
  
  networking = {
    hostName = "nixos";
    
    networkmanager = {
      enable = true;
      dhcp = "internal";
      unmanaged = [ ];
      settings = { };
      plugins = [ ];

      ethernet.macAddress = "preserve";
    };
  }; 

  systemConfiguration.dns = {
    enableAutomaticDns = false;  
    providers = dnsProviders.quadNine.malwareDNSSEC ++ dnsProviders.cloudFlare.malware;
  };

  systemConfiguration.firewall = {
    enable = true;
    openedPorts = [ 30000 53317 42069 40050 5069 8080 ];
  };
}
