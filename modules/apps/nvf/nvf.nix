{ nvf
, ...
}:

{
  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings.vim = import ./vim/vim.nix;
  };

  environment.variables = {
    EDITOR = "nvim";
  };
}

