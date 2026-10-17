{ pkgs
, ...
}:

{
  programs.nvf.settings.vim = {
    theme = import ./theme.nix;
    lsp = {
      enable = true;
      lspsaga.enable = true;
      servers = import ./lsp-servers.nix;
      lspconfig.enable = true;
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

    languages = import ./languages.nix;
    autopairs.nvim-autopairs.enable = true;
    statusline.lualine.enable = true;
    telescope.enable = true;
    
    keymaps = import ./keymaps.nix;

    ui = {
      borders = {
        enable = true;
        plugins = {
          which-key.enable = true;
          nvim-cmp.enable = true;
          lspsaga.enable = true;
        };
      };
    };
    
    mini = {
      surround.enable = true;
      comment.enable = true;
    }; 
    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
    }; 
    utility.nix-develop.enable = true;
    filetree.neo-tree.enable = true;
    snippets.luasnip = import ./luasnip.nix;
    autocomplete.nvim-cmp = {
      enable = true;
      sources = {
        buffer = "[Buffer]";
        nvim_lsp = "[LSP]";
        path = "[Path]";
        treesitter = "[Treesitter]";
        #luasnip = "[Snippet]";
      };
    };
  };
}
