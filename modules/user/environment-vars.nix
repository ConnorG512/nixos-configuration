{ config, ... }:

{
  environment.variables = {
    LOCAL = "${config.home.homeDirectory}/.local";
    SHARE = "${config.homeDirectory}/.local/share";
    STATE = "${config.homeDirectory}/.local/state";
    BIN = "${config.homeDirectory}/.local/bin";
  };  
}
