{ config, pkgs, ... }:

let
  currentUser = "connor";
in
{
  imports = [
    ./installed-packages.nix
  ];

  home = {
    username = currentUser;
    homeDirectory = "/home/${currentUser}";
    stateVersion = "24.11";

    # Import the config files directly to the home user.
    # relative to the user $HOME
    # So ".zshrc" is symlinked to ~/.zshrc / $HOME/.zshrc
    file = {
      ".zshrc".source = ../dotfiles/.zshrc;
      ".config/alacritty/alacritty.toml".source = ../dotfiles/.config/alacritty/alacritty.toml;
      ".config/fastfetch/config.jsonc".source = ../dotfiles/.config/fastfetch/config.jsonc;

      ".config/hypr/hyprland-animations.conf".source = ../dotfiles/.config/hypr/hyprland-animations.conf;
      ".config/hypr/hyprland-autostart.conf".source = ../dotfiles/.config/hypr/hyprland-autostart.conf;
      ".config/hypr/hyprland-keybinds.conf".source = ../dotfiles/.config/hypr/hyprland-keybinds.conf;
      ".config/hypr/hyprland-monitors.conf".source = ../dotfiles/.config/hypr/hyprland-monitors.conf;
      ".config/hypr/hyprland-windows.conf".source = ../dotfiles/.config/hypr/hyprland-windows.conf;
      ".config/hypr/hyprland.conf".source = ../dotfiles/.config/hypr/hyprland.conf;
      ".config/hypr/hyprlock.conf".source = ../dotfiles/.config/hypr/hyprlock.conf;
      ".config/hypr/hyprpaper.conf".source = ../dotfiles/.config/hypr/hyprpaper.conf;

      ".config/tofi/config".source = ../dotfiles/.config/tofi/config;
      ".config/waybar/config.jsonc".source = ../dotfiles/.config/waybar/config.jsonc;
      ".config/waybar/style.css".source = ../dotfiles/.config/waybar/style.css;

      # ".config/nvim/lua/snippets/cpp.lua".source = ../dotfiles/.config/nvim/lua/snippets/cpp.lua;
    };
  };
  programs.home-manager.enable = true;
}
