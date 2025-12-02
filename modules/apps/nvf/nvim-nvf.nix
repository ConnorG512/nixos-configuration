{
  config,
  pkgs,
  nvf,
  ...
}:

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
        clipboard = {
          providers = {
            wl-copy.enable = true;
            xclip.enable = false;
            xsel.enable = false;
          };
        };
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
              filetypes = [
                "c"
                "cpp"
                "h"
                "hpp"
              ];
            };
            "ccls" = {
              cmd = [ "ccls" ];
              filetypes = [
                "c"
                "cpp"
                "h"
                "hpp"
              ];
            };
            "nil-ls" = {
              cmd = [ "nil" ];
              filetypes = [
                "nix"
                "flake"
                "lock"
              ];
            };
            "zls" = {
              cmd = [ "zls" ];
              filetypes = [
                "zig"
                "zig.zon"
              ];
            };
            "rust-analyzer" = {
              cmd = [ "rust-analyzer" ];
              filetypes = [
                "rust"
              ];
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
            "luasnip"
          ];
          sources = {
            buffer = "[Buffer]";
            nvim_lsp = "[LSP]";
            path = "[Path]";
            treesitter = "[Treesitter]";
            #luasnip = "[Snippet]";
          };
        };
        autopairs.nvim-autopairs.enable = true;
        statusline.lualine.enable = true;
        telescope.enable = true;

        snippets.luasnip = {
          enable = true;

          customSnippets.snipmate = {
            # Examples taken from https://notashelf.github.io/nvf/options.html#opt-vim.snippets.luasnip.customSnippets.snipmate
            # $0 = place your cursor will be set after finishing the command.
            # $n = The order in which the template will move your cursor to fill it in.

            all = [ ];
            nix = [
              {
                trigger = "mkOption";
                body = ''
                  mkOption {
                    type = $1;
                    default = $2;
                    description = $3;
                    example = $4;
                  }
                '';
              }
            ];
            cpp = import ./cpp-snipmate.nix;
          };
        };
      };
    };
  };
}
