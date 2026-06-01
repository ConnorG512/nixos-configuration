{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.systemConfiguration.multimedia.audio;

  # Functions:
  enablePlugins =
    pluginList:
    lib.genAttrs pluginList (name: {
      enable = true;
    });

in
{
  options.systemConfiguration.multimedia.audio = {
    plugins = lib.mkOption {
      type = lib.types.listOf (
        lib.types.enum [
          "audio"
          "jack"
          "pulse"
          "alsa"
        ]
      );
      default = [
        "audio"
        "jack"
        "pulse"
        "alsa"
      ];
      description = "Pipewire plugins to enable.";
      example = false;
    };

    clockRate = lib.mkOption {
      type = lib.types.int;
      default = 44100;
      description = "Pipewire audio clock rate.";
      example = 48000;
    };

    hiddenPorts = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "List of full node.name ports to hide in wireplumber.";
      example = [ "alsa_output.pci-0000_08_00.1.pro-output-0" ];
    };

    renamedPorts = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [ ];
      description = "list of attributes of devices to rename.";
      example = [
        {
          target = "alsa_output.pci-0000_08_00.1.pro-output-0";
          newName = "Headset";
        }
      ];
    };

    # Custom modules:
    # Finding ID number can be done with pwctl
    # Finding the correct string for target.object can be found with pw-cli info
    # Combine Stream: https://docs.pipewire.org/page_module_combine_stream.html
    loopbackModules = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [ ];
      description = "List of pipewire modules to create";
    };
    sinkModules = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [ ];
      description = "List of pipewire modules to create";
    };
  };

  config = lib.mkIf (cfg.plugins != [ ]) (
    lib.mkMerge [

      # Globals:
      {
        services.pipewire.extraConfig.pipewire = {
          "context.properties" = {
            "default.clock.rate" = cfg.clockRate;
          };
        };
      }

      # Enable modules:
      {
        services.pipewire =
          let
            enableServices =
              serviceList:
              lib.genAttrs serviceList
                (service: {
                  enable = true;
                });
          in
          enableServices cfg.plugins;
      }

      # Pipewire Modules:
      {
        services.pipewire.extraConfig.pipewire =
          let
            createLoopbacks =
              loopbackList:
              lib.mergeAttrsList
                (builtins.map
                  (
                    { fileName
                    , nodeName
                    , nodeDescription
                    , targetOutput
                    ,
                    }:
                    {
                      "${fileName}" = {
                        "context.modules" = [
                          {
                            name = "libpipewire-module-loopback";
                            args = {
                              "audio.position" = [
                                "FL"
                                "FR"
                              ];
                              "capture-props" = {
                                "media.class" = "Audio/Sink";
                                "node.name" = nodeName;
                                "node.description" = nodeDescription;
                              };
                              "playback-props" = {
                                "node.name" = "${nodeName}.output";
                                "node.passive" = true;
                                "target.object" = targetOutput;
                              };
                            };
                          }
                        ];
                      };
                    }
                  )
                  loopbackList);

            createSinks =
              sinkList:
              lib.mergeAttrsList
                (builtins.map
                  (
                    { fileName
                    , nodeName
                    , nodeDescription
                    , targets
                    ,
                    }:
                    {
                      "${fileName}" = {
                        "context.modules" = [
                          {
                            name = "libpipewire-module-combine-stream";
                            args = {
                              "combine.mode" = "sink";
                              "node.name" = nodeName;
                              "node.description" = nodeDescription;
                              "combine.props" = {
                                "audio.position" = [
                                  "FL"
                                  "FR"
                                ];
                                "media.class" = "Audio/Sink";
                              };
                              "stream.props" = {
                                "stream.dont.remix" = true;
                              };
                              "targets" = builtins.map
                                (target: {
                                  "target.object" = target;
                                })
                                targets;
                            };
                          }
                        ];
                      };
                    }
                  )
                  sinkList);
          in
          (if cfg.loopbackModules == [ ] then { } else createLoopbacks cfg.loopbackModules)
          // (if cfg.sinkModules == [ ] then { } else createSinks cfg.sinkModules);
      }

      # Wireplumber modules:
      {
        services.pipewire.wireplumber.extraConfig =
          let
            hidePorts = portList: builtins.map
              (port: {
                matches = [{ "node.name" = "${port}"; }];
                actions = { update-props = { "node.disabled" = true; }; };
              })
              portList;

            renamePorts = portList: builtins.map
              (port: {
                matches = [{ "node.name" = "${port.target}"; }];
                actions = { update-props = { "node.description" = port.newName; }; };
              })
              portList;

          in
          {
            "20-renamed-ports" = {
              "monitor.alsa.rules" = renamePorts cfg.renamedPorts;
            };
            "30-hidden-ports" = {
              "monitor.alsa.rules" = hidePorts cfg.hiddenPorts;
            };
          };
      }
    ]
  );
}
