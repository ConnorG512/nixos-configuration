{config, pkgs, nvf, ... }:

{
  programs.nvf = {
    enable = true;
    enableManpages = true;

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
        lsp = {
          servers = {
            "*" = {
              root_markers = [ ".git" ];
              capabilities = {
                textDocument = {
                  semanticTokens = {
                    multilineTokenSupport = true;
                  };
                };
              };
            };

            "clangd" = {
              cmd = [ "clangd" ];
              filetypes = [ "c" "cpp" "h" "hpp" ];
            };
            "nil-ls" = {
              cmd = [ "nil" ];
              filetypes = [ "nix" "flake" "lock" ];
            };
            "zls" = {
              cmd = [ "zls" ];
              filetypes = [ "zig" "zig.zon" ];
            };
          };
        };
        languages = {
          enableTreesitter = true;
          enableFormat = true;

          clang = {
            enable = true;
          };
          nix = {
            enable = true;
          };
        };
        autocomplete.nvim-cmp = {
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
          ];
          sources = {
            buffer = "[Buffer]";
            nvim_lsp = "[LSP]";
            path = "[Path]";
            treesitter = "[Treesitter]";
            luasnip = "[Snippet]";
          };
        };
        autopairs.nvim-autopairs.enable = true;
        statusline.lualine.enable = true;
        telescope.enable = true;
      };
    };
  };
}

