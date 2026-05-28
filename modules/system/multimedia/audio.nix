{ config, lib, pkgs, ... }: 

let
  cfg = config.systemConfiguration.multimedia.audio;
in 
{
  options.systemConfiguration.multimedia.audio = {
    plugins = lib.mkOption {
      type = lib.types.listOf (lib.types.enum [ "audio" "jack" "pulse" "alsa" ]);
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
  };

    config = lib.mkIf (cfg.plugins != []) (lib.mkMerge [
    {
      services.pipewire = lib.genAttrs cfg.plugins (name: {
        enable = true;
      });
    }

    {
      services.pipewire = {
        extraConfig.pipewire = {
          "context.properties" = {
            "default.clock.rate" = cfg.clockRate;
          };

          # Custom modules: 
          "90-discord-splitter" = {
            "context.modules" = [
              {
                name = "libpipewire-module-loopback";
                args = {
                  "audio.position" = [ "FL" "FR" ];
                  "capture.props" = {
                    "media.class" = "Audio/Sink";
                    "node.name" = "discord_splitter";
                    "node.description" = "Sink for splitting Discord capture audio";
                  };
                  "playback.props" = {
                    "node.name" = "discord_splitter.output";
                    "node.passive" = true;
                  };
                };
              }
            ];
          };
        };
      };
    }
  ]);
}
