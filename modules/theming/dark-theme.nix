{ config, pkgs, ... }:

{
  # Install themes to system
  environment.systemPackages = with pkgs; [
  ];

  # Environment Variables 
  environment.variables = {
    GTK_THEME = "Adwaita:dark";
    QT_QPA_PLATFORMTHEME = "gtk";
  };
}
