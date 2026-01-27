{ config, lib, pkgs, ... }:

let
  cfg = config.systemConfiguration.amdGpu;
in 
{
  options.systemConfiguration.amdGpu = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable AMDGPU drivers.";
      example = true;
    };

    enable32bit = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable 32 bit drivers.";
      example = false;
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32bit = cfg.enable32bit;
    };

    # Force RADV
    environment.variables.AMD_VULKAN_ICD = "RADV";

    services.xserver.videoDrivers = [ "amdgpu" ];
  };
}
