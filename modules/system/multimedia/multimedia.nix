{ config, lib, pkgs, ... }: 

let
  cfg = config.systemConfiguration.multimedia;
in 
{
  imports = [
    ./audio.nix
    ./gstreamer.nix
  ];

  options.systemConfiguration.multimedia = {
    enable = mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable the use of pipewire.";
      example = false;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      services.pipewire = true;
    })
  ];
}
