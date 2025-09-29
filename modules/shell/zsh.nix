{config, pkgs, ... }: 

{
  programs.zsh = {
    enable = true;
    histSize = 1500;
    enableCompletion = true;

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
      plugins = [ "z" "git" "sudo" "docker" ]; 
    };
  };
}
