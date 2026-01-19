{
  hostName = "nixos";

  firewall = {
    enable = true;

    ping = {
      enable = true;
      limit = null;
    };

    networkPorts = {
      TCP = [
        30000 # Luanti
        53317 # Localsend
        40050 # Computer-stat-net
        5069  # System Shock 2
        8080  # SearXNG 
      ];
      UDP = [
        30000 # Luanti
        53317 # Localsend
        5069  # System Shock 2
        8080  # SearXNG 
      ];
    };
  };
}
