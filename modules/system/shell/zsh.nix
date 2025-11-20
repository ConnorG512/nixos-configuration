{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    histSize = 1500;
    enableCompletion = true;

    zsh-autoenv = {
      package = pkgs.zsh-autoenv;
      enable = false;
    };

    autosuggestions = {
      enable = true;
      async = true;
    };

    syntaxHighlighting = {
      enable = true;
      styles = { };
      patterns = { };
      highlighters = [ "main" ];
    };

    ohMyZsh = {
      package = pkgs.oh-my-zsh;
      plugins = [
        "z"
        "git"
        "docker"
      ];
    };
  };
}
