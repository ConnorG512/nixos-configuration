# Examples taken from https://notashelf.github.io/nvf/options.html#opt-vim.snippets.luasnip.customSnippets.snipmate
# $0 = place your cursor will be set after finishing the command.
# $n = The order in which the template will move your cursor to fill it in.

let
  snipmateModules = [
    {
      name = "nix";
      path = ./snippets/nix-snipmate.nix;
    }
    {
      name = "cpp";
      path = ./snippets/cpp/cpp.nix;
    }
    {
      name = "cmake";
      path = ./snippets/cmake-snipmate.nix;
    }
    {
      name = "lua";
      path = ./snippets/lua-snipmate.nix;
    }
    {
      name = "c3";
      path = ./snippets/c3-snipmate.nix;
    }
  ];

  addModule = { name, path }: {
    inherit name;
    value = import path;
  };
in
{
  enable = true;
  customSnippets.snipmate = builtins.listToAttrs (map addModule snipmateModules);
}
