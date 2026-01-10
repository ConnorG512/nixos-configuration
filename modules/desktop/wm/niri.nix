{ pkgs, config, ... }:

{
  programs.niri = {
    enable = true;
    useNautilus = true;
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
    gsettings-desktop-schemas
    waybar
    alacritty
    grim
    slurp
    fuzzel
  ];

  programs.nautilus-open-any-terminal = {
    enable = true; 
    terminal = "alacritty";
  };
  
  services = {
    gvfs.enable = true;
    gnome = {
      gnome-keyring.enable = true;
      sushi.enable = true;
    };
  };
}
