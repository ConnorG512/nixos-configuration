{ nvf, pkgs, ... }:

{
  imports = [
    ./vim/vim.nix
  ];

  programs.nvf = {
    enable = true;
    enableManpages = true;
  };

  environment.variables = {
    EDITOR = "nvim";
  };
}

