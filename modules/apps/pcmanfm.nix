{ config, pkgs, ... }: 

{
  environment.systemPackages = with pkgs; [
    pcmanfm
    lxmenu-data
    shared-mime-info
  ];

  # USB Mounting
  services = {
    gvfs.enable = true;
    udisks2.enable = true;
    devmon.enable = true;
  };
}
