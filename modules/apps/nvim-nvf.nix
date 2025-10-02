{config, pkgs, nvf, ... }:

{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        luaConfigRC = { };
        treesitter = {
          indent.enable = false;
        };
        options = {
          autoindent = true;
          shiftwidth = 2;
        };
        theme = {
          enable = true;
          name = "tokyonight";
          style = "night";
        };          

        autocomplete.nvim-cmp.enable = true;
        autopairs.nvim-autopairs.enable = true;
        statusline.lualine.enable = true;
        telescope.enable = true;

        languages = {
          enableLSP = true;
          enableFormat = false;
          enableTreesitter = true;
          zig = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          nix = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          clang = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
        };
      };
    };
  };
}

