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

    ohMyZsh = {
      package = pkgs.oh-my-zsh;
    };
  };
}
