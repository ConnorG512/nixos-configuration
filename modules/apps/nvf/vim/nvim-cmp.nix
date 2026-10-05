{
  enable = true;

  sourcePlugins = [
    "cmp-nvim-lsp"
    "cmp-path"
    "cmp-treesitter"
    "cmp-luasnip"
    "cmp-buffer"
    "nvim-lspconfig"
    "vim-markdown"
    "cheatsheet-nvim"
    "nvim-treesitter"
    "comment-nvim"
    "harpoon"
    "nix-develop-nvim"
    "luasnip"
  ];

  sources = {
    buffer = "[Buffer]";
    nvim_lsp = "[LSP]";
    path = "[Path]";
    treesitter = "[Treesitter]";
    #luasnip = "[Snippet]";
  };
}
