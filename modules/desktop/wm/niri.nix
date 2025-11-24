{ pkgs, config, ... }:

{
  programs.niri = {
    enable = true;
  };
  
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    xwayland-satellite
    mesa
    
    hyprlock
    hyprpaper
    mako
    nautilus
    waybar
    alacritty
    grim
    slurp
    fuzzel
  ];

  services.gnome = {
    gnome-keyring.enable = true;
    sushi.enable = true;
  };
}
