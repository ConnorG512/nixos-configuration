{ prefNetwork, ... }:

{
  networking = {
    hostName = "${prefNetwork.hostName}";

    networkmanager = {
      enable = true;
      dhcp = "internal";
      unmanaged = [ ];
      settings = { };
      plugins = [ ];

      ethernet.macAddress = "preserve";
    };

    firewall = {
      enable = prefNetwork.firewall.enable;
      allowPing = prefNetwork.firewall.ping.enable;
      pingLimit = prefNetwork.firewall.ping.limit;
      rejectPackets = false;

      extraCommands = "";
      extraStopCommands = "";

      extraInputRules = "";
      extraForwardRules = "";
      extraReversePathFilterRules = "";

      allowedTCPPorts = [
        80 # HTTP
        443 # HTTPS
      ]
      ++ prefNetwork.firewall.networkPorts.TCP;

      allowedUDPPorts = [
      ]
      ++ prefNetwork.firewall.networkPorts.UDP;
    };

    wireless = {
      enable = true;
    };
  };
}
