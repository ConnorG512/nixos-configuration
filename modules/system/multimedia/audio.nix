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
          
          # Finding ID number can be done with pwctl
          # Finding the correct string for target.object can be found with pw-cli info 
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
                    "target.object" = "alsa_output.pci-0000_08_00.1.pro-output-10";
                  };
                };
              }
            ];
          };
          "91-headphones-sink" = {
            "context.modules" = [
              {
                name = "libpipewire-module-loopback";
                args = {
                  "audio.position" = [ "FL" "FR" ];
                  "capture.props" = {
                    "media.class" = "Audio/Sink";
                    "node.name" = "headphones_sink";
                    "node.description" = "Sink for passing audio to headphones";
                  };
                  "playback.props" = {
                    "node.name" = "headphones_sink.output";
                    "node.passive" = true;
                    "target.object" = "alsa_output.pci-0000_08_00.1.pro-output-10";
                  };
                };
              }
            ];
          };
          "92-tv-sink" = {
            "context.modules" = [
              {
                name = "libpipewire-module-loopback";
                args = {
                  "audio.position" = [ "FL" "FR" ];
                  "capture.props" = {
                    "media.class" = "Audio/Sink";
                    "node.name" = "tv_sink";
                    "node.description" = "Sink for passing audio to TV";
                  };
                  "playback.props" = {
                    "node.name" = "tv_sink.output";
                    "node.passive" = true;
                    "target.object" = "alsa_output.pci-0000_08_00.1.pro-output-3";
                  };
                };
              }
            ];
          };

          # Combine Stream: https://docs.pipewire.org/page_module_combine_stream.html
          "93-tv-headphones-sink" = {
            "context.modules" = [
              {
                name = "libpipewire-module-combine-stream";
                args = {
                  "combine.mode" = "sink";
                  "node.name" = "tv-headphones-combine-sink";
                  "node.description" = "Connect audio to headphones and TV";
                  "combine.props" = {
                    "audio.position" = [ "FL" "FR" ];
                  };
                  "stream.props" = {
                    "stream.dont-remix" = true;
                  };
                  "targets" = [
                    { "target.object" = "alsa_output.pci-0000_08_00.1.pro-output-10"; }
                    { "target.object" = "alsa_output.pci-0000_08_00.1.pro-output-3"; }
                  ];
                };
              }
            ];
          };
        };
      };
    }
  ]);
}
