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

    treesitter = {
      enable = true;
      indent.enable = true;
      grammars = [
        # https://nvf.notashelf.dev/options.html#option-vim.treesitter.grammars
        pkgs.vimPlugins.nvim-treesitter.parsers.c3
        pkgs.vimPlugins.nvim-treesitter.parsers.dockerfile
      ];
    };

    clipboard.providers = {
      wl-copy.enable = true;
      xclip.enable = false;
      xsel.enable = false;
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
