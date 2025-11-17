{ ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Force RADV
  environment.variables.AMD_VULKAN_ICD = "RADV";

  services.xserver.videoDrivers = ["amdgpu"];
}
