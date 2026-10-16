{ pkgs
, ...
}:

{
  programs.nvf.settings.vim = {
    theme = import ./theme.nix;
    lsp = {
      enable = true;
      servers = import ./lsp-servers.nix;
    };
    treesitter.indent.enable = true;

    clipboard.providers = {
      wl-copy.enable = true;
      xclip.enable = false;
      xsel.enable = false;
    };

    extraPlugins = {
      c3-treesitter = {
        package = pkgs.vimPlugins.nvim-treesitter-parsers.c3;
      };
    };

    options = {
      autoindent = true;
      shiftwidth = 2;
    };

    filetree.neo-tree.setupOpts.enable_cursor_hijack = false;

    languages = import ./languages.nix;
    autocomplete.nvim-cmp = import ./nvim-cmp.nix;
    autopairs.nvim-autopairs.enable = true;
    statusline.lualine.enable = true;
    telescope.enable = true;
    snippets.luasnip = import ./luasnip.nix;
  };
}
