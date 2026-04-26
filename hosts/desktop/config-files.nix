{ self, ... }:

{
    ".zshrc" = "${self}/dotfiles/.zshrc";
    ".config/alacritty/alacritty.toml" = "${self}/dotfiles/.config/alacritty/alacritty.toml";
    ".config/fastfetch/config.jsonc" = "${self}/dotfiles/.config/fastfetch/config.jsonc";

    ".config/tofi/config" = "${self}/dotfiles/.config/tofi/config";
    ".config/waybar/config.jsonc" = "${self}/dotfiles/.config/waybar/config.jsonc";
    ".config/waybar/style.css" = "${self}/dotfiles/.config/waybar/style.css";

    ".config/niri/config.kdl" = "${self}/dotfiles/.config/niri/config.kdl";

    ".config/tmux/tmux.conf" = "${self}/dotfiles/.config/tmux/tmux.conf";

    ".config/mako/config" = "${self}/dotfiles/.config/mako/config";

    ".config/fuzzel/fuzzel.ini" = "${self}/dotfiles/.config/fuzzel/fuzzel.ini";
    ".config/fuzzel/blue.ini" = "${self}/dotfiles/.config/fuzzel/blue.ini";

    ".config/hypr/hyprlock.conf" = "${self}/dotfiles/.config/hypr/hyprlock.conf";
    ".config/hypr/hyprpaper.conf" = "${self}/dotfiles/.config/hypr/hyprpaper.conf";

    "Pictures/wallpaper/pexels-riccardo-bertolo-4245826.jpg" = "${self}/wallpaper/pexels-riccardo-bertolo-4245826.jpg";
}
