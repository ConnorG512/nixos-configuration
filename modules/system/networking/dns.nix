{config, pkgs, lib, ...}:

let
  dnsProviders = import ./dns-provider-list.nix;
in 
{
  # Currently auto detecting DNS from router however sometimes failing and cutting internet.
  # Force use of public DNS addresses and disable auto resolving.
  
  networking = {
    # Turn off the router automatic DNS:
    networkmanager.dns = "none";

    # DNS Servers available to the system:
    # nameservers are written to  /etc/resolv.conf
    nameservers = dnsProviders.quadNine.malwareDNSSEC ++ dnsProviders.cloudFlare.malware;
  };
}
