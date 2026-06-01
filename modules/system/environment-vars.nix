{ config, ... }:

{
  environment.variables = {
    LOCAL = "$HOME/.local";
    SHARE = "$HOME/.local/share";
    STATE = "$HOME/.local/state";
    BIN = "$HOME/.local/bin";

    XDG_CONFIG_HOME = "$HOME/.config";
  };  
}
