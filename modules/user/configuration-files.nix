{ self, ... }:

{
  home.file = {
    ".zshrc".source = "${self}/dotfiles/.zshrc";
    ".config/alacritty/alacritty.toml".source = "${self}/dotfiles/.config/alacritty/alacritty.toml";
    ".config/fastfetch/config.jsonc".source = "${self}/dotfiles/.config/fastfetch/config.jsonc";

    ".config/hypr/hyprland-animations.conf".source = "${self}/dotfiles/.config/hypr/hyprland-animations.conf";
    ".config/hypr/hyprland-autostart.conf".source = "${self}/dotfiles/.config/hypr/hyprland-autostart.conf";
    ".config/hypr/hyprland-keybinds.conf".source = "${self}/dotfiles/.config/hypr/hyprland-keybinds.conf";
    ".config/hypr/hyprland-monitors.conf".source = "${self}/dotfiles/.config/hypr/hyprland-monitors.conf";
    ".config/hypr/hyprland-windows.conf".source = "${self}/dotfiles/.config/hypr/hyprland-windows.conf";
    ".config/hypr/hyprland.conf".source = "${self}/dotfiles/.config/hypr/hyprland.conf";
    ".config/hypr/hyprlock.conf".source = "${self}/dotfiles/.config/hypr/hyprlock.conf";
    ".config/hypr/hyprpaper.conf".source = "${self}/dotfiles/.config/hypr/hyprpaper.conf";

    ".config/tofi/config".source = "${self}/dotfiles/.config/tofi/config";
    ".config/waybar/config.jsonc".source = "${self}/dotfiles/.config/waybar/config.jsonc";
    ".config/waybar/style.css".source = "${self}/dotfiles/.config/waybar/style.css";

    ".config/niri/config.kdl".source = "${self}/dotfiles/.config/niri/config.kdl";

    ".config/tmux/tmux.conf".source = "${self}/dotfiles/.config/tmux/tmux.conf";

    ".config/mako/config".source = "${self}/dotfiles/.config/mako/config";

    ".config/fuzzel/fuzzel.ini".source = "${self}/dotfiles/.config/fuzzel/fuzzel.ini";
    ".config/fuzzel/blue.ini".source = "${self}/dotfiles/.config/fuzzel/blue.ini";
  };
}
