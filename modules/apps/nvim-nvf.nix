{config, pkgs, nvf, ... }:

{
  programs.nvf = {
    enable = true;
    enableManpages = true;

    settings = {
      vim = {
        luaConfigRC = { };
        keymaps = [
        {
          key = "<leader>e";
          mode = "n";
          silent = true;
          action = ":Neotree toggle<CR>";
        }
        {
          key = "<leader>cf";
          mode = "n";
          silent = true;
          action = ":%!clang-format<CR>";
        }
        {
          key = "<leader>nf";
          mode = "n";
          silent = true;
          action = ":%!nixfmt<CR>";
        }
        ];
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
        filetree.neo-tree = {
          enable = true;
          setupOpts = {
            enable_diagnostics = true;
            enable_cursor_hijack = false;
            enable_git_status = true;
            enable_modified_markers = true;
            enable_refresh_on_write = true;
            git_status_async = false;
            hide_root_node = false;
            open_files_in_last_window = true;
            retain_hidden_root_indent = false;
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

