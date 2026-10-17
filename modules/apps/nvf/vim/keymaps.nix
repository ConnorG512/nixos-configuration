let
  keymapList = [
    {
      key = "<leader>e";
      action = ":Neotree toggle<CR>";
    }
    {
      key = "<leader>cf";
      action = ":%!clang-format<CR>";
    }
    {
      key = "<leader>nf";
      action = ":%!nixfmt<CR>";
    }
  ];
  createKeymap = { key, action }: {
    inherit key;
    inherit action;
    mode = "n";
    silent = true;
  };
in
  map createKeymap keymapList
