{ pkgs, config, ... }:

{
  programs.hyprland = {
    enable = true;

    xwayland.enable = true;
    withUWSM = true;
  };
  
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-hyprland
    waybar
    hyprcursor
    alacritty
    tofi
    hyprpaper
    hyprlock
    hyprpolkitagent
    grim
    slurp
    mesa
  ];
}

