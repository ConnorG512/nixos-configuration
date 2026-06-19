{ config, lib, pkgs, ... }:

let
  cfg = config.systemConfiguration.environment;
in 
{
  options.systemConfiguration.environment = {
    varList = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [ ];
      description = "List of environment variables to create.";
      example = [
        { name = "LOCAL"; value = "$HOME/.local"; }
      ];
    };

    shell = lib.mkOption {
      type = lib.types.enum [ "bash" "zsh" ];
      default = "bash";
      description = "Select a shell environment to use.";
      example = "zsh";
    };
  };

  config = lib.mkMerge [
    {
      environment.variables = builtins.listToAttrs ([
        { name = "LOCAL"; value = "$HOME/.local"; }
        { name = "LSHARE"; value = "$HOME/.local/share"; }
        { name = "LSTATE"; value = "$HOME/.local/state"; }
        { name = "LBIN"; value = "$HOME/.local/bin"; }
        { name = "XDG_CONFIG_HOME"; value = "$HOME/.config"; }
        { name = "DOCUMENTS"; value = "$HOME/Documents"; }
        { name = "PICTURES"; value = "$HOME/Pictures"; }
        { name = "MUSIC"; value = "$HOME/Music"; }
        { name = "VIDEOS"; value = "$HOME/Videos"; }
        { name = "PUBLIC"; value = "$HOME/Public"; }
      ] ++ lib.optionals (cfg.varList != []) cfg.varList);
    }

    (lib.mkIf (cfg.shell == "zsh") {
      programs.zsh = {
        enable = true; 
        histSize = 2500;
        enableCompletion = true;

        zsh-autoenv = {
          package = pkgs.zsh-autoenv;
          enable = false;
        };

        autosuggestions = {
          enable = true;
          async = true;
        };

        syntaxHighlighting = {
          enable = true;
          styles = { };
          patterns = { };
          highlighters = [ "main" ];
        };

        ohMyZsh = {
          package = pkgs.oh-my-zsh;
          plugins = [
            "z"
            "git"
            "docker"
          ];
        };
      };
    })
    
    (lib.mkIf (cfg.shell == "bash") {
      programs.bash = {
        enable = true;
        enableLsColors = true;
        completion.enable = true;
      };
    })
  ];
}
