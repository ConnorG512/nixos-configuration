{ config, lib, pkgs, ... }: 

let
  cfg = config.systemConfiguration.multimedia.audio;
in 
{
  options.systemConfiguration.multimedia.audio = {
    plugins = lib.mkOption {
      type = lib.types.listOf lib.types.enum [ "audio" "jack" "pulse" "alsa" ];
      default = [];
      description = "Pipewire plugins to enable.";
      example = false;
    };
    
    clockRate = lib.mkOption {
      type = lib.types.int;
      default = 44100;
      description = "Pipewire audio clock rate.";
      example = 48000;
    };
  }

  config = lib.mkMerge [
    (lib.mkIf (cfg.plugins != []){
      services.pipewire = lib.genAttrs cfg.plugins (name: {
        enable = true;
      });

      services.pipewire.extraConfig.pipewire = {
          "context.properties" = {
            "default.clock.rate" = cfg.clockRate;
          };
        };
      };
    })
  ];
}
