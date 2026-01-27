{ config, pkgs, ... }:

{
  services.desktopManager.plasma6 = {
    enable = true;
    enableQt5Integration = true;
  };

  environment.systemPackages = with pkgs; [
    firefox 
    kdePackages.kcalc
    kdePackages.gwenview
    kdePackages.okular
    kdePackages.elisa
  ];
}
