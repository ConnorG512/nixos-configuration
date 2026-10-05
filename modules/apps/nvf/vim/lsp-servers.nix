let
  lspServers = {
    ccls = {
      cmd = [ "clangd" ];
      filetypes = [ "c" "cpp" "h" "hpp" "ipp" ];
    };
    c3-lsp = {
      filetypes = [ "c3" ];
    };
  };

  mkServer = name: config: {
    cmd = config.cmd or [ name ];
    filetypes = config.filetypes;
  };
in
(builtins.mapAttrs mkServer lspServers) // {
  "*" = {
    root_markers = [ ".git" ];
    capabilities.textDocument.semanticTokens.multilineTokenSupport = true;
  };
}

