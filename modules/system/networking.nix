{ config, pkgs, ... }:

{
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

    firewall = {
      enable = true;
      
      allowPing = true;
      rejectPackets = false;

      allowedTCPPorts = [
        80      # HTTP
        443     # HTTPS
        30000   # Luanti
        5069    # System Shock 2 Remastered LAN?
        40050   # computer-stat-net
        53317   # localsend
      ];
      
      allowedUDPPorts = [
        30000   # Luanti
        5069    # System Shock 2 Remastered LAN?
        53317   # localsend
      ];
    };

    wireless = {
      enable = false;
    };
  };
}
