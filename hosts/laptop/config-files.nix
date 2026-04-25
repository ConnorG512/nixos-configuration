{ self, ... }:

{
    ".zshrc".source = "${self}/dotfiles/.zshrc";
    ".config/alacritty/alacritty.toml".source = "${self}/dotfiles/.config/alacritty/alacritty.toml";
    ".config/fastfetch/config.jsonc".source = "${self}/dotfiles/.config/fastfetch/config.jsonc";
    ".config/tmux/tmux.conf".source = "${self}/dotfiles/.config/tmux/tmux.conf";
}
