let
  languageList = {
    clang = {
      format.enable = true;
    };
    nix = {
      format.enable = true;
    };
    zig = { };
    lua = {
      format.enable = true;
    };
    bash = {
      format.enable = true;
    };
    zsh = {
      format.enable = true;
    };
    haskell = {
      format.enable = true;
    };
  };

  applyLanguage = name: extra: {
    enable = true;
    lsp.enable = true;
    treesitter.enable = true;
  } // extra;
in
builtins.mapAttrs applyLanguage languageList
