{ pkgs, config, ... }:

{
  services.ngircd = {
    enable = true;
    config = ''
      [Global]
        Name = nix-irc.lan
        Info = Home IRC Server
        AdminInfo1 = Connor
        ServerUID = ngircd

      [Options]
        PAM = no
        DNS = no
    '';
  };
  
  networking.firewall = {
    allowedTCPPorts = [ 6667 ];
    allowedUDPPorts = [ 6667 ];
  }; 
}
