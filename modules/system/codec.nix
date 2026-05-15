{ config, lib, pkgs, ... }: 

let
  cfg = config.systemConfiguration.codec;
in 
{
  options.systemConfiguration.codec.video = {
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
        pkgs.gst_all_1.gst-vaapi
        pkgs.gst_all_1.gst-plugins-base
        pkgs.gst_all_1.gst-plugins-good
      ];
    })

    (lib.mkIf cfg.video.enableUgly {
      environment.systemPackages = [
        pkgs.gst_all_1.gst-plugins-ugly
      ];
    })
    
    (lib.mkIf cfg.video.enableBad {
      environment.systemPackages = [
        pkgs.gst_all_1.gst-plugins-bad
      ];
    })
  ];
}
