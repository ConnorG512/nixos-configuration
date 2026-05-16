{ config, lib, pkgs, ... }: 

let
  cfg = config.systemConfiguration.multimedia.gstreamer;
in 
{
  options.systemConfiguration.multimedia.gstreamer = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Gstreamer";
      example = true;
    };
    enableUgly = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable ugly codecs";
      example = true;
    };
    enableBad = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable bad codecs";
      example = true;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.video.enable {
      environment.systemPackages = [
        pkgs.gst_all_1.gstreamer
        pkgs.gst_all_1.gst-libav
        pkgs.gst_all_1.gst-vaapi
        pkgs.gst_all_1.gst-plugins-base
        pkgs.gst_all_1.gst-plugins-good
      ];

      environment.variables = {
        GST_PLUGIN_SYSTEM_PATH_1_0 = "/run/current-system/sw/lib/gstreamer-1.0";
      };
    })

    (lib.mkIf cfg.enableUgly {
      environment.systemPackages = [
        pkgs.gst_all_1.gst-plugins-ugly
      ];
    })
    
    (lib.mkIf cfg.enableBad {
      environment.systemPackages = [
        pkgs.gst_all_1.gst-plugins-bad
      ];
    })
  ];
}
