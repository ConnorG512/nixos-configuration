{ self, ... }:

{
    ".zshrc" = "${self}/dotfiles/.zshrc";
    ".config/alacritty/alacritty.toml" = "${self}/dotfiles/.config/alacritty/alacritty.toml";
    ".config/ghostty/config.ghostty" = "${self}/dotfiles/.config/ghostty/config.ghostty";
    ".config/fastfetch/config.jsonc" = "${self}/dotfiles/.config/fastfetch/config.jsonc";
    ".config/tmux/tmux.conf" = "${self}/dotfiles/.config/tmux/tmux.conf";
}
