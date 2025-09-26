{ config, pkgs, ...}:

{
  services.xserver.enable = true;
  # Enable the lightdm display manager 
  services.xserver.displayManager.lightdm.enable = true;
  # Enable the lxqt DE
  services.xserver.desktopManager.lxqt.enable = true;
}
