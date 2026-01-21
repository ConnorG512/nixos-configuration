{config, pkgs, lib, ...}:

{
  # Currently auto detecting DNS from router however sometimes failing and cutting internet.
  # Force use of public DNS addresses and disable auto resolving.
  
  # resolved is currently forced off, set to true or remove to turn on. 
  services.resolved.enable = lib.mkForce false; 

  networking = {
    # Turn off the router automatic DNS:
    networkmanager.dns = "none";

    # DNS Servers available to the system:
    nameservers = [
      "1.1.1.1" # Cloudflare Primary
      "1.0.0.1" # Cloudflare Secondary
      #"8.8.8.8" # Google
    ];
  };
  }
