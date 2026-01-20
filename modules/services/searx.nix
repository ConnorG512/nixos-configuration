{ config, pkgs, ... }:

{
  services.searx = {
      enable = true;
      environmentFile = "/home/connor/.searxng.env";
      redisCreateLocally = true;

      settings.server = {
        bind_address = "0.0.0.0";
        port = 8080;
      };
  };
}
