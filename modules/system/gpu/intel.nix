{pkgs, cfg, lib, ... }: 

{
  hardware.graphics = {
    enable = true; 
    enable32Bit = true;

    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vpl-gpu-rt
      intel-compute-runtime
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [ intel-vaapi-driver ];
  };

  hardware.enableRedistributableFirmware = true;
  boot.kernelParams = [ "i915.enable_guc=3" ];

  environment.systemPackages = with pkgs; [
    intel-gpu-tools
    mesa
  ];
  
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}

