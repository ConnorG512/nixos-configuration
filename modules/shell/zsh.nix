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
  };
}
