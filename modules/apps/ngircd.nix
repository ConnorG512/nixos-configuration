{ pkgs, config, ... }:

{
  services.ngircd = {
    enable = true;
    config = "Name = local\nInfo = local IRC server\n";
  };
  networking.firewall.allowedTCPPorts = [ 6667 ];
}
