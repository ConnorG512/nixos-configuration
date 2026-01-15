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
  };
}
